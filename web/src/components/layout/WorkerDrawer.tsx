import { ReactNode } from "react";
import { NgoColors } from "../../core/theme/ngo-colors";

interface DrawerMenuItemProps {
  icon: ReactNode;
  label: string;
  onClick: () => void;
  badge?: string;
  isLogout?: boolean;
}

function DrawerMenuItem({ icon, label, onClick, badge, isLogout }: DrawerMenuItemProps) {
  return (
    <button
      onClick={onClick}
      className={`flex w-full items-center gap-3 rounded-lg px-4 py-3 transition-colors ${
        isLogout
          ? "text-red-500 hover:bg-red-50"
          : "text-slate-700 hover:bg-slate-50"
      }`}
    >
      <span className="text-lg">{icon}</span>
      <span className="flex-1 text-left text-sm font-medium">{label}</span>
      {badge && (
        <span className="rounded-full bg-red-500 px-2 py-0.5 text-xs font-bold text-white">
          {badge}
        </span>
      )}
    </button>
  );
}

function DrawerSectionLabel({ label }: { label: string }) {
  return (
    <div className="px-4 py-3">
      <p className="text-xs font-bold tracking-wider text-slate-400 uppercase">{label}</p>
    </div>
  );
}

interface WorkerDrawerProps {
  isOpen: boolean;
  onClose: () => void;
  onProfileClick: () => void;
  onNotificationsClick: () => void;
  onPrivacyClick: () => void;
  onSafetyResourcesClick: () => void;
  onHelpClick: () => void;
  onLogoutClick: () => void;
  notificationCount?: number;
  userName?: string;
  userEmail?: string;
}

function PersonIcon() {
  return (
    <svg
      width="20"
      height="20"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
    >
      <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2M12 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8Z" />
    </svg>
  );
}

function BellIcon() {
  return (
    <svg
      width="20"
      height="20"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
    >
      <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9M13.73 21a2 2 0 0 1-3.46 0" />
    </svg>
  );
}

function LockIcon() {
  return (
    <svg
      width="20"
      height="20"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
    >
      <path d="M12 1v6m0 6v6M5.64 5.64a8 8 0 1 1 11.32 11.32 8 8 0 0 1-11.32-11.32z" />
    </svg>
  );
}

function ShieldIcon() {
  return (
    <svg
      width="20"
      height="20"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
    >
      <path d="M12 3l7 4v5c0 5-3.5 9-7 10-3.5-1-7-5-7-10V7l7-4z" />
      <path d="M9 12l2 2 4-4" />
    </svg>
  );
}

function HelpIcon() {
  return (
    <svg
      width="20"
      height="20"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
    >
      <path d="M9.09 9a3 3 0 1 1 5.82 1c0 2-3 2-3 4" />
      <path d="M12 17h.01" />
      <circle cx="12" cy="12" r="10" />
    </svg>
  );
}

function LogoutIcon() {
  return (
    <svg
      width="20"
      height="20"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
    >
      <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 3l4 4m0 0l-4 4m4-4H9" />
    </svg>
  );
}

export function WorkerDrawer({
  isOpen,
  onClose,
  onProfileClick,
  onNotificationsClick,
  onPrivacyClick,
  onSafetyResourcesClick,
  onHelpClick,
  onLogoutClick,
  notificationCount = 0,
  userName = "Guest User",
  userEmail = "guest@demo.com",
}: WorkerDrawerProps) {
  if (!isOpen) return null;

  return (
    <>
      <div
        className="fixed inset-0 z-40 bg-black/25"
        onClick={onClose}
      />
      <div className="fixed right-0 top-0 z-50 h-full w-80 overflow-y-auto bg-white shadow-lg">
        <div
          className="px-6 py-8 text-white"
          style={{
            background: `linear-gradient(135deg, ${NgoColors.blueLight} 0%, ${NgoColors.blueDark} 100%)`,
          }}
        >
          <div className="flex items-center gap-3">
            <div
              className="flex h-12 w-12 items-center justify-center rounded-full"
              style={{ backgroundColor: "rgba(255,255,255,0.25)" }}
            >
              <PersonIcon />
            </div>
            <div>
              <p className="font-semibold">{userName}</p>
              <p className="text-sm opacity-90">{userEmail}</p>
              <span className="mt-2 inline-flex rounded-full bg-white/20 px-2.5 py-1 text-xs font-semibold">
                Migrant Worker
              </span>
            </div>
          </div>
        </div>

        <div className="divide-y">
          <div className="py-2">
            <DrawerSectionLabel label="Account" />
            <DrawerMenuItem
              icon={<PersonIcon />}
              label="My Profile"
              onClick={() => {
                onProfileClick();
                onClose();
              }}
            />
            <DrawerMenuItem
              icon={<BellIcon />}
              label="Notifications"
              badge={notificationCount > 0 ? notificationCount.toString() : undefined}
              onClick={() => {
                onNotificationsClick();
                onClose();
              }}
            />
          </div>

          <div className="py-2">
            <DrawerSectionLabel label="Security" />
            <DrawerMenuItem
              icon={<LockIcon />}
              label="Privacy & Security"
              onClick={() => {
                onPrivacyClick();
                onClose();
              }}
            />
            <DrawerMenuItem
              icon={<ShieldIcon />}
              label="Safety Resources"
              onClick={() => {
                onSafetyResourcesClick();
                onClose();
              }}
            />
          </div>

          <div className="py-2">
            <DrawerSectionLabel label="Support" />
            <DrawerMenuItem
              icon={<HelpIcon />}
              label="Help & Support"
              onClick={() => {
                onHelpClick();
                onClose();
              }}
            />
          </div>

          <div className="py-2">
            <DrawerMenuItem
              icon={<LogoutIcon />}
              label="Logout"
              isLogout
              onClick={() => {
                onLogoutClick();
                onClose();
              }}
            />
          </div>
        </div>
      </div>
    </>
  );
}
