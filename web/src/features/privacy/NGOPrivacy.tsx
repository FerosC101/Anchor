import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { ROUTES } from "../../core/config/routes";
import { NgoColors } from "../../core/theme/ngo-colors";
import { NgoDrawer } from "../../components/layout/NgoDrawer";
import { useAuth } from "../../core/context/AuthContext";

export function Privacy() {
  const navigate = useNavigate();
  const { signOut } = useAuth();
  const [drawerOpen, setDrawerOpen] = useState(false);

  // Security Settings State
  const [twoFactor, setTwoFactor] = useState(true);
  const [biometric, setBiometric] = useState(false);
  const [autoLock, setAutoLock] = useState(true);

  // Privacy Settings State
  const [anonymousPosts, setAnonymousPosts] = useState(true);
  const [shareAnalytics, setShareAnalytics] = useState(false);
  const [locationServices, setLocationServices] = useState(false);

  const handleLogout = async () => {
    await signOut();
    navigate(ROUTES.LOGIN);
  };

  return (
    <div className="min-h-screen" style={{ backgroundColor: NgoColors.bg }}>
      {/* Header */}
      <header className="sticky top-0 z-20 border-b border-[#D9DCE3] bg-white/95 backdrop-blur w-full">
        <div className="mx-auto flex h-[54px] w-full items-center px-4 sm:px-6 lg:px-8">
          {/* Back Button */}
          <button
            onClick={() => navigate(-1)}
            className="transition text-slate-600 hover:text-slate-900"
          >
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path strokeLinecap="round" strokeLinejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
          </button>

          {/* Logo - Center */}
          <div className="flex-1 text-center">
            <span className="text-[16px] font-bold tracking-[-0.01em]" style={{ color: NgoColors.navy }}>
              Anchor
            </span>
          </div>

          {/* Hamburger Menu */}
          <button
            onClick={() => setDrawerOpen(true)}
            className="transition text-slate-500 hover:text-slate-700"
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
              <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
        </div>
      </header>

      {/* Drawer */}
      <NgoDrawer
        isOpen={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        onProfileClick={() => navigate(ROUTES.PROFILE)}
        onNotificationsClick={() => navigate(ROUTES.NOTIFICATIONS)}
        onPrivacyClick={() => {}}
        onLogoutClick={handleLogout}
      />

      <main className="mx-auto w-full px-3 py-4 sm:px-4 sm:py-6 lg:px-8 max-w-3xl">
        {/* Title */}
        <h1 className="text-xl sm:text-2xl font-extrabold tracking-[-0.01em] text-slate-900 mb-4">Privacy & Security</h1>

        {/* Protected Data Banner */}
        <div className="rounded-lg border border-blue-200 bg-blue-50 p-3 sm:p-4 mb-6 flex gap-2 sm:gap-3">
          <div
            className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-lg"
            style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
              <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z" />
            </svg>
          </div>
          <div className="flex-1 min-w-0">
            <p className="text-xs sm:text-sm font-bold text-slate-900">Your Data is Protected</p>
            <p className="text-xs text-slate-600 mt-0.5">
              We use end-to-end encryption to keep your personal information, contracts, and financial data secure.
            </p>
          </div>
        </div>

        {/* Data Protection */}
        <div className="mb-6 sm:mb-8">
          <h2 className="text-xs sm:text-sm font-bold text-slate-900 px-0 py-2 sm:py-3 uppercase tracking-wider text-slate-500">
            Data Protection
          </h2>
          <div className="space-y-2 sm:space-y-3">
            {/* Two-Factor Authentication */}
            <div className="rounded-lg border border-[#E8EAEF] bg-white p-3 sm:p-4 flex items-center justify-between hover:border-slate-300 transition">
              <div className="flex items-center gap-2 sm:gap-3 min-w-0">
                <div
                  className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-lg"
                  style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z" />
                  </svg>
                </div>
                <p className="text-xs sm:text-sm font-medium text-slate-900 flex-1 min-w-0">Two-Factor Authentication</p>
              </div>
              <button
                onClick={() => setTwoFactor(!twoFactor)}
                className={`relative h-5 sm:h-6 w-10 sm:w-11 rounded-full transition-colors flex-shrink-0 ml-2 ${
                  twoFactor ? "bg-blue-600" : "bg-slate-300"
                }`}
              >
                <span
                  className={`absolute top-0.5 h-4 sm:h-5 w-4 sm:w-5 rounded-full bg-white transition-transform ${
                    twoFactor ? "translate-x-4 sm:translate-x-5" : "translate-x-0.5"
                  }`}
                />
              </button>
            </div>

            {/* Biometric Login */}
            <div className="rounded-lg border border-[#E8EAEF] bg-white p-3 sm:p-4 flex items-center justify-between hover:border-slate-300 transition">
              <div className="flex items-center gap-2 sm:gap-3 min-w-0">
                <div
                  className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-lg"
                  style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy, opacity: 0.6 }}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
                  </svg>
                </div>
                <p className="text-xs sm:text-sm font-medium text-slate-900 flex-1 min-w-0">Biometric Login</p>
              </div>
              <button
                onClick={() => setBiometric(!biometric)}
                className={`relative h-5 sm:h-6 w-10 sm:w-11 rounded-full transition-colors flex-shrink-0 ml-2 ${
                  biometric ? "bg-blue-600" : "bg-slate-300"
                }`}
              >
                <span
                  className={`absolute top-0.5 h-4 sm:h-5 w-4 sm:w-5 rounded-full bg-white transition-transform ${
                    biometric ? "translate-x-4 sm:translate-x-5" : "translate-x-0.5"
                  }`}
                />
              </button>
            </div>

            {/* Auto-Lock App */}
            <div className="rounded-lg border border-[#E8EAEF] bg-white p-3 sm:p-4 flex items-center justify-between hover:border-slate-300 transition">
              <div className="flex items-center gap-2 sm:gap-3 min-w-0">
                <div
                  className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-lg"
                  style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 1C6.48 1 2 5.48 2 11s4.48 10 10 10 10-4.48 10-10S17.52 1 12 1zm-2 15l-5-5 1.41-1.41L10 13.17l7.59-7.59L19 7l-9 9z" />
                  </svg>
                </div>
                <p className="text-xs sm:text-sm font-medium text-slate-900 flex-1 min-w-0">Auto-Lock App</p>
              </div>
              <button
                onClick={() => setAutoLock(!autoLock)}
                className={`relative h-5 sm:h-6 w-10 sm:w-11 rounded-full transition-colors flex-shrink-0 ml-2 ${
                  autoLock ? "bg-blue-600" : "bg-slate-300"
                }`}
              >
                <span
                  className={`absolute top-0.5 h-4 sm:h-5 w-4 sm:w-5 rounded-full bg-white transition-transform ${
                    autoLock ? "translate-x-4 sm:translate-x-5" : "translate-x-0.5"
                  }`}
                />
              </button>
            </div>
          </div>
        </div>

        {/* Privacy Settings */}
        <div className="mb-6 sm:mb-8">
          <h2 className="text-xs sm:text-sm font-bold text-slate-900 px-0 py-2 sm:py-3 uppercase tracking-wider text-slate-500">
            Privacy Settings
          </h2>
          <div className="space-y-2 sm:space-y-3">
            {/* Anonymous Community Posts */}
            <div className="rounded-lg border border-[#E8EAEF] bg-white p-3 sm:p-4 flex items-center justify-between hover:border-slate-300 transition">
              <div className="flex items-center gap-2 sm:gap-3 min-w-0">
                <div
                  className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-lg"
                  style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.89 1.97 1.74 1.97 2.95V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z" />
                  </svg>
                </div>
                <p className="text-xs sm:text-sm font-medium text-slate-900 flex-1 min-w-0">Anonymous Community Posts</p>
              </div>
              <button
                onClick={() => setAnonymousPosts(!anonymousPosts)}
                className={`relative h-5 sm:h-6 w-10 sm:w-11 rounded-full transition-colors flex-shrink-0 ml-2 ${
                  anonymousPosts ? "bg-blue-600" : "bg-slate-300"
                }`}
              >
                <span
                  className={`absolute top-0.5 h-4 sm:h-5 w-4 sm:w-5 rounded-full bg-white transition-transform ${
                    anonymousPosts ? "translate-x-4 sm:translate-x-5" : "translate-x-0.5"
                  }`}
                />
              </button>
            </div>

            {/* Share Usage Analytics */}
            <div className="rounded-lg border border-[#E8EAEF] bg-white p-3 sm:p-4 flex items-center justify-between hover:border-slate-300 transition">
              <div className="flex items-center gap-2 sm:gap-3 min-w-0">
                <div
                  className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-lg"
                  style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy, opacity: 0.6 }}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M5 9.2h3V19H5zM10.6 5h2.8v14h-2.8zm5.6 8H19v6h-2.8z" />
                  </svg>
                </div>
                <p className="text-xs sm:text-sm font-medium text-slate-900 flex-1 min-w-0">Share Usage Analytics</p>
              </div>
              <button
                onClick={() => setShareAnalytics(!shareAnalytics)}
                className={`relative h-5 sm:h-6 w-10 sm:w-11 rounded-full transition-colors flex-shrink-0 ml-2 ${
                  shareAnalytics ? "bg-blue-600" : "bg-slate-300"
                }`}
              >
                <span
                  className={`absolute top-0.5 h-4 sm:h-5 w-4 sm:w-5 rounded-full bg-white transition-transform ${
                    shareAnalytics ? "translate-x-4 sm:translate-x-5" : "translate-x-0.5"
                  }`}
                />
              </button>
            </div>

            {/* Location Services */}
            <div className="rounded-lg border border-[#E8EAEF] bg-white p-3 sm:p-4 flex items-center justify-between hover:border-slate-300 transition">
              <div className="flex items-center gap-2 sm:gap-3 min-w-0">
                <div
                  className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-lg"
                  style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy, opacity: 0.6 }}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z" />
                  </svg>
                </div>
                <p className="text-xs sm:text-sm font-medium text-slate-900 flex-1 min-w-0">Location Services</p>
              </div>
              <button
                onClick={() => setLocationServices(!locationServices)}
                className={`relative h-5 sm:h-6 w-10 sm:w-11 rounded-full transition-colors flex-shrink-0 ml-2 ${
                  locationServices ? "bg-blue-600" : "bg-slate-300"
                }`}
              >
                <span
                  className={`absolute top-0.5 h-4 sm:h-5 w-4 sm:w-5 rounded-full bg-white transition-transform ${
                    locationServices ? "translate-x-4 sm:translate-x-5" : "translate-x-0.5"
                  }`}
                />
              </button>
            </div>
          </div>
        </div>

        {/* Data Management */}
        <div className="mb-6 sm:mb-8">
          <h2 className="text-xs sm:text-sm font-bold text-slate-900 px-0 py-2 sm:py-3 uppercase tracking-wider text-slate-500">
            Data Management
          </h2>
          <div className="space-y-2 sm:space-y-3">
            {/* Download My Data */}
            <button className="w-full rounded-lg border border-[#E8EAEF] bg-white p-3 sm:p-4 flex items-center justify-between hover:bg-slate-50 hover:border-slate-300 transition">
              <div className="flex items-center gap-2 sm:gap-3 min-w-0">
                <div
                  className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-lg"
                  style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M19 12v7H5v-7H3v7c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2v-7h-2z" /><path d="M11 3L5.5 8.5l1.42 1.41L11 5.83V15h2V5.83l4.08 4.08L18.5 8.5 12 3z" />
                  </svg>
                </div>
                <div className="text-left min-w-0">
                  <p className="text-xs sm:text-sm font-medium text-slate-900">Download My Data</p>
                  <p className="text-xs text-slate-500">Export your data</p>
                </div>
              </div>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="text-slate-400 flex-shrink-0 ml-2">
                <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
              </svg>
            </button>

            {/* Clear Cache */}
            <button className="w-full rounded-lg border border-[#E8EAEF] bg-white p-3 sm:p-4 flex items-center justify-between hover:bg-slate-50 hover:border-slate-300 transition">
              <div className="flex items-center gap-2 sm:gap-3 min-w-0">
                <div
                  className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-lg"
                  style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M14.59 8L12 10.59 9.41 8 8 9.41 10.59 12 8 14.59 9.41 16 12 13.41 14.59 16 16 14.59 13.41 12 16 9.41 14.59 8zM12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z" />
                  </svg>
                </div>
                <div className="text-left min-w-0">
                  <p className="text-xs sm:text-sm font-medium text-slate-900">Clear Cache</p>
                  <p className="text-xs text-slate-500">Free up space</p>
                </div>
              </div>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="text-slate-400 flex-shrink-0 ml-2">
                <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
              </svg>
            </button>
          </div>
        </div>

        {/* Danger Zone */}
        <div className="mb-6 pb-8">
          <h2 className="text-xs sm:text-sm font-bold text-slate-900 px-0 py-2 sm:py-3 uppercase tracking-wider text-red-600">
            Danger Zone
          </h2>
          <div className="space-y-2 sm:space-y-3">
            {/* Deactivate Account */}
            <button className="w-full rounded-lg border border-red-200 bg-red-50 p-3 sm:p-4 flex items-center justify-between hover:bg-red-100 hover:border-red-300 transition">
              <div className="min-w-0 flex-1">
                <p className="text-xs sm:text-sm font-medium text-red-600">Deactivate Account</p>
                <p className="text-xs text-red-500 mt-0.5">Temporarily disable your account</p>
              </div>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="text-red-400 flex-shrink-0 ml-2">
                <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
              </svg>
            </button>

            {/* Delete Account */}
            <button className="w-full rounded-lg border border-red-200 bg-red-50 p-3 sm:p-4 flex items-center justify-between hover:bg-red-100 hover:border-red-300 transition">
              <div className="min-w-0 flex-1">
                <p className="text-xs sm:text-sm font-medium text-red-700">Delete Account</p>
                <p className="text-xs text-red-500 mt-0.5">Permanently delete your account and all data</p>
              </div>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="text-red-400 flex-shrink-0 ml-2">
                <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
              </svg>
            </button>
          </div>
        </div>
      </main>
    </div>
  );
}
