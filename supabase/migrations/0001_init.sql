-- ============================================================
--  0001_init.sql — Nền tảng học nhạc đa nhạc cụ
--  Chạy file này trong Supabase: SQL Editor → New query → Run.
-- ============================================================

-- ---------- PROFILES (mở rộng auth.users) -------------------
create table public.profiles (
  id           uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  created_at   timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "profile readable by owner"
  on public.profiles for select using (auth.uid() = id);
create policy "profile updatable by owner"
  on public.profiles for update using (auth.uid() = id);

-- Tự tạo profile mỗi khi có user mới đăng ký
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, display_name)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1))
  );
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ---------- NHẠC CỤ -----------------------------------------
create table public.instruments (
  id         text primary key,          -- 'violin', 'guitar', 'sao_truc'
  name       text not null,
  sort_order int  not null default 0
);

-- ---------- GIAI ĐOẠN (thuộc một nhạc cụ) -------------------
create table public.phases (
  id            uuid primary key default gen_random_uuid(),
  instrument_id text not null references public.instruments(id) on delete cascade,
  number        int  not null,
  pos           text,
  title         text not null,
  subtitle      text,
  daily         text,
  resources     text,
  unique (instrument_id, number)
);

-- ---------- MODULE (đơn vị học, TÁI SỬ DỤNG được) -----------
--  scope='shared'     → nhạc lý dùng chung nhiều nhạc cụ
--  scope='instrument' → riêng cho một nhạc cụ
create table public.modules (
  id        uuid primary key default gen_random_uuid(),
  title     text not null,
  kind      text not null default 'theory'
              check (kind in ('theory','technique','repertoire')),
  scope     text not null default 'instrument'
              check (scope in ('shared','instrument')),
  tradition text not null default 'western'   -- 'western' | 'vietnamese_traditional'
);

-- ---------- JOIN: đặt module vào 1 giai đoạn của 1 nhạc cụ --
--  Đây là MẤU CHỐT cho việc scale: cùng một module nhạc lý
--  dùng chung có thể gắn cho violin, guitar, sáo… ở các giai
--  đoạn khác nhau mà không phải nhân bản nội dung.
create table public.instrument_modules (
  id             uuid primary key default gen_random_uuid(),
  instrument_id  text not null references public.instruments(id) on delete cascade,
  phase_id       uuid not null references public.phases(id) on delete cascade,
  module_id      uuid not null references public.modules(id) on delete cascade,
  order_in_phase int  not null default 0,
  unique (instrument_id, module_id)
);

-- ---------- MỤC CÓ THỂ TICK ---------------------------------
create table public.items (
  id          uuid primary key default gen_random_uuid(),
  module_id   uuid not null references public.modules(id) on delete cascade,
  label       text not null,
  order_index int  not null default 0
);

-- ---------- TIẾN ĐỘ THEO USER -------------------------------
create table public.user_progress (
  user_id      uuid not null references auth.users(id) on delete cascade,
  item_id      uuid not null references public.items(id) on delete cascade,
  completed_at timestamptz not null default now(),
  primary key (user_id, item_id)
);

-- ---------- RLS ---------------------------------------------
-- Nội dung khoá học: ai cũng ĐỌC được lộ trình (chỉ đọc).
alter table public.instruments        enable row level security;
alter table public.phases             enable row level security;
alter table public.modules            enable row level security;
alter table public.instrument_modules enable row level security;
alter table public.items              enable row level security;

create policy "content public read" on public.instruments        for select using (true);
create policy "content public read" on public.phases             for select using (true);
create policy "content public read" on public.modules            for select using (true);
create policy "content public read" on public.instrument_modules for select using (true);
create policy "content public read" on public.items              for select using (true);

-- Tiến độ: mỗi user CHỈ thấy/sửa của chính mình.
alter table public.user_progress enable row level security;

create policy "read own progress"   on public.user_progress
  for select using (auth.uid() = user_id);
create policy "insert own progress" on public.user_progress
  for insert with check (auth.uid() = user_id);
create policy "delete own progress" on public.user_progress
  for delete using (auth.uid() = user_id);

-- ---------- INDEX -------------------------------------------
create index on public.phases             (instrument_id);
create index on public.instrument_modules (phase_id);
create index on public.items              (module_id);
create index on public.user_progress      (user_id);
