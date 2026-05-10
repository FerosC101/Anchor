import { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { ROUTES } from "../../core/config/routes";
import { useNotifications } from "../../core/context/NotificationContext";
import { useAuth } from "../../core/context/AuthContext";
import { WorkerDrawer } from "./WorkerDrawer";

const WORKER_NAV = [
  { label: "Home", route: ROUTES.HOME },
  { label: "Wages", route: ROUTES.WAGES },
  { label: "Contracts", route: ROUTES.CONTRACTS },
  { label: "Community", route: ROUTES.COMMUNITY },
  { label: "Shield", route: ROUTES.SHIELD },
  { label: "Alerts", route: ROUTES.ALERTS },
];

function isActiveRoute(pathname: string, route: string) {
  return pathname === route || pathname.startsWith(`${route}/`);
}

export function WorkerLayout({ children }: { children: React.ReactNode }) {
  const navigate = useNavigate();
  const location = useLocation();
  const { unreadCount } = useNotifications();
  const { signOut, user } = useAuth();
  const [drawerOpen, setDrawerOpen] = useState(false);

  const handleLogout = async () => {
    await signOut();
    navigate(ROUTES.LOGIN);
  };

  return (
    <div className="min-h-screen" style={{ backgroundColor: "#F4F4F8" }}>
      <header className="sticky top-0 z-20 border-b border-[#D9DCE3] bg-white/95 backdrop-blur w-full">
        <div className="mx-auto flex h-[54px] w-full items-center px-4 sm:px-6 lg:px-8">
          <div className="flex items-center gap-3 flex-shrink-0">
            <span className="h-6 w-6 rounded-full bg-[#003696]" />
            <p className="text-[20px] font-extrabold text-[#003696] tracking-[-0.03em]">Anchor</p>
          </div>

          <nav className="hidden md:flex flex-1 items-center justify-center gap-8 text-[13px] font-semibold text-slate-500">
            {WORKER_NAV.map((item) => {
              const isActive = isActiveRoute(location.pathname, item.route);
              return (
                <button
                  key={item.route}
                  onClick={() => navigate(item.route)}
                  className={`relative transition ${
                    isActive ? "text-[#003696]" : "text-slate-500 hover:text-slate-700"
                  }`}
                >
                  {item.label}
                  {isActive && (
                    <span className="absolute -bottom-[17px] left-1/2 h-[2px] w-10 -translate-x-1/2 rounded-full bg-[#003696]" />
                  )}
                </button>
              );
            })}
          </nav>

          <div className="flex flex-shrink-0 items-center gap-3 text-slate-500 ml-auto">
            <button
              className="rounded-md p-1.5 hover:bg-slate-100 relative"
              onClick={() => navigate(ROUTES.NOTIFICATIONS)}
              aria-label="Notifications"
            >
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 00-5-5.917V4a1 1 0 10-2 0v1.083A6 6 0 006 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
                />
              </svg>
              {unreadCount > 0 && (
                <span
                  className="absolute top-0 right-0 flex h-5 w-5 items-center justify-center rounded-full text-[11px] font-bold text-white"
                  style={{ backgroundColor: "#8E0012" }}
                >
                  {unreadCount}
                </span>
              )}
            </button>
            <button
              className="rounded-md p-1.5 hover:bg-slate-100"
              onClick={() => setDrawerOpen(true)}
              aria-label="Open menu"
            >
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </button>
          </div>
        </div>
      </header>

      <WorkerDrawer
        isOpen={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        onProfileClick={() => navigate(ROUTES.PROFILE)}
        onNotificationsClick={() => navigate(ROUTES.NOTIFICATIONS)}
        onPrivacyClick={() => navigate(ROUTES.PRIVACY)}
        onSafetyResourcesClick={() => navigate(ROUTES.SAFETY_RESOURCES)}
        onHelpClick={() => navigate(ROUTES.HELP)}
        onLogoutClick={handleLogout}
        notificationCount={unreadCount}
        userName={user?.fullName ?? "Guest User"}
        userEmail={user?.email ?? "guest@demo.com"}
      />

      {children}
    </div>
  );
}
