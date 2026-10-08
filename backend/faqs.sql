-- ============================================================
-- FAQ Database Table & Policies
-- ============================================================
-- Run this in your Supabase SQL Editor to make FAQs permanently
-- stored in the database for all website visitors.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.faqs (
  id            BIGSERIAL PRIMARY KEY,
  question      TEXT NOT NULL,
  answer        TEXT NOT NULL,
  expires_at    TIMESTAMPTZ DEFAULT NULL,
  is_active     BOOLEAN DEFAULT true,
  display_order INT DEFAULT 0,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW(),
  created_by    UUID REFERENCES auth.users(id) ON DELETE SET NULL
);

-- Index for fast ordering
CREATE INDEX IF NOT EXISTS idx_faqs_order ON public.faqs(display_order, id);

-- Enable Row Level Security (RLS)
ALTER TABLE public.faqs ENABLE ROW LEVEL SECURITY;

-- 1. Anyone (public visitors) can read FAQs
CREATE POLICY "Anyone can read faqs" 
  ON public.faqs FOR SELECT USING (true);

-- 2. Only registered admins can insert, update, or delete FAQs
CREATE POLICY "Only Admins can modify faqs" 
  ON public.faqs FOR ALL 
  USING (EXISTS (SELECT 1 FROM public.admins WHERE email = auth.jwt() ->> 'email'))
  WITH CHECK (EXISTS (SELECT 1 FROM public.admins WHERE email = auth.jwt() ->> 'email'));

-- ============================================================
-- Initial Seed: 9 standard FAQs
-- ============================================================

INSERT INTO public.faqs (question, answer, display_order) VALUES
  (
    'Steam showing "No internet connection" while downloading a game!',
    'This is a common issue caused by Steam''s internal connection checks. You can resolve this easily by following our step-by-step video guide: <a href="https://youtu.be/oHHBDzaVol8?si=ENbmO-MBQ9wEvqtj" target="_blank">Watch Video Tutorial</a>',
    1
  ),
  (
    'Does this work on Linux, Ubuntu, or the Steam Deck?',
    'The official tool is built for Windows. However, Linux and Steam Deck users have two great alternatives:<br><br><ul><li><strong>Native Method:</strong> Use community tools like <a href="https://github.com/ciscosweater/enter-the-wired" target="_blank">Accela</a> paired with <a href="https://github.com/AceSLS/SLSsteam" target="_blank">SLSsteam</a> on GitHub.</li><li><strong>Compatibility Layer:</strong> Install <em>Bottles</em> or <em>Wine</em>, run the Windows version of Steam inside it, and execute the tool in that same isolated environment.</li></ul>',
    2
  ),
  (
    'Games missing or say "Purchase" after a Steam update?',
    'A recent Steam client update likely broke the code injection. Try these fixes in order:<br><br><ol><li><strong>Clear the Steam Download Cache</strong> (Navigate to Steam → Settings → Downloads → Clear Cache). You may need to do this and restart Steam a few times.</li><li>Open Windows PowerShell and run this command:<br><code class="inline-block">irm steam.run | iex</code></li><li>Wait for the developers to release an update compatible with the newest Steam client.</li></ol>',
    3
  ),
  (
    'How do I completely uninstall or remove a game?',
    'These unlocked games cannot be uninstalled normally through the Steam UI. To remove them, you must manually delete the associated <code>.lua</code> files from this directory:<br><br><code class="inline-block">C:\Program Files (x86)\Steam\config\stplug-in</code><br><br>To completely wipe the bypass from your PC, you must also delete any hidden <code>.dll</code> files the tool left in your main Steam installation folder.',
    4
  ),
  (
    'I get this 🚫 sign when dragging & dropping files!',
    'If Windows prevents you from dragging and dropping the Manifest or Lua files onto the floating Steam icon, it is usually a permissions mismatch (e.g., Steam is running as Administrator but the tool is not).<br><br>To fix this, open Windows PowerShell and run this command:<br><code class="inline-block">irm steam.run | iex</code>',
    5
  ),
  (
    'Will I get banned from Steam for using this?',
    'Currently, there is no public record of users being banned for using this method to play single-player games. The tool operates purely client-side and avoids triggering VAC (Valve Anti-Cheat). However, as with all unofficial modifications, you are using it at your own risk.',
    6
  ),
  (
    'Can I use mods or the Steam Workshop?',
    '<strong>Yes!</strong> Because you are downloading unmodified files straight from Steam''s official servers, the games are fully moddable.<br><br><i class="fas fa-info-circle"></i> <em>Note:</em> Direct Steam Workshop downloads using the "Subscribe" button won''t work without a real license on your account. You will need to use a third-party Steam Workshop downloader site to fetch the mod files manually.',
    7
  ),
  (
    'Do Steam achievements sync to my profile?',
    '<strong>No.</strong> Any achievements you earn while using the tool are only saved locally on your machine. They will not be synced to your public Steam profile or Steam Cloud saves.',
    8
  ),
  (
    'I deleted the tool, but my games still work. Why?',
    'When you first ran the tool, it dropped a hidden <code>.dll</code> file directly into your main Steam folder. As long as that DLL remains there, Steam will automatically read any Lua keys you place inside the <code>steam/config/stplug-in</code> folder every time it boots up.<br><br>This means you can drop new Lua keys straight into that folder and restart Steam to unlock new games—without ever needing to keep the main tool open!',
    9
  );
