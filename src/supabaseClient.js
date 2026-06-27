import { createClient } from '@supabase/supabase-js';

const url = import.meta.env.VITE_SUPABASE_URL;
const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!url || !anonKey) {
  // Nhắc rõ ràng khi quên cấu hình .env — lỗi im lặng khó chịu hơn nhiều.
  console.error(
    'Thiếu VITE_SUPABASE_URL hoặc VITE_SUPABASE_ANON_KEY. ' +
      'Copy .env.example thành .env và điền giá trị từ Supabase.'
  );
}

export const supabase = createClient(url, anonKey);
