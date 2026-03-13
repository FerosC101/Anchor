import { useNavigate, useLocation } from "react-router-dom";
import { ROUTES } from "../../core/config/routes";
import { useState } from "react";

export interface AppHeaderProps {
  navItems?: Array<{
    label: string;
    route: string;
    icon?: React.ReactNode;
  }>;
  headerAction?: {
    label: string;
    onClick: () => void;
  };
}

export function AppHeader({ navItems = [], headerAction }: AppHeaderProps) {
  const navigate = useNavigate();
  const location = useLocation();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  const defaultNavItems = [
    { label: "Home", route: ROUTES.DASHBOARD },
    { label: "Monitoring", route: ROUTES.MONITORING },
    { label: "Alert", route: ROUTES.ALERT },
    { label: "Profile", route: ROUTES.PROFILE },
  ];

  const items = navItems.length > 0 ? navItems : defaultNavItems;

  return (
    <header className="sticky top-0 z-20 border-b border-[#D9DCE3] bg-white/95 backdrop-blur w-full">
      <div className="mx-auto flex h-[54px] w-full items-center justify-between px-4 sm:px-6 lg:px-8">
        <div className="flex items-center gap-3">
          <span className="h-6 w-6 rounded-full bg-[#003696]" />
          <p className="text-[20px] font-extrabold text-[#003696] tracking-[-0.03em]">Anchor</p>
        </div>

        <nav className="hidden md:flex items-center gap-12 text-[14px] font-semibold text-slate-500">
          {items.map((item) => (
            <button
              key={item.route}
              onClick={() => navigate(item.route)}
              className={`relative transition ${
                location.pathname === item.route ? "text-[#003696]" : "hover:text-slate-700"
              }`}
            >
              {item.label}
              {location.pathname === item.route && (
                <span className="absolute -bottom-[17px] left-1/2 h-[2px] w-12 -translate-x-1/2 rounded-full bg-[#003696]" />
              )}
            </button>
          ))}
        </nav>

        <div className="flex items-center gap-3 text-slate-500">
          <button className="rounded-md p-1.5 hover:bg-slate-100">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 00-5-5.917V4a1 1 0 10-2 0v1.083A6 6 0 006 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
              />
            </svg>
          </button>
          {headerAction ? (
            <button
              onClick={headerAction.onClick}
              className="hidden md:block text-sm text-slate-500 hover:text-slate-800 transition-colors"
            >
              {headerAction.label}
            </button>
          ) : null}
          <button
            className="rounded-md p-1.5 hover:bg-slate-100 md:hidden"
            onClick={() => setMobileMenuOpen((value) => !value)}
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
              <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
        </div>
      </div>

      {mobileMenuOpen ? (
        <div className="border-t border-slate-100 bg-white px-5 py-3 md:hidden">
          <div className="flex flex-col gap-1">
            {items.map((item) => (
              <button
                key={item.route}
                onClick={() => {
                  navigate(item.route);
                  setMobileMenuOpen(false);
                }}
                className={`rounded-xl px-3 py-2.5 text-left text-sm font-medium ${
                  location.pathname === item.route ? "bg-blue-50 text-[#003696]" : "text-slate-600 hover:bg-slate-50"
                }`}
              >
                {item.label}
              </button>
            ))}
            {headerAction ? (
              <button
                onClick={() => {
                  headerAction.onClick();
                  setMobileMenuOpen(false);
                }}
                className="mt-1 rounded-xl px-3 py-2.5 text-left text-sm font-medium text-red-500 hover:bg-red-50"
              >
                {headerAction.label}
              </button>
            ) : null}
          </div>
        </div>
      ) : null}
    </header>
  );
}
