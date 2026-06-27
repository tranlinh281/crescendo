-- ============================================================
--  0002_resources.sql — Tài liệu học (video, bài viết, sheet)
--  Chạy SAU 0001_init.sql, TRƯỚC seed.sql.
-- ============================================================

create table public.resources (
  id        uuid primary key default gen_random_uuid(),
  module_id uuid not null references public.modules(id) on delete cascade,
  kind      text not null default 'article'
              check (kind in ('video','article','interactive','sheet')),
  title     text not null,
  url       text not null,
  source    text,
  sort      int  not null default 0
);

create index on public.resources (module_id);

-- Tài liệu là nội dung khoá học → ai cũng đọc được (chỉ đọc).
alter table public.resources enable row level security;
create policy "content public read" on public.resources for select using (true);
