import { useState, useEffect, useRef } from 'react';

function tempoLabel(bpm) {
  if (bpm < 60) return 'Largo';
  if (bpm < 76) return 'Adagio';
  if (bpm < 108) return 'Andante';
  if (bpm < 120) return 'Moderato';
  if (bpm < 168) return 'Allegro';
  return 'Presto';
}

export default function Metronome() {
  const [bpm, setBpm] = useState(80);
  const [beats, setBeats] = useState(4);
  const [isPlaying, setIsPlaying] = useState(false);
  const [activeBeat, setActiveBeat] = useState(-1);

  const audioCtxRef = useRef(null);
  const beatRef = useRef(0);

  function playClick(accent) {
    const ctx = audioCtxRef.current;
    if (!ctx) return;
    const osc = ctx.createOscillator();
    const gain = ctx.createGain();
    osc.frequency.value = accent ? 1320 : 880;
    gain.gain.setValueAtTime(0.0001, ctx.currentTime);
    gain.gain.exponentialRampToValueAtTime(0.6, ctx.currentTime + 0.001);
    gain.gain.exponentialRampToValueAtTime(0.0001, ctx.currentTime + 0.05);
    osc.connect(gain).connect(ctx.destination);
    osc.start();
    osc.stop(ctx.currentTime + 0.06);
  }

  useEffect(() => {
    if (!isPlaying) {
      setActiveBeat(-1);
      return;
    }
    const interval = setInterval(() => {
      const current = beatRef.current % beats;
      playClick(current === 0);
      setActiveBeat(current);
      beatRef.current = current + 1;
    }, 60000 / bpm);
    return () => clearInterval(interval);
  }, [isPlaying, bpm, beats]);

  function toggle() {
    if (!audioCtxRef.current) {
      const Ctx = window.AudioContext || window.webkitAudioContext;
      audioCtxRef.current = new Ctx();
    }
    if (audioCtxRef.current.state === 'suspended') audioCtxRef.current.resume();
    beatRef.current = 0;
    setIsPlaying((p) => !p);
  }

  return (
    <section className="cr-metronome" aria-label="Máy gõ nhịp">
      <div className="cr-metro-head">
        <span className="cr-eyebrow">CÔNG CỤ LUYỆN TẬP</span>
        <h2 className="cr-metro-title">Máy gõ nhịp</h2>
      </div>

      <div className="cr-metro-body">
        <div className="cr-bpm-block">
          <div className="cr-bpm-number">{bpm}</div>
          <div className="cr-bpm-meta">
            <span className="cr-bpm-unit">BPM</span>
            <span className="cr-tempo">{tempoLabel(bpm)}</span>
          </div>
        </div>

        <div className="cr-beat-dots" role="presentation">
          {Array.from({ length: beats }).map((_, i) => (
            <span
              key={i}
              className={
                'cr-dot' +
                (i === activeBeat ? ' cr-dot-on' : '') +
                (i === 0 ? ' cr-dot-accent' : '')
              }
            />
          ))}
        </div>

        <input
          className="cr-slider"
          type="range"
          min="40"
          max="208"
          value={bpm}
          onChange={(e) => setBpm(Number(e.target.value))}
          aria-label="Điều chỉnh tốc độ BPM"
        />

        <div className="cr-metro-controls">
          <button className="cr-step" onClick={() => setBpm((b) => Math.max(40, b - 1))} aria-label="Giảm BPM">
            –
          </button>
          <button className="cr-play" onClick={toggle}>
            {isPlaying ? 'Dừng' : 'Bắt đầu'}
          </button>
          <button className="cr-step" onClick={() => setBpm((b) => Math.min(208, b + 1))} aria-label="Tăng BPM">
            +
          </button>

          <div className="cr-beats-select" role="group" aria-label="Số phách mỗi ô nhịp">
            {[2, 3, 4, 6].map((n) => (
              <button
                key={n}
                className={'cr-beat-btn' + (beats === n ? ' cr-beat-btn-on' : '')}
                onClick={() => setBeats(n)}
              >
                {n}/4
              </button>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
