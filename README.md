# Crescendo — nền tảng học nhạc đa nhạc cụ

_Tên cũ: Lộ trình học nhạc._ Vite + React + Supabase

Web app học violin từ số 0, có **đăng ký/đăng nhập thật** và **tiến độ lưu theo từng user** trong database (bảo vệ bằng Row Level Security). Thiết kế sẵn để scale sang nhiều nhạc cụ (guitar, sáo trúc…).

## 1. Tạo project Supabase

1. Vào https://supabase.com → tạo project mới (free tier là đủ).
2. Mở **SQL Editor → New query**, chạy lần lượt:
   - `supabase/migrations/0001_init.sql` (bảng + RLS + trigger profile)
   - `supabase/migrations/0002_resources.sql` (bảng tài liệu học)
3. Tạo query mới, chạy `supabase/seed.sql` — nội dung lộ trình violin kèm video/bài viết/sheet cho từng giai đoạn.
4. Vào **Project Settings → API**, copy `Project URL` và `anon public` key.

> Mẹo khi dev: vào **Authentication → Providers → Email** và **tắt "Confirm email"**
> để đăng ký xong đăng nhập được ngay, khỏi chờ mail xác nhận.

## 2. Chạy app

```bash
cp .env.example .env      # rồi điền URL + anon key vừa copy
npm install
npm run dev
```

Mở địa chỉ Vite in ra (mặc định http://localhost:5173). Đăng ký một tài khoản,
đăng nhập, rồi tick các mục — F5 lại vẫn còn, đăng nhập ở máy khác cũng thấy đúng
tiến độ của mình.

## 3. Cấu trúc

```
src/
  supabaseClient.js      # khởi tạo client từ biến môi trường
  App.jsx                # quản lý phiên đăng nhập (session) — cổng phân nhánh
  components/
    Auth.jsx             # form đăng ký / đăng nhập thật
    Roadmap.jsx          # tải nội dung + tiến độ, xử lý tick (optimistic update)
    PhaseCard.jsx        # hiển thị một giai đoạn (component "thuần hiển thị")
    Metronome.jsx        # máy gõ nhịp (Web Audio, không cần backend)
supabase/
  migrations/0001_init.sql   # schema + RLS + trigger tạo profile
  seed.sql                   # nội dung violin (sinh từ gen_seed.py)
  gen_seed.py                # script sinh seed.sql
```

## 4. Vì sao nhạc lý không bị nhân bản — và cách thêm nhạc cụ mới

Bảng `modules` có cột `scope`: `shared` cho nhạc lý dùng chung, `instrument` cho
phần riêng từng nhạc cụ. Bảng nối `instrument_modules` đặt một module vào một giai
đoạn của một nhạc cụ. Nhờ đó **một module nhạc lý dùng chung gắn được cho nhiều
nhạc cụ** thay vì chép lại.

Để thêm guitar:

1. `insert into instruments (id, name) values ('guitar', 'Guitar');`
2. Tạo `phases` cho guitar.
3. Với mỗi module nhạc lý `scope='shared'` muốn tái dùng, thêm một dòng vào
   `instrument_modules` trỏ tới `phase_id` của guitar — **không tạo lại nội dung**.
4. Chỉ viết mới phần riêng của guitar (tablature, hợp âm, ánh xạ phím) dưới dạng
   module `scope='instrument'`.

Cho sáo trúc chơi nhạc dân tộc: tạo module với `tradition='vietnamese_traditional'`
(ngũ cung, điệu thức, nhấn/rung) thành một nhánh lý thuyết riêng, vì lõi phương Tây
không phủ hết.

Cuối cùng, trong `Roadmap.jsx` đổi hằng `INSTRUMENT` thành props để chọn nhạc cụ
hiển thị, và thêm một màn chọn nhạc cụ ở trên.

## Ghi chú bảo mật

RLS đảm bảo mỗi user chỉ đọc/ghi được tiến độ của chính mình — kiểm tra nằm ở tầng
database, không phụ thuộc code app. Nội dung khoá học để `select` công khai (ai cũng
xem được lộ trình), nhưng không ai sửa được trừ qua dashboard/service role.
