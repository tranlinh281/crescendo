export default function PhaseCard({
  phase,
  done,
  onToggle,
  onOpenResource,
  activeResourceId,
  isActive,
}) {
  const ids = [...phase.theory, ...phase.technique].map((i) => i.id);
  const completed = ids.filter((id) => done.has(id)).length;
  const pct = ids.length ? Math.round((completed / ids.length) * 100) : 0;
  const openResource = (resource) => onOpenResource(resource, phase);

  return (
    <article className={'cr-phase' + (isActive ? ' cr-phase-active' : '')}>
      <div className="cr-phase-rail">
        <span className="cr-phase-num">{String(phase.number).padStart(2, '0')}</span>
        <span className="cr-phase-pos">{phase.pos}</span>
      </div>

      <div className="cr-phase-main">
        <h3 className="cr-phase-title">{phase.title}</h3>
        <p className="cr-phase-sub">{phase.subtitle}</p>

        <div className="cr-phase-progress">
          <div className="cr-phase-bar">
            <div className="cr-phase-fill" style={{ width: pct + '%' }} />
          </div>
          <span className="cr-phase-count">
            {completed}/{ids.length}
          </span>
        </div>

        <div className="cr-cols">
          <Column
            title="Nhạc lý"
            items={phase.theory}
            resources={phase.theoryResources}
            done={done}
            onToggle={onToggle}
            onOpen={openResource}
            activeId={activeResourceId}
          />
          <Column
            title="Kỹ thuật & thực hành"
            items={phase.technique}
            resources={phase.techniqueResources}
            done={done}
            onToggle={onToggle}
            onOpen={openResource}
            activeId={activeResourceId}
          />
        </div>

        <div className="cr-phase-foot">
          {phase.daily && (
            <p className="cr-daily">
              <span className="cr-tag">Mỗi ngày</span>
              {phase.daily}
            </p>
          )}
          {phase.resources && (
            <p className="cr-res">
              <span className="cr-tag">Tài liệu</span>
              {phase.resources}
            </p>
          )}
        </div>
      </div>
    </article>
  );
}

function Column({ title, items, resources, done, onToggle, onOpen, activeId }) {
  return (
    <div className="cr-col">
      <h4 className="cr-col-title">{title}</h4>
      <ul className="cr-list">
        {items.map((it) => {
          const checked = done.has(it.id);
          return (
            <li key={it.id} className={'cr-item' + (checked ? ' cr-item-done' : '')}>
              <button
                className="cr-check"
                role="checkbox"
                aria-checked={checked}
                onClick={() => onToggle(it.id)}
              >
                <span className="cr-check-box">{checked ? '✓' : ''}</span>
                <span className="cr-check-label">{it.label}</span>
              </button>
            </li>
          );
        })}
      </ul>
      <Resources items={resources} onOpen={onOpen} activeId={activeId} />
    </div>
  );
}

const KIND_LABEL = {
  video: 'Video',
  article: 'Bài viết',
  interactive: 'Tương tác',
  sheet: 'Bản nhạc',
};

function Resources({ items, onOpen, activeId }) {
  if (!items || items.length === 0) return null;
  return (
    <div className="cr-res">
      <h5 className="cr-res-head">Tài liệu học</h5>
      <ul className="cr-res-list">
        {items.map((r) => (
          <li key={r.id}>
            <a
              className={'cr-res-link' + (r.id === activeId ? ' cr-res-link-active' : '')}
              href={r.url}
              target="_blank"
              rel="noopener noreferrer"
              onClick={(e) => {
                // Cho phép Ctrl/Cmd/Shift-click mở tab mới như thường;
                // click thường thì mở trong panel bên cạnh.
                if (e.metaKey || e.ctrlKey || e.shiftKey || e.altKey) return;
                e.preventDefault();
                onOpen(r);
              }}
            >
              <span className={'cr-res-badge cr-badge-' + r.kind}>
                {KIND_LABEL[r.kind] || r.kind}
              </span>
              <span className="cr-res-title">{r.title}</span>
              {r.source && <span className="cr-res-source">{r.source}</span>}
            </a>
          </li>
        ))}
      </ul>
    </div>
  );
}
