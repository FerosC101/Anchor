import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { ROUTES } from "../../core/config/routes";
import { NgoColors } from "../../core/theme/ngo-colors";
import { NgoDrawer } from "../../components/layout/NgoDrawer";
import { useNotifications } from "../../core/context/NotificationContext";
import { useAuth } from "../../core/context/AuthContext";

// ─── Types ────────────────────────────────────────────────────────────────────

// Types are now imported from NotificationContext

// ─── Icon Components ─────────────────────────────────────────────────────────

function WageIcon() {
  return (
    <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" opacity="0.8">
      <text x="3" y="20" fontSize="18" fontWeight="bold">$</text>
    </svg>
  );
}

function ContractIcon() {
  return (
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
      <path strokeLinecap="round" strokeLinejoin="round" d="M9 12h6m-6 4h6m2-13H7a2 2 0 00-2 2v14a2 2 0 002 2h10a2 2 0 002-2V5a2 2 0 00-2-2z" />
    </svg>
  );
}

function CommunityIcon() {
  return (
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
      <path strokeLinecap="round" strokeLinejoin="round" d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2M9 7a4 4 0 100-8 4 4 0 000 8zm6 0a2 2 0 100-4 2 2 0 000 4z" />
    </svg>
  );
}

function SafetyIcon() {
  return (
    <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" opacity="0.8">
      <path d="M12 2L2 7v9a10 10 0 1010 10 10 10 0 00-10-10z" />
      <text x="10" y="15" fontSize="11" fontWeight="bold" fill="white">!</text>
    </svg>
  );
}

function ExitIcon() {
  return (
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
      <polyline points="23 5 13.5 14.5 8.5 9.5 1 17" />
      <polyline points="17 5 23 5 23 11" />
    </svg>
  );
}

function ContactIcon() {
  return (
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
      <path strokeLinecap="round" strokeLinejoin="round" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2z" />
    </svg>
  );
}

function IdentityIcon() {
  return (
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
      <path strokeLinecap="round" strokeLinejoin="round" d="M9 12l2 2 4-4" />
      <circle cx="12" cy="12" r="10" />
    </svg>
  );
}

// ─── Component ────────────────────────────────────────────────────────────────

export function Notifications() {
  const navigate = useNavigate();
  const [drawerOpen, setDrawerOpen] = useState(false);
  const { notifications, markAsRead } = useNotifications();
  const { signOut } = useAuth();

  const handleLogout = async () => {
    await signOut();
    navigate(ROUTES.LOGIN);
  };

  const handlePrivacy = () => {
    navigate(ROUTES.PRIVACY);
  };

  const getNotificationStyle = (type: any) => {
    switch (type) {
      case "wage":
        return { bgColor: "#EEFDF3", textColor: "#00AA28", icon: <WageIcon /> };
      case "contract":
        return { bgColor: "#DFEDFF", textColor: "#003696", icon: <ContractIcon /> };
      case "community":
        return { bgColor: "#FFFBE8", textColor: "#AD4B00", icon: <CommunityIcon /> };
      case "safety":
        return { bgColor: "#FFF3F3", textColor: "#8E0012", icon: <SafetyIcon /> };
      case "exit":
        return { bgColor: "#EEFDF3", textColor: "#00AA28", icon: <ExitIcon /> };
      case "contact":
        return { bgColor: "#DFEDFF", textColor: "#003696", icon: <ContactIcon /> };
      case "identity":
        return { bgColor: "#EEFDF3", textColor: "#00AA28", icon: <IdentityIcon /> };
      default:
        return { bgColor: "#F1F5F9", textColor: "#475569", icon: <ContractIcon /> };
    }
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
        onPrivacyClick={handlePrivacy}
        onLogoutClick={handleLogout}
      />

      <main className="mx-auto w-full px-4 py-6 sm:px-6 lg:px-8">
        {/* Title */}
        <h1 className="text-[24px] font-extrabold tracking-[-0.01em] text-slate-900 mb-6">Notifications</h1>

        {/* Notifications List */}
        {notifications.length > 0 ? (
          <div className="space-y-3">
            {notifications.map((notification) => {
              const style = getNotificationStyle(notification.type);
              return (
                <div
                  key={notification.id}
                  className="rounded-lg border border-[#E8EAEF] bg-white p-4 shadow-sm hover:shadow-md transition"
                >
                  <div className="flex gap-4 items-start">
                    {/* Icon */}
                    <div
                      className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg"
                      style={{ backgroundColor: style.bgColor, color: style.textColor }}
                    >
                      {style.icon}
                    </div>

                    {/* Content */}
                    <div className="min-w-0 flex-1">
                      <p className="text-[14px] font-bold text-slate-900">{notification.title}</p>
                      <p className="mt-1 text-[13px] text-slate-600">{notification.description}</p>
                      <div className="mt-2 flex items-center gap-1 text-[12px] text-slate-500">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                          <circle cx="12" cy="12" r="10" />
                          <polyline points="12 6 12 12 16 14" />
                        </svg>
                        {notification.timestamp}
                      </div>

                      {/* Mark as Read Button */}
                      {!notification.isRead && (
                        <button
                          onClick={() => markAsRead(notification.id)}
                          className="mt-3 px-3 py-1.5 text-[12px] font-medium rounded transition hover:opacity-90"
                          style={{
                            backgroundColor: NgoColors.navy,
                            color: "white",
                          }}
                        >
                          Mark as Read
                        </button>
                      )}
                    </div>

                    {/* Unread Indicator */}
                    {!notification.isRead && (
                      <span
                        className="h-2 w-2 shrink-0 rounded-full mt-2"
                        style={{ backgroundColor: NgoColors.navy }}
                      />
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        ) : (
          <div className="rounded-lg border border-dashed border-slate-300 bg-white px-4 py-12 text-center">
            <p className="text-[13px] text-slate-500">You're all caught up! No notifications at the moment.</p>
          </div>
        )}
      </main>
    </div>
  );
}
