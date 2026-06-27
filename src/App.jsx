import { useEffect, useState } from 'react';
import { supabase } from './supabaseClient';
import Auth from './components/Auth.jsx';
import Roadmap from './components/Roadmap.jsx';
import Metronome from './components/Metronome.jsx';

export default function App() {
  // `session` = null khi chưa đăng nhập. Đây là cổng phân nhánh của cả app.
  const [session, setSession] = useState(null);
  const [ready, setReady] = useState(false);

  useEffect(() => {
    // 1) Lấy phiên hiện tại (nếu user đã đăng nhập từ trước).
    supabase.auth.getSession().then(({ data }) => {
      setSession(data.session);
      setReady(true);
    });
    // 2) Lắng nghe mọi thay đổi đăng nhập/đăng xuất theo thời gian thực.
    const { data: sub } = supabase.auth.onAuthStateChange((_event, s) => {
      setSession(s);
    });
    return () => sub.subscription.unsubscribe();
  }, []);

  if (!ready) {
    return (
      <div className="cr-root">
        <p className="cr-loading">Đang tải…</p>
      </div>
    );
  }

  return (
    <div className="cr-root">
      <header className="cr-topbar">
        <span className="cr-brand">Crescendo</span>
        {session && (
          <div className="cr-userbox">
            <span className="cr-user-email">{session.user.email}</span>
            <button className="cr-signout" onClick={() => supabase.auth.signOut()}>
              Đăng xuất
            </button>
          </div>
        )}
      </header>

      {!session ? (
        <Auth />
      ) : (
        <>
          <Metronome />
          <Roadmap session={session} />
        </>
      )}
    </div>
  );
}
