#!/usr/bin/env python3
"""Sinh seed.sql cho nhạc cụ violin (giai đoạn, mục tick, và tài liệu học)."""
import uuid

PHASES = [
    {
        "pos": "DÂY BUÔNG", "title": "Âm thanh đầu tiên",
        "subtitle": "Làm quen với đàn, tư thế, và kéo ra một tiếng sạch.",
        "daily": "20–30’/ngày · 10’ tư thế + cầm vĩ, phần còn lại kéo dây buông trước gương.",
        "resources": "App lên dây (Soundcorset / Tunable) · Suzuki Book 1 hoặc Essential Elements",
        "theory": [
            "Bảng chữ cái âm nhạc A–G và cách nó lặp lại",
            "Khuông nhạc 5 dòng và khóa Sol (violin đọc khóa Sol)",
            "Tên 4 dây buông: Sol – Rê – La – Mi (G–D–A–E)",
            "Trường độ: nốt tròn, trắng, đen, móc đơn",
            "Số chỉ nhịp 4/4 và 3/4, vạch nhịp",
        ],
        "technique": [
            "Nhận biết các bộ phận của đàn và vĩ (archet)",
            "Tư thế đứng/ngồi, đặt đàn lên vai – cằm",
            "Cách cầm vĩ: ngón cái cong, ngón út tròn, cổ tay mềm",
            "Lên dây bằng app/tuner",
            "Bôi nhựa thông (rosin) và bảo quản đàn",
            "Kéo vĩ thẳng trên từng dây buông, tiếng đều và không rít",
        ],
        "res_theory": [
            ("interactive", "Đọc nốt khoá Sol & trường độ", "https://www.musictheory.net/lessons", "musictheory.net"),
            ("interactive", "Luyện đọc nốt và tiết tấu", "https://www.musicca.com/music-theory-for-beginners", "Musicca"),
        ],
        "res_technique": [
            ("video", "Cách cầm đàn và vĩ đúng", "https://www.youtube.com/watch?v=fiz1O65fuYM", "YouTube"),
            ("video", "Hướng dẫn cầm vĩ cho người mới", "https://www.youtube.com/watch?v=EyP_FmfH7WM", "YouTube"),
            ("article", "Cầm vĩ đúng theo 6 bước", "https://violinspiration.com/how-to-hold-a-violin-bow/", "Violinspiration"),
        ],
    },
    {
        "pos": "THẾ TAY 1", "title": "Đặt ngón & đọc nốt",
        "subtitle": "Tay trái lên dây, đọc được bản nhạc đầu tiên.",
        "daily": "Tập gam thật chậm với máy gõ nhịp ~60 BPM, mỗi nốt một phách, nghe kỹ cao độ.",
        "resources": "Suzuki 1 · Hřímalý (gam nhập môn)",
        "theory": [
            "Dấu thăng (♯), giáng (♭), bình (♮)",
            "Cung và nửa cung (whole / half step)",
            "Hóa biểu: Rê trưởng, La trưởng, Sol trưởng",
            "Đọc trôi chảy nốt trên khuông nhạc",
        ],
        "technique": [
            "Khung tay trái, đặt 4 ngón ở thế 1 (dán băng định vị nếu cần)",
            "Mẫu ngón (finger pattern) trên từng dây",
            "Gam Rê trưởng & La trưởng một quãng tám",
            "Bài đầu tiên: Twinkle, Lightly Row, dân ca",
            "Détaché và slur 2 nốt cơ bản",
        ],
        "res_theory": [
            ("interactive", "Flashcard đọc nốt + hoá biểu", "https://music-theory-practice.com/", "Music Theory Practice"),
            ("interactive", "Dấu thăng/giáng, cung & nửa cung", "https://www.musictheory.net/lessons", "musictheory.net"),
        ],
        "res_technique": [
            ("video", "Đặt ngón thế 1 bằng tai", "https://www.youtube.com/watch?v=MAMxamWnn-o", "YouTube"),
            ("video", "Hướng dẫn vị trí ngón cho người mới", "https://www.youtube.com/watch?v=9Bx7SiGoRbc", "YouTube"),
            ("article", "Thế tay 1 — hướng dẫn đầy đủ", "https://violinspiration.com/violin-first-position/", "Violinspiration"),
            ("article", "Bảng ngón thế 1 + sheet", "https://violinlounge.com/article/violin-first-position-explained-with-finger-charts-notes-and-videos/", "Violin Lounge"),
        ],
    },
    {
        "pos": "ÂM SẮC", "title": "Tiếng đẹp, nhịp vững",
        "subtitle": "Kiểm soát vĩ để có âm thanh đều và giữ nhịp chắc.",
        "daily": "Chia 3 phần: gam/âm sắc – étude – tiểu phẩm. Ghi âm lại để tự nghe.",
        "resources": "Wohlfahrt Op. 45 · Suzuki 2–3",
        "theory": [
            "Nhịp 6/8, nốt chấm dôi, dấu nối (tie)",
            "Sắc thái: p, f, crescendo, diminuendo",
            "Quãng (interval) cơ bản",
        ],
        "technique": [
            "Phân phối vĩ, điểm tiếp xúc (sounding point)",
            "Tiếng đều từ đầu đến cuối vĩ",
            "Chuyển dây mượt, không gằn",
            "Slur 2–4 nốt, legato",
            "Gam 2 quãng tám: Sol, Rê, La trưởng",
        ],
        "res_theory": [
            ("interactive", "Tiết tấu, nhịp 6/8, chấm dôi", "https://www.musicca.com/music-theory-for-beginners", "Musicca"),
            ("article", "Khuông, khoá, số chỉ nhịp", "https://www.open.edu/openlearn/history-the-arts/music/an-introduction-music-theory/content-section-0", "OpenLearn"),
        ],
        "res_technique": [
            ("article", "10 bài tập vĩ cho âm sắc", "https://violinspiration.com/violin-bowing-exercises/", "Violinspiration"),
            ("video", "Playlist kỹ thuật vĩ", "https://www.youtube.com/playlist?list=PLVBTuGvv2_ia3IutNkfZqOoiI8PUsHRCo", "Violin Lounge"),
            ("video", "Mẹo làm chủ kỹ thuật vĩ", "https://www.youtube.com/watch?v=ZRzcRfqKwlA", "YouTube"),
        ],
    },
    {
        "pos": "THẾ 3 · VIBRATO", "title": "Chuyển thế & rung ngón",
        "subtitle": "Lên thế 3 và bắt đầu vibrato — bước ngoặt về biểu cảm.",
        "daily": "Vibrato tập riêng, rất chậm, như một bài thể dục cho cổ tay; đừng vội tăng tốc.",
        "resources": "Kayser Op. 20 · Ševčík (chuyển thế)",
        "theory": [
            "Gam thứ: tự nhiên, hòa thanh, giai điệu",
            "Vòng quãng 5 (circle of fifths) nhập môn",
            "Phân câu (phrasing) trong một giai điệu",
        ],
        "technique": [
            "Chuyển sang thế 3, bài tập trượt ngón",
            "Vibrato cổ tay / cánh tay (tập thật chậm)",
            "Martelé và staccato",
            "Bắt đầu gam 3 quãng tám",
            "Tiểu phẩm: Seitz, Vivaldi a-moll, Suzuki 4–5",
        ],
        "res_theory": [
            ("interactive", "Vòng quãng 5 & quan hệ giọng", "https://music-theory-practice.com/", "Music Theory Practice"),
        ],
        "res_technique": [
            ("article", "Thế 3 — bảng nốt & bài tập", "https://www.violinlounge.com/blog/violin-third-position-all-notes-finger-chart-and-exercises", "Violin Lounge"),
            ("article", "Vibrato — hướng dẫn dễ hiểu", "https://violinspiration.com/violin-vibrato/", "Violinspiration"),
            ("article", "Vibrato — đầy đủ 7 bài tập", "https://www.violinlounge.com/blog/violin-vibrato-complete-guide", "Violin Lounge"),
        ],
    },
    {
        "pos": "THẾ 1–5", "title": "Làm chủ trung cấp",
        "subtitle": "Chuyển thế trôi chảy, vĩ nảy (spiccato) và double stop.",
        "daily": "Mỗi buổi chọn 1 kỹ thuật trọng tâm; quay vòng để không bỏ sót mảng nào.",
        "resources": "Kreutzer 42 Studies · Mazas · Schradieck · Sitt",
        "theory": [
            "Toàn bộ vòng quãng 5, mọi giọng trưởng/thứ",
            "Gam chromatic, tiết tấu phức tạp",
            "Đọc tổng phổ cơ bản",
        ],
        "technique": [
            "Thông thạo thế 1–5, chuyển thế nhanh",
            "Spiccato, sautillé (vĩ nảy)",
            "Double stop: quãng 3, 6, octave nhập môn",
            "Gam & rải hợp âm 3 quãng tám",
            "Tiểu phẩm: Bach a-moll, Accolay, Vivaldi, Mozart",
        ],
        "res_theory": [
            ("interactive", "Mọi giọng, gam chromatic", "https://www.musictheory.net/lessons", "musictheory.net"),
        ],
        "res_technique": [
            ("sheet", "Étude: Kreutzer, Mazas… (miễn phí)", "https://fiddlerman.com/studies-etudes-and-music/", "Fiddlerman"),
            ("article", "Bài tập vĩ nâng cao", "https://violinspiration.com/violin-bowing-exercises/", "Violinspiration"),
            ("sheet", "Bản nhạc trung cấp (IMSLP)", "https://imslp.org/wiki/Category:Easy_Works_for_Violin", "IMSLP"),
        ],
    },
    {
        "pos": "TOÀN CẦN ĐÀN", "title": "Nâng cao",
        "subtitle": "Mọi thế tay, kỹ thuật vĩ nâng cao, đại tác phẩm.",
        "daily": "Học theo tác phẩm: rút kỹ thuật khó từ bản đang tập ra luyện riêng rồi ghép lại.",
        "resources": "Kreutzer · Rode Caprices · Dont · Flesch Scale System",
        "theory": [
            "Hòa âm và phân tích tác phẩm nâng cao",
            "Đọc bè dàn nhạc và nhạc thính phòng",
        ],
        "technique": [
            "Mọi thế tay, chuyển thế xa chính xác",
            "Ricochet, flying staccato, spiccato nhanh",
            "Double stop thuần thục, octave, bồi âm (harmonic)",
            "Hệ thống gam Flesch / Galamian",
            "Tiểu phẩm: Bruch, Mendelssohn, Mozart, Bach Sonatas & Partitas",
        ],
        "res_theory": [
            ("interactive", "Lý thuyết trung–cao cấp", "https://www.musictheory.net/lessons", "musictheory.net"),
        ],
        "res_technique": [
            ("sheet", "Bach, Mozart… cho violin (IMSLP)", "https://imslp.org/wiki/Category:For_violin", "IMSLP"),
            ("sheet", "Étude nâng cao: Kreutzer, Rode", "https://fiddlerman.com/studies-etudes-and-music/", "Fiddlerman"),
        ],
    },
]


def sq(s: str) -> str:
    return s.replace("'", "''")


def main():
    out = [
        "-- ============================================================",
        "--  seed.sql — Nội dung lộ trình VIOLIN (giai đoạn, mục, tài liệu)",
        "--  Sinh tự động từ gen_seed.py — chạy SAU 0001_init.sql và 0002_resources.sql.",
        "-- ============================================================",
        "",
        "insert into public.instruments (id, name, sort_order)",
        "values ('violin', 'Violin', 1)",
        "on conflict (id) do nothing;",
        "",
    ]

    for idx, ph in enumerate(PHASES, start=1):
        phase_id = str(uuid.uuid4())
        out.append(f"-- ===== Giai đoạn {idx}: {ph['title']} =====")
        out.append("insert into public.phases (id, instrument_id, number, pos, title, subtitle, daily, resources) values")
        out.append(
            f"  ('{phase_id}', 'violin', {idx}, '{sq(ph['pos'])}', '{sq(ph['title'])}', "
            f"'{sq(ph['subtitle'])}', '{sq(ph['daily'])}', '{sq(ph['resources'])}');"
        )
        out.append("")

        for order, kind in enumerate(("theory", "technique")):
            module_id = str(uuid.uuid4())
            scope = "shared" if kind == "theory" else "instrument"
            title = ("Nhạc lý — " if kind == "theory" else "Kỹ thuật — ") + ph["title"]
            out.append("insert into public.modules (id, title, kind, scope, tradition) values")
            out.append(f"  ('{module_id}', '{sq(title)}', '{kind}', '{scope}', 'western');")
            out.append("insert into public.instrument_modules (instrument_id, phase_id, module_id, order_in_phase) values")
            out.append(f"  ('violin', '{phase_id}', '{module_id}', {order});")

            out.append("insert into public.items (module_id, label, order_index) values")
            rows = [f"  ('{module_id}', '{sq(label)}', {i})" for i, label in enumerate(ph[kind])]
            out.append(",\n".join(rows) + ";")

            res = ph["res_theory"] if kind == "theory" else ph["res_technique"]
            if res:
                out.append("insert into public.resources (module_id, kind, title, url, source, sort) values")
                rrows = [
                    f"  ('{module_id}', '{rk}', '{sq(rt)}', '{sq(ru)}', '{sq(rs)}', {i})"
                    for i, (rk, rt, ru, rs) in enumerate(res)
                ]
                out.append(",\n".join(rrows) + ";")
            out.append("")

    text = "\n".join(out) + "\n"
    with open("seed.sql", "w", encoding="utf-8") as f:
        f.write(text)
    print("seed.sql written:", len(text), "bytes")


if __name__ == "__main__":
    main()
