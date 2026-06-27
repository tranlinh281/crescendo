import { useEffect, useState, useMemo, useCallback } from 'react';
import { supabase } from '../supabaseClient';
import PhaseCard from './PhaseCard.jsx';

const INSTRUMENT = 'violin'; // sau này truyền vào qua props để đổi nhạc cụ

export default function Roadmap({ session }) {
  const [phases, setPhases] = useState([]);
  const [done, setDone] = useState(() => new Set());
  const [status, setStatus] = useState('loading'); // 'loading' | 'ready' | 'error'
  const [active, setActive] = useState(null); // { resource, phase } đang mở trong panel
  const userId = session.user.id;

  const openResource = useCallback((resource, phase) => setActive({ resource, phase }), []);
  const closePanel = useCallback(() => setActive(null), []);

  // Tải nội dung lộ trình + tiến độ của user (chạy lại nếu đổi user).
  useEffect(() => {
    let alive = true;
    (async () => {
      try {
        // Một truy vấn lồng nhau: phases → instrument_modules → modules → items.
        // PostgREST tự suy ra quan hệ nhờ khóa ngoại đã khai báo ở migration.
        const { data: phaseRows, error: e1 } = await supabase
          .from('phases')
          .select(
            `id, number, pos, title, subtitle, daily, resources,
             instrument_modules ( order_in_phase,
               modules ( id, kind,
                 items ( id, label, order_index ),
                 resources ( id, kind, title, url, source, sort )
               )
             )`
          )
          .eq('instrument_id', INSTRUMENT)
          .order('number');
        if (e1) throw e1;

        // RLS chỉ trả về tiến độ của chính user này.
        const { data: prog, error: e2 } = await supabase
          .from('user_progress')
          .select('item_id');
        if (e2) throw e2;

        if (!alive) return;
        setPhases(shape(phaseRows));
        setDone(new Set(prog.map((p) => p.item_id)));
        setStatus('ready');
      } catch (err) {
        console.error(err);
        if (alive) setStatus('error');
      }
    })();
    return () => {
      alive = false;
    };
  }, [userId]);

  // Tick / bỏ tick: cập nhật giao diện ngay (optimistic), rồi ghi vào DB.
  const toggle = useCallback(
    async (itemId) => {
      const wasDone = done.has(itemId);
      setDone((prev) => {
        const next = new Set(prev);
        if (wasDone) next.delete(itemId);
        else next.add(itemId);
        return next;
      });
      try {
        if (wasDone) {
          const { error } = await supabase
            .from('user_progress')
            .delete()
            .eq('user_id', userId)
            .eq('item_id', itemId);
          if (error) throw error;
        } else {
          const { error } = await supabase
            .from('user_progress')
            .insert({ user_id: userId, item_id: itemId });
          if (error) throw error;
        }
      } catch (err) {
        console.error(err);
        // Lỗi → hoàn tác để giao diện khớp lại với DB.
        setDone((prev) => {
          const next = new Set(prev);
          if (wasDone) next.add(itemId);
          else next.delete(itemId);
          return next;
        });
      }
    },
    [done, userId]
  );

  const totals = useMemo(() => {
    const all = phases.flatMap((p) => [...p.theory, ...p.technique]).map((i) => i.id);
    const completed = all.filter((id) => done.has(id)).length;
    return { all: all.length, completed };
  }, [phases, done]);

  if (status === 'loading') return <p className="cr-loading">Đang tải lộ trình…</p>;
  if (status === 'error')
    return (
      <p className="cr-loading">
        Không tải được dữ liệu. Kiểm tra kết nối Supabase và đã chạy migration + seed chưa.
      </p>
    );

  const pct = totals.all ? Math.round((totals.completed / totals.all) * 100) : 0;

  return (
    <main className="cr-roadmap">
      <header className="cr-hero">
        <span className="cr-eyebrow">LỘ TRÌNH VIOLIN · TỪ SỐ 0</span>
        <h1 className="cr-h1">
          Từ dây buông<br />
          đến bản giao hưởng
        </h1>
        <div className="cr-progress-summary">
          <div className="cr-bar">
            <div className="cr-bar-fill" style={{ width: pct + '%' }} />
          </div>
          <span className="cr-pct">
            {pct}% · {totals.completed}/{totals.all} mục
          </span>
        </div>
      </header>

      <div className={'cr-workspace' + (active ? ' cr-has-panel' : '')}>
        <div className="cr-roadmap-list">
          {phases.map((p) => (
            <PhaseCard
              key={p.id}
              phase={p}
              done={done}
              onToggle={toggle}
              onOpenResource={openResource}
              activeResourceId={active?.resource?.id}
              isActive={active?.phase?.id === p.id}
            />
          ))}
        </div>

        {active && (
          <ResourcePanel
            resource={active.resource}
            phase={active.phase}
            onClose={closePanel}
          />
        )}
      </div>
    </main>
  );
}

// Đổi link YouTube thành link nhúng được; các trang khác để nguyên (có thể bị chặn).
function toEmbed(url) {
  try {
    const u = new URL(url);
    const host = u.hostname.replace(/^www\.|^m\./, '');
    if (host === 'youtube.com') {
      const v = u.searchParams.get('v');
      const list = u.searchParams.get('list');
      if (u.pathname === '/watch' && v)
        return { embeddable: true, src: `https://www.youtube-nocookie.com/embed/${v}` };
      if (u.pathname === '/playlist' && list)
        return { embeddable: true, src: `https://www.youtube-nocookie.com/embed/videoseries?list=${list}` };
      if (u.pathname.startsWith('/embed/')) return { embeddable: true, src: url };
    }
    if (host === 'youtu.be') {
      const id = u.pathname.slice(1);
      if (id) return { embeddable: true, src: `https://www.youtube-nocookie.com/embed/${id}` };
    }
    return { embeddable: false, src: url };
  } catch {
    return { embeddable: false, src: url };
  }
}

function ResourcePanel({ resource, phase, onClose }) {
  const { embeddable, src } = toEmbed(resource.url);
  return (
    <aside className="cr-panel">
      <div className="cr-panel-head">
        <div className="cr-panel-ctx">
          <span className="cr-panel-phase">
            Giai đoạn {phase.number} · {phase.title}
          </span>
          <span className="cr-panel-title">{resource.title}</span>
        </div>
        <div className="cr-panel-actions">
          <a
            className="cr-panel-btn"
            href={resource.url}
            target="_blank"
            rel="noopener noreferrer"
            aria-label="Mở ở tab mới"
            title="Mở ở tab mới"
          >
            ↗
          </a>
          <button className="cr-panel-btn cr-panel-close" onClick={onClose} aria-label="Đóng">
            ✕
          </button>
        </div>
      </div>

      {!embeddable && (
        <p className="cr-panel-note">
          Một số trang chặn nhúng. Nếu khung dưới trống, bấm ↗ để mở ở tab mới.
        </p>
      )}

      <div className="cr-panel-frame">
        <iframe
          key={src}
          src={src}
          title={resource.title}
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share; fullscreen"
          allowFullScreen
          referrerPolicy="no-referrer-when-downgrade"
        />
      </div>
    </aside>
  );
}

// Biến dữ liệu lồng nhau từ Supabase thành cấu trúc phẳng dễ render:
// mỗi phase có sẵn 2 mảng items theo cột (theory / technique), đã sắp xếp.
function shape(rows) {
  return rows.map((ph) => {
    const mods = (ph.instrument_modules || [])
      .slice()
      .sort((a, b) => a.order_in_phase - b.order_in_phase)
      .map((im) => im.modules)
      .filter(Boolean);

    const collect = (kind) =>
      mods
        .filter((m) => m.kind === kind)
        .flatMap((m) =>
          (m.items || []).slice().sort((a, b) => a.order_index - b.order_index)
        );

    const collectRes = (kind) =>
      mods
        .filter((m) => m.kind === kind)
        .flatMap((m) =>
          (m.resources || []).slice().sort((a, b) => a.sort - b.sort)
        );

    return {
      id: ph.id,
      number: ph.number,
      pos: ph.pos,
      title: ph.title,
      subtitle: ph.subtitle,
      daily: ph.daily,
      resources: ph.resources,
      theory: collect('theory'),
      technique: collect('technique'),
      theoryResources: collectRes('theory'),
      techniqueResources: collectRes('technique'),
    };
  });
}
