-- ============================================================
--  seed.sql — Nội dung lộ trình VIOLIN (giai đoạn, mục, tài liệu)
--  Sinh tự động từ gen_seed.py — chạy SAU 0001_init.sql và 0002_resources.sql.
-- ============================================================

insert into public.instruments (id, name, sort_order)
values ('violin', 'Violin', 1)
on conflict (id) do nothing;

-- ===== Giai đoạn 1: Âm thanh đầu tiên =====
insert into public.phases (id, instrument_id, number, pos, title, subtitle, daily, resources) values
  ('2efcd5eb-2121-4200-932f-bba5a0b16520', 'violin', 1, 'DÂY BUÔNG', 'Âm thanh đầu tiên', 'Làm quen với đàn, tư thế, và kéo ra một tiếng sạch.', '20–30’/ngày · 10’ tư thế + cầm vĩ, phần còn lại kéo dây buông trước gương.', 'App lên dây (Soundcorset / Tunable) · Suzuki Book 1 hoặc Essential Elements');

insert into public.modules (id, title, kind, scope, tradition) values
  ('56ed44d4-1f38-4ef8-802d-6fc705182064', 'Nhạc lý — Âm thanh đầu tiên', 'theory', 'shared', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '2efcd5eb-2121-4200-932f-bba5a0b16520', '56ed44d4-1f38-4ef8-802d-6fc705182064', 0);
insert into public.items (module_id, label, order_index) values
  ('56ed44d4-1f38-4ef8-802d-6fc705182064', 'Bảng chữ cái âm nhạc A–G và cách nó lặp lại', 0),
  ('56ed44d4-1f38-4ef8-802d-6fc705182064', 'Khuông nhạc 5 dòng và khóa Sol (violin đọc khóa Sol)', 1),
  ('56ed44d4-1f38-4ef8-802d-6fc705182064', 'Tên 4 dây buông: Sol – Rê – La – Mi (G–D–A–E)', 2),
  ('56ed44d4-1f38-4ef8-802d-6fc705182064', 'Trường độ: nốt tròn, trắng, đen, móc đơn', 3),
  ('56ed44d4-1f38-4ef8-802d-6fc705182064', 'Số chỉ nhịp 4/4 và 3/4, vạch nhịp', 4);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('56ed44d4-1f38-4ef8-802d-6fc705182064', 'interactive', 'Đọc nốt khoá Sol & trường độ', 'https://www.musictheory.net/lessons', 'musictheory.net', 0),
  ('56ed44d4-1f38-4ef8-802d-6fc705182064', 'interactive', 'Luyện đọc nốt và tiết tấu', 'https://www.musicca.com/music-theory-for-beginners', 'Musicca', 1);

insert into public.modules (id, title, kind, scope, tradition) values
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'Kỹ thuật — Âm thanh đầu tiên', 'technique', 'instrument', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '2efcd5eb-2121-4200-932f-bba5a0b16520', '3731e686-5e00-49b0-8bbb-568cf9cd349e', 1);
insert into public.items (module_id, label, order_index) values
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'Nhận biết các bộ phận của đàn và vĩ (archet)', 0),
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'Tư thế đứng/ngồi, đặt đàn lên vai – cằm', 1),
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'Cách cầm vĩ: ngón cái cong, ngón út tròn, cổ tay mềm', 2),
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'Lên dây bằng app/tuner', 3),
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'Bôi nhựa thông (rosin) và bảo quản đàn', 4),
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'Kéo vĩ thẳng trên từng dây buông, tiếng đều và không rít', 5);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'video', 'Cách cầm đàn và vĩ đúng', 'https://www.youtube.com/watch?v=fiz1O65fuYM', 'YouTube', 0),
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'video', 'Hướng dẫn cầm vĩ cho người mới', 'https://www.youtube.com/watch?v=EyP_FmfH7WM', 'YouTube', 1),
  ('3731e686-5e00-49b0-8bbb-568cf9cd349e', 'article', 'Cầm vĩ đúng theo 6 bước', 'https://violinspiration.com/how-to-hold-a-violin-bow/', 'Violinspiration', 2);

-- ===== Giai đoạn 2: Đặt ngón & đọc nốt =====
insert into public.phases (id, instrument_id, number, pos, title, subtitle, daily, resources) values
  ('87d5a6dc-8141-4f30-a9a1-adc28d660be1', 'violin', 2, 'THẾ TAY 1', 'Đặt ngón & đọc nốt', 'Tay trái lên dây, đọc được bản nhạc đầu tiên.', 'Tập gam thật chậm với máy gõ nhịp ~60 BPM, mỗi nốt một phách, nghe kỹ cao độ.', 'Suzuki 1 · Hřímalý (gam nhập môn)');

insert into public.modules (id, title, kind, scope, tradition) values
  ('8298e173-6f19-4312-b4df-e488f599e007', 'Nhạc lý — Đặt ngón & đọc nốt', 'theory', 'shared', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '87d5a6dc-8141-4f30-a9a1-adc28d660be1', '8298e173-6f19-4312-b4df-e488f599e007', 0);
insert into public.items (module_id, label, order_index) values
  ('8298e173-6f19-4312-b4df-e488f599e007', 'Dấu thăng (♯), giáng (♭), bình (♮)', 0),
  ('8298e173-6f19-4312-b4df-e488f599e007', 'Cung và nửa cung (whole / half step)', 1),
  ('8298e173-6f19-4312-b4df-e488f599e007', 'Hóa biểu: Rê trưởng, La trưởng, Sol trưởng', 2),
  ('8298e173-6f19-4312-b4df-e488f599e007', 'Đọc trôi chảy nốt trên khuông nhạc', 3);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('8298e173-6f19-4312-b4df-e488f599e007', 'interactive', 'Flashcard đọc nốt + hoá biểu', 'https://music-theory-practice.com/', 'Music Theory Practice', 0),
  ('8298e173-6f19-4312-b4df-e488f599e007', 'interactive', 'Dấu thăng/giáng, cung & nửa cung', 'https://www.musictheory.net/lessons', 'musictheory.net', 1);

insert into public.modules (id, title, kind, scope, tradition) values
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'Kỹ thuật — Đặt ngón & đọc nốt', 'technique', 'instrument', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '87d5a6dc-8141-4f30-a9a1-adc28d660be1', '70b87d88-1711-4f3b-8b2e-3e835837f119', 1);
insert into public.items (module_id, label, order_index) values
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'Khung tay trái, đặt 4 ngón ở thế 1 (dán băng định vị nếu cần)', 0),
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'Mẫu ngón (finger pattern) trên từng dây', 1),
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'Gam Rê trưởng & La trưởng một quãng tám', 2),
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'Bài đầu tiên: Twinkle, Lightly Row, dân ca', 3),
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'Détaché và slur 2 nốt cơ bản', 4);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'video', 'Đặt ngón thế 1 bằng tai', 'https://www.youtube.com/watch?v=MAMxamWnn-o', 'YouTube', 0),
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'video', 'Hướng dẫn vị trí ngón cho người mới', 'https://www.youtube.com/watch?v=9Bx7SiGoRbc', 'YouTube', 1),
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'article', 'Thế tay 1 — hướng dẫn đầy đủ', 'https://violinspiration.com/violin-first-position/', 'Violinspiration', 2),
  ('70b87d88-1711-4f3b-8b2e-3e835837f119', 'article', 'Bảng ngón thế 1 + sheet', 'https://violinlounge.com/article/violin-first-position-explained-with-finger-charts-notes-and-videos/', 'Violin Lounge', 3);

-- ===== Giai đoạn 3: Tiếng đẹp, nhịp vững =====
insert into public.phases (id, instrument_id, number, pos, title, subtitle, daily, resources) values
  ('51161fcf-5c10-48bf-88e2-14769c1853df', 'violin', 3, 'ÂM SẮC', 'Tiếng đẹp, nhịp vững', 'Kiểm soát vĩ để có âm thanh đều và giữ nhịp chắc.', 'Chia 3 phần: gam/âm sắc – étude – tiểu phẩm. Ghi âm lại để tự nghe.', 'Wohlfahrt Op. 45 · Suzuki 2–3');

insert into public.modules (id, title, kind, scope, tradition) values
  ('c126e001-9722-4435-98ef-d14560756166', 'Nhạc lý — Tiếng đẹp, nhịp vững', 'theory', 'shared', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '51161fcf-5c10-48bf-88e2-14769c1853df', 'c126e001-9722-4435-98ef-d14560756166', 0);
insert into public.items (module_id, label, order_index) values
  ('c126e001-9722-4435-98ef-d14560756166', 'Nhịp 6/8, nốt chấm dôi, dấu nối (tie)', 0),
  ('c126e001-9722-4435-98ef-d14560756166', 'Sắc thái: p, f, crescendo, diminuendo', 1),
  ('c126e001-9722-4435-98ef-d14560756166', 'Quãng (interval) cơ bản', 2);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('c126e001-9722-4435-98ef-d14560756166', 'interactive', 'Tiết tấu, nhịp 6/8, chấm dôi', 'https://www.musicca.com/music-theory-for-beginners', 'Musicca', 0),
  ('c126e001-9722-4435-98ef-d14560756166', 'article', 'Khuông, khoá, số chỉ nhịp', 'https://www.open.edu/openlearn/history-the-arts/music/an-introduction-music-theory/content-section-0', 'OpenLearn', 1);

insert into public.modules (id, title, kind, scope, tradition) values
  ('95d2d207-5bfa-42e2-b2e8-4547e50d790a', 'Kỹ thuật — Tiếng đẹp, nhịp vững', 'technique', 'instrument', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '51161fcf-5c10-48bf-88e2-14769c1853df', '95d2d207-5bfa-42e2-b2e8-4547e50d790a', 1);
insert into public.items (module_id, label, order_index) values
  ('95d2d207-5bfa-42e2-b2e8-4547e50d790a', 'Phân phối vĩ, điểm tiếp xúc (sounding point)', 0),
  ('95d2d207-5bfa-42e2-b2e8-4547e50d790a', 'Tiếng đều từ đầu đến cuối vĩ', 1),
  ('95d2d207-5bfa-42e2-b2e8-4547e50d790a', 'Chuyển dây mượt, không gằn', 2),
  ('95d2d207-5bfa-42e2-b2e8-4547e50d790a', 'Slur 2–4 nốt, legato', 3),
  ('95d2d207-5bfa-42e2-b2e8-4547e50d790a', 'Gam 2 quãng tám: Sol, Rê, La trưởng', 4);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('95d2d207-5bfa-42e2-b2e8-4547e50d790a', 'article', '10 bài tập vĩ cho âm sắc', 'https://violinspiration.com/violin-bowing-exercises/', 'Violinspiration', 0),
  ('95d2d207-5bfa-42e2-b2e8-4547e50d790a', 'video', 'Playlist kỹ thuật vĩ', 'https://www.youtube.com/playlist?list=PLVBTuGvv2_ia3IutNkfZqOoiI8PUsHRCo', 'Violin Lounge', 1),
  ('95d2d207-5bfa-42e2-b2e8-4547e50d790a', 'video', 'Mẹo làm chủ kỹ thuật vĩ', 'https://www.youtube.com/watch?v=ZRzcRfqKwlA', 'YouTube', 2);

-- ===== Giai đoạn 4: Chuyển thế & rung ngón =====
insert into public.phases (id, instrument_id, number, pos, title, subtitle, daily, resources) values
  ('4e0769b3-38a3-4ab9-80dc-d828d38470c3', 'violin', 4, 'THẾ 3 · VIBRATO', 'Chuyển thế & rung ngón', 'Lên thế 3 và bắt đầu vibrato — bước ngoặt về biểu cảm.', 'Vibrato tập riêng, rất chậm, như một bài thể dục cho cổ tay; đừng vội tăng tốc.', 'Kayser Op. 20 · Ševčík (chuyển thế)');

insert into public.modules (id, title, kind, scope, tradition) values
  ('e03376d3-4784-4d06-8701-b6239ac2b4b7', 'Nhạc lý — Chuyển thế & rung ngón', 'theory', 'shared', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '4e0769b3-38a3-4ab9-80dc-d828d38470c3', 'e03376d3-4784-4d06-8701-b6239ac2b4b7', 0);
insert into public.items (module_id, label, order_index) values
  ('e03376d3-4784-4d06-8701-b6239ac2b4b7', 'Gam thứ: tự nhiên, hòa thanh, giai điệu', 0),
  ('e03376d3-4784-4d06-8701-b6239ac2b4b7', 'Vòng quãng 5 (circle of fifths) nhập môn', 1),
  ('e03376d3-4784-4d06-8701-b6239ac2b4b7', 'Phân câu (phrasing) trong một giai điệu', 2);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('e03376d3-4784-4d06-8701-b6239ac2b4b7', 'interactive', 'Vòng quãng 5 & quan hệ giọng', 'https://music-theory-practice.com/', 'Music Theory Practice', 0);

insert into public.modules (id, title, kind, scope, tradition) values
  ('bc1076a6-1841-4c86-a1fd-e944feefbbce', 'Kỹ thuật — Chuyển thế & rung ngón', 'technique', 'instrument', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '4e0769b3-38a3-4ab9-80dc-d828d38470c3', 'bc1076a6-1841-4c86-a1fd-e944feefbbce', 1);
insert into public.items (module_id, label, order_index) values
  ('bc1076a6-1841-4c86-a1fd-e944feefbbce', 'Chuyển sang thế 3, bài tập trượt ngón', 0),
  ('bc1076a6-1841-4c86-a1fd-e944feefbbce', 'Vibrato cổ tay / cánh tay (tập thật chậm)', 1),
  ('bc1076a6-1841-4c86-a1fd-e944feefbbce', 'Martelé và staccato', 2),
  ('bc1076a6-1841-4c86-a1fd-e944feefbbce', 'Bắt đầu gam 3 quãng tám', 3),
  ('bc1076a6-1841-4c86-a1fd-e944feefbbce', 'Tiểu phẩm: Seitz, Vivaldi a-moll, Suzuki 4–5', 4);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('bc1076a6-1841-4c86-a1fd-e944feefbbce', 'article', 'Thế 3 — bảng nốt & bài tập', 'https://www.violinlounge.com/blog/violin-third-position-all-notes-finger-chart-and-exercises', 'Violin Lounge', 0),
  ('bc1076a6-1841-4c86-a1fd-e944feefbbce', 'article', 'Vibrato — hướng dẫn dễ hiểu', 'https://violinspiration.com/violin-vibrato/', 'Violinspiration', 1),
  ('bc1076a6-1841-4c86-a1fd-e944feefbbce', 'article', 'Vibrato — đầy đủ 7 bài tập', 'https://www.violinlounge.com/blog/violin-vibrato-complete-guide', 'Violin Lounge', 2);

-- ===== Giai đoạn 5: Làm chủ trung cấp =====
insert into public.phases (id, instrument_id, number, pos, title, subtitle, daily, resources) values
  ('03d67245-2cd3-437e-8fee-5aa654e2a422', 'violin', 5, 'THẾ 1–5', 'Làm chủ trung cấp', 'Chuyển thế trôi chảy, vĩ nảy (spiccato) và double stop.', 'Mỗi buổi chọn 1 kỹ thuật trọng tâm; quay vòng để không bỏ sót mảng nào.', 'Kreutzer 42 Studies · Mazas · Schradieck · Sitt');

insert into public.modules (id, title, kind, scope, tradition) values
  ('15bc7d24-a92e-44e1-9eeb-0b40fabcab72', 'Nhạc lý — Làm chủ trung cấp', 'theory', 'shared', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '03d67245-2cd3-437e-8fee-5aa654e2a422', '15bc7d24-a92e-44e1-9eeb-0b40fabcab72', 0);
insert into public.items (module_id, label, order_index) values
  ('15bc7d24-a92e-44e1-9eeb-0b40fabcab72', 'Toàn bộ vòng quãng 5, mọi giọng trưởng/thứ', 0),
  ('15bc7d24-a92e-44e1-9eeb-0b40fabcab72', 'Gam chromatic, tiết tấu phức tạp', 1),
  ('15bc7d24-a92e-44e1-9eeb-0b40fabcab72', 'Đọc tổng phổ cơ bản', 2);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('15bc7d24-a92e-44e1-9eeb-0b40fabcab72', 'interactive', 'Mọi giọng, gam chromatic', 'https://www.musictheory.net/lessons', 'musictheory.net', 0);

insert into public.modules (id, title, kind, scope, tradition) values
  ('195b202f-0757-4d23-a855-068d1de5b0cd', 'Kỹ thuật — Làm chủ trung cấp', 'technique', 'instrument', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '03d67245-2cd3-437e-8fee-5aa654e2a422', '195b202f-0757-4d23-a855-068d1de5b0cd', 1);
insert into public.items (module_id, label, order_index) values
  ('195b202f-0757-4d23-a855-068d1de5b0cd', 'Thông thạo thế 1–5, chuyển thế nhanh', 0),
  ('195b202f-0757-4d23-a855-068d1de5b0cd', 'Spiccato, sautillé (vĩ nảy)', 1),
  ('195b202f-0757-4d23-a855-068d1de5b0cd', 'Double stop: quãng 3, 6, octave nhập môn', 2),
  ('195b202f-0757-4d23-a855-068d1de5b0cd', 'Gam & rải hợp âm 3 quãng tám', 3),
  ('195b202f-0757-4d23-a855-068d1de5b0cd', 'Tiểu phẩm: Bach a-moll, Accolay, Vivaldi, Mozart', 4);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('195b202f-0757-4d23-a855-068d1de5b0cd', 'sheet', 'Étude: Kreutzer, Mazas… (miễn phí)', 'https://fiddlerman.com/studies-etudes-and-music/', 'Fiddlerman', 0),
  ('195b202f-0757-4d23-a855-068d1de5b0cd', 'article', 'Bài tập vĩ nâng cao', 'https://violinspiration.com/violin-bowing-exercises/', 'Violinspiration', 1),
  ('195b202f-0757-4d23-a855-068d1de5b0cd', 'sheet', 'Bản nhạc trung cấp (IMSLP)', 'https://imslp.org/wiki/Category:Easy_Works_for_Violin', 'IMSLP', 2);

-- ===== Giai đoạn 6: Nâng cao =====
insert into public.phases (id, instrument_id, number, pos, title, subtitle, daily, resources) values
  ('1befb86a-e394-4d37-a0ba-140e8d4381cd', 'violin', 6, 'TOÀN CẦN ĐÀN', 'Nâng cao', 'Mọi thế tay, kỹ thuật vĩ nâng cao, đại tác phẩm.', 'Học theo tác phẩm: rút kỹ thuật khó từ bản đang tập ra luyện riêng rồi ghép lại.', 'Kreutzer · Rode Caprices · Dont · Flesch Scale System');

insert into public.modules (id, title, kind, scope, tradition) values
  ('8ccdf124-270e-4bd3-a434-2b0005b3fbcc', 'Nhạc lý — Nâng cao', 'theory', 'shared', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '1befb86a-e394-4d37-a0ba-140e8d4381cd', '8ccdf124-270e-4bd3-a434-2b0005b3fbcc', 0);
insert into public.items (module_id, label, order_index) values
  ('8ccdf124-270e-4bd3-a434-2b0005b3fbcc', 'Hòa âm và phân tích tác phẩm nâng cao', 0),
  ('8ccdf124-270e-4bd3-a434-2b0005b3fbcc', 'Đọc bè dàn nhạc và nhạc thính phòng', 1);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('8ccdf124-270e-4bd3-a434-2b0005b3fbcc', 'interactive', 'Lý thuyết trung–cao cấp', 'https://www.musictheory.net/lessons', 'musictheory.net', 0);

insert into public.modules (id, title, kind, scope, tradition) values
  ('65a4b307-1b42-4ee0-a155-96736d4f71d0', 'Kỹ thuật — Nâng cao', 'technique', 'instrument', 'western');
insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values
  ('violin', '1befb86a-e394-4d37-a0ba-140e8d4381cd', '65a4b307-1b42-4ee0-a155-96736d4f71d0', 1);
insert into public.items (module_id, label, order_index) values
  ('65a4b307-1b42-4ee0-a155-96736d4f71d0', 'Mọi thế tay, chuyển thế xa chính xác', 0),
  ('65a4b307-1b42-4ee0-a155-96736d4f71d0', 'Ricochet, flying staccato, spiccato nhanh', 1),
  ('65a4b307-1b42-4ee0-a155-96736d4f71d0', 'Double stop thuần thục, octave, bồi âm (harmonic)', 2),
  ('65a4b307-1b42-4ee0-a155-96736d4f71d0', 'Hệ thống gam Flesch / Galamian', 3),
  ('65a4b307-1b42-4ee0-a155-96736d4f71d0', 'Tiểu phẩm: Bruch, Mendelssohn, Mozart, Bach Sonatas & Partitas', 4);
insert into public.resources (module_id, kind, title, url, source, sort) values
  ('65a4b307-1b42-4ee0-a155-96736d4f71d0', 'sheet', 'Bach, Mozart… cho violin (IMSLP)', 'https://imslp.org/wiki/Category:For_violin', 'IMSLP', 0),
  ('65a4b307-1b42-4ee0-a155-96736d4f71d0', 'sheet', 'Étude nâng cao: Kreutzer, Rode', 'https://fiddlerman.com/studies-etudes-and-music/', 'Fiddlerman', 1);

