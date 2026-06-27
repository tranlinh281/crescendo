import { useState } from 'react';
import { supabase } from '../supabaseClient';

export default function Auth() {
  const [mode, setMode] = useState('signin'); // 'signin' | 'signup'
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [busy, setBusy] = useState(false);
  const [msg, setMsg] = useState(null); // { type: 'ok' | 'err', text }

  async function submit(e) {
    e.preventDefault();
    setBusy(true);
    setMsg(null);
    try {
      if (mode === 'signup') {
        const { error } = await supabase.auth.signUp({ email, password });
        if (error) throw error;
        setMsg({
          type: 'ok',
          text: 'Đăng ký xong! Nếu project bật xác nhận email, hãy mở mail để xác nhận rồi đăng nhập.',
        });
      } else {
        const { error } = await supabase.auth.signInWithPassword({ email, password });
        if (error) throw error;
        // Khi thành công, onAuthStateChange ở App sẽ tự chuyển màn hình.
      }
    } catch (err) {
      setMsg({ type: 'err', text: err.message });
    } finally {
      setBusy(false);
    }
  }

  return (
    <section className="cr-auth">
      <span className="cr-eyebrow">{mode === 'signin' ? 'ĐĂNG NHẬP' : 'TẠO TÀI KHOẢN'}</span>
      <h1 className="cr-auth-title">
        {mode === 'signin' ? 'Tiếp tục luyện tập' : 'Bắt đầu hành trình'}
      </h1>

      <form className="cr-auth-form" onSubmit={submit}>
        <label className="cr-field">
          <span>Email</span>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            autoComplete="email"
          />
        </label>
        <label className="cr-field">
          <span>Mật khẩu</span>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            minLength={6}
            autoComplete={mode === 'signin' ? 'current-password' : 'new-password'}
          />
        </label>
        <button className="cr-auth-btn" type="submit" disabled={busy}>
          {busy ? 'Đang xử lý…' : mode === 'signin' ? 'Đăng nhập' : 'Đăng ký'}
        </button>
      </form>

      {msg && (
        <p className={'cr-msg ' + (msg.type === 'err' ? 'cr-msg-err' : 'cr-msg-ok')}>
          {msg.text}
        </p>
      )}

      <button
        className="cr-link"
        onClick={() => {
          setMode(mode === 'signin' ? 'signup' : 'signin');
          setMsg(null);
        }}
      >
        {mode === 'signin' ? 'Chưa có tài khoản? Đăng ký' : 'Đã có tài khoản? Đăng nhập'}
      </button>
    </section>
  );
}
