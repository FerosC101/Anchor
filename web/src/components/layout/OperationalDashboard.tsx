import { useState } from "react";
import { NgoColors } from "../../core/theme/ngo-colors";
import { NgoDrawer } from "./NgoDrawer";

export type DashboardIconName =
  | "alert"
  | "trend"
  | "people"
  | "pin"
  | "user"
  | "shield"
  | "check"
  | "flag"
  | "briefcase"
  | "clock";

export type DashboardBadgeTone =
  | "sky"
  | "amber"
  | "emerald"
  | "slate"
  | "orange"
  | "rose"
  | "violet";

export interface DashboardNavItem {
  label: string;
  active?: boolean;
  onClick?: () => void;
}

export interface DashboardSummaryCard {
  value: string;
  label: string;
  sub: string;
  trend: string;
  icon: DashboardIconName;
}

export interface DashboardFilterConfig {
  value: string;
  onChange: (value: string) => void;
  options: string[];
}

export interface DashboardCardField {
  label: string;
  value: string;
  accent?: boolean;
}

export interface DashboardPrimaryCard {
  id: number | string;
  initials: string;
  title: string;
  subtitle: string;
  badgeLabel: string;
  badgeTone: DashboardBadgeTone;
  fields: DashboardCardField[];
  actionLabel: string;
}

export interface DashboardSecondaryRow {
  id: number | string;
  initials: string;
  title: string;
  subtitle: string;
  secondaryText: string;
  secondaryIcon?: "pin" | "clock";
  badgeLabel: string;
  badgeTone: DashboardBadgeTone;
  metric: string;
}

export interface DashboardSectionConfig {
  title: string;
  buttonLabel?: string;
  hideButton?: boolean;
}

interface OperationalDashboardProps {
  pageTitle: string;
  navItems: DashboardNavItem[];
  summaryCards: DashboardSummaryCard[];
  searchPlaceholder: string;
  searchValue: string;
  onSearchChange: (value: string) => void;
  filters: DashboardFilterConfig[];
  primarySection: DashboardSectionConfig;
  primaryCards: DashboardPrimaryCard[];
  primaryEmptyMessage: string;
  secondarySection: DashboardSectionConfig & {
    columns: [string, string, string, string];
  };
  secondaryRows: DashboardSecondaryRow[];
  headerAction?: {
    label: string;
    onClick: () => void;
  };
  unreadNotificationCount?: number;
  showDrawer?: boolean;
  onDrawerOpen?: () => void;
  onDrawerClose?: () => void;
  onProfileClick?: () => void;
  onNotificationsClick?: () => void;
  onPrivacyClick?: () => void;
  onLogoutClick?: () => void;
}

function getBadgeColors(tone: DashboardBadgeTone) {
  const colorMap: Record<DashboardBadgeTone, { bgColor: string; textColor: string }> = {
    sky: { bgColor: NgoColors.inReviewBg, textColor: NgoColors.inReviewText },
    amber: { bgColor: NgoColors.pendingBg, textColor: NgoColors.pendingText },
    emerald: { bgColor: NgoColors.resolvedBg, textColor: NgoColors.resolvedText },
    slate: { bgColor: "#F1F5F9", textColor: "#475569" },
    orange: { bgColor: NgoColors.highRiskBg, textColor: NgoColors.highRiskText },
    rose: { bgColor: NgoColors.escalatedBg, textColor: NgoColors.escalatedText },
    violet: { bgColor: NgoColors.blueDark, textColor: "#FFFFFF" },
  };
  return colorMap[tone];
}

// ─── Icon Components ────────────────────────────────────────────────────────────

function BellIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 00-5-5.917V4a1 1 0 10-2 0v1.083A6 6 0 006 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
      />
    </svg>
  );
}

function MenuIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
    </svg>
  );
}

function SearchIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
      <circle cx="11" cy="11" r="8" />
      <path strokeLinecap="round" d="M21 21l-4.3-4.3" />
    </svg>
  );
}

function AlertTriangleIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path strokeLinecap="round" strokeLinejoin="round" d="M12 9v4" />
      <path strokeLinecap="round" strokeLinejoin="round" d="M12 17h.01" />
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"
      />
    </svg>
  );
}

function TrendIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path strokeLinecap="round" strokeLinejoin="round" d="M5 12l4 4L19 7" />
    </svg>
  );
}

function PeopleIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M17 21v-2a4 4 0 00-4-4H7a4 4 0 00-4 4v2M16 7a3 3 0 11-6 0 3 3 0 016 0zm5 14v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"
      />
    </svg>
  );
}

function UserIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2M12 11a4 4 0 100-8 4 4 0 000 8z"
      />
    </svg>
  );
}

function ShieldIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 3l7 4v5c0 5-3.5 8-7 9-3.5-1-7-4-7-9V7l7-4z"
      />
    </svg>
  );
}

function CheckIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
    </svg>
  );
}

function FlagIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path strokeLinecap="round" strokeLinejoin="round" d="M4 4v16M4 6h12l-2 4 2 4H4" />
    </svg>
  );
}

function BriefcaseIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M9 7V5a3 3 0 013-3h0a3 3 0 013 3v2m5 2H4a1 1 0 00-1 1v8a2 2 0 002 2h14a2 2 0 002-2v-8a1 1 0 00-1-1z"
      />
    </svg>
  );
}

function PinIcon({ className }: { className?: string }) {
  return (
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" className={className}>
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 21s-6-4.35-6-10a6 6 0 1112 0c0 5.65-6 10-6 10z"
      />
      <circle cx="12" cy="11" r="2.5" />
    </svg>
  );
}

function ClockIcon({ className }: { className?: string }) {
  return (
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" className={className}>
      <circle cx="12" cy="12" r="9" />
      <path strokeLinecap="round" strokeLinejoin="round" d="M12 7v5l3 2" />
    </svg>
  );
}

function FilterChevronIcon() {
  return (
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
      <path strokeLinecap="round" strokeLinejoin="round" d="M6 9l6 6 6-6" />
    </svg>
  );
}

function SummaryIcon({ type }: { type: DashboardIconName }) {
  switch (type) {
    case "alert":
      return <AlertTriangleIcon />;
    case "trend":
      return <TrendIcon />;
    case "people":
      return <PeopleIcon />;
    case "user":
      return <UserIcon />;
    case "shield":
      return <ShieldIcon />;
    case "check":
      return <CheckIcon />;
    case "flag":
      return <FlagIcon />;
    case "briefcase":
      return <BriefcaseIcon />;
    default:
      return <PinIcon />;
  }
}

function MetaIcon({ icon }: { icon?: "pin" | "clock" }) {
  if (icon === "clock") return <ClockIcon className="text-slate-300" />;
  return <PinIcon className="text-slate-300" />;
}

export default function OperationalDashboard({
  pageTitle,
  navItems,
  summaryCards,
  searchPlaceholder,
  searchValue,
  onSearchChange,
  filters,
  primarySection,
  primaryCards,
  primaryEmptyMessage,
  secondarySection,
  secondaryRows,
  headerAction,
  unreadNotificationCount = 0,
  showDrawer: initialShowDrawer = false,
  onDrawerOpen,
  onDrawerClose,
  onProfileClick,
  onNotificationsClick,
  onPrivacyClick,
  onLogoutClick,
}: OperationalDashboardProps) {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [drawerOpen, setDrawerOpen] = useState(initialShowDrawer);

  const handleDrawerOpen = () => {
    setDrawerOpen(true);
    onDrawerOpen?.();
  };

  const handleDrawerClose = () => {
    setDrawerOpen(false);
    onDrawerClose?.();
  };

  return (
    <>
      <div className="min-h-screen text-slate-800" style={{ backgroundColor: NgoColors.bg }}>
        <header className="sticky top-0 z-20 border-b border-[#D9DCE3] bg-white/95 backdrop-blur w-full">
        <div className="mx-auto flex h-[54px] w-full items-center px-4 sm:px-6 lg:px-8">
          {/* Logo */}
          <div className="flex items-center gap-3 flex-shrink-0">
            <span className="h-6 w-6 rounded-full bg-[#003696]" />
            <p className="text-[20px] font-extrabold text-[#003696] tracking-[-0.03em]">Anchor</p>
          </div>

          {/* Center Navigation */}
          <nav className="hidden md:flex flex-1 items-center justify-center gap-12 text-[14px] font-semibold text-slate-500">
            {navItems.map((item) => (
              <button
                key={item.label}
                onClick={item.onClick}
                className={`relative transition ${item.active ? "text-[#003696]" : "hover:text-slate-700"}`}
              >
                {item.label}
                {item.active ? (
                  <span className="absolute -bottom-[17px] left-1/2 h-[2px] w-16 -translate-x-1/2 rounded-full bg-[#003696]" />
                ) : null}
              </button>
            ))}
          </nav>

          {/* Right Actions */}
          <div className="flex flex-shrink-0 items-center gap-3 text-slate-500 ml-auto">
            <button 
              className="rounded-md p-1.5 hover:bg-slate-100 relative"
              onClick={() => onNotificationsClick?.()}
            >
              <BellIcon />
              {unreadNotificationCount > 0 && (
                <span 
                  className="absolute top-0 right-0 flex h-5 w-5 items-center justify-center rounded-full text-[11px] font-bold text-white"
                  style={{ backgroundColor: "#8E0012" }}
                >
                  {unreadNotificationCount}
                </span>
              )}
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
              className="rounded-md p-1.5 hover:bg-slate-100"
              onClick={handleDrawerOpen}
              aria-label="Open menu"
            >
              <MenuIcon />
            </button>
          </div>
        </div>

        {mobileMenuOpen ? (
          <div className="border-t border-slate-100 bg-white px-5 py-3 md:hidden">
            <div className="flex flex-col gap-1">
              {navItems.map((item) => (
                <button
                  key={item.label}
                  onClick={() => {
                    item.onClick?.();
                    setMobileMenuOpen(false);
                  }}
                  className={`rounded-xl px-3 py-2.5 text-left text-sm font-medium ${
                    item.active ? "bg-blue-50 text-[#003696]" : "text-slate-600 hover:bg-slate-50"
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

      <main className="mx-auto w-full px-4 py-6 sm:px-6 lg:px-8">
        <h1 className="text-[16px] font-extrabold tracking-[-0.01em] text-slate-900">{pageTitle}</h1>

        <section className="mt-4 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
          {summaryCards.map((card) => (
            <article key={card.label} className="rounded-[14px] border border-[#DEE2E8] bg-white p-4 shadow-[0_1px_2px_rgba(15,23,42,0.04)]">
            <div className="mb-3 flex items-start justify-between">
                <span className="flex h-8 w-8 items-center justify-center rounded-[8px] bg-[#003696] text-white">
                  <SummaryIcon type={card.icon} />
                </span>
                <span className="text-[10px] font-semibold text-emerald-500">{card.trend}</span>
              </div>
              <p className="text-[34px] font-bold leading-none text-slate-900">{card.value}</p>
              <p className="mt-2 text-[11px] font-semibold text-slate-700">{card.label}</p>
              <p className="text-[10px] text-slate-400">{card.sub}</p>
            </article>
          ))}
        </section>

        <section className="mt-7">
          <div className="mb-4 flex items-center justify-between gap-3">
            <h2 className="text-[15px] font-extrabold tracking-[-0.01em] text-slate-900">{primarySection.title}</h2>
            {!primarySection.hideButton && primarySection.buttonLabel ? (
              <button className="rounded-md bg-[#003696] px-3 py-1.5 text-[10px] font-semibold text-white shadow-sm hover:bg-[#002060]\">
                {primarySection.buttonLabel}
              </button>
            ) : null}
          </div>

          <div className="mb-4 flex flex-col gap-3 lg:flex-row lg:items-center">
            <label className="relative block flex-1">
              <span className="pointer-events-none absolute left-4 top-1/2 -translate-y-1/2 text-slate-300">
                <SearchIcon />
              </span>
              <input
                type="text"
                placeholder={searchPlaceholder}
                value={searchValue}
                onChange={(e) => onSearchChange(e.target.value)}
                className="h-[42px] w-full rounded-full border border-[#E2E5EA] bg-white pl-11 pr-4 text-[11px] text-slate-600 outline-none ring-[#003696]/15 transition focus:ring-4"
              />
            </label>

            <div
              className={`grid grid-cols-1 gap-2 lg:w-[520px] ${
                filters.length === 1
                  ? "sm:grid-cols-1"
                  : filters.length === 2
                    ? "sm:grid-cols-2"
                    : "sm:grid-cols-3"
              }`}
            >
              {filters.map((filter) => (
                <div key={filter.options[0]} className="relative">
                  <select
                    value={filter.value}
                    onChange={(e) => filter.onChange(e.target.value)}
                    className="h-[42px] w-full appearance-none rounded-full border border-[#E2E5EA] bg-white px-4 pr-9 text-[11px] font-medium text-slate-600 outline-none ring-[#003696]/15 focus:ring-4"
                  >
                    {filter.options.map((option) => (
                      <option key={option}>{option}</option>
                    ))}
                  </select>
                  <span className="pointer-events-none absolute right-4 top-1/2 -translate-y-1/2 text-slate-300">
                    <FilterChevronIcon />
                  </span>
                </div>
              ))}
            </div>
          </div>

          {primaryCards.length > 0 ? (
            <div className="grid w-full gap-4 md:grid-cols-2 lg:grid-cols-2">
              {primaryCards.map((card) => (
                <article key={card.id} className="rounded-[14px] border border-[#DEE2E8] bg-white p-4 shadow-[0_1px_2px_rgba(15,23,42,0.04)]">
                  <div className="mb-3 flex items-start justify-between gap-3">
                    <div className="flex min-w-0 items-start gap-3">
                      <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-[#E7EAF0] text-[10px] font-bold text-slate-700">
                        {card.initials}
                      </span>
                      <div className="min-w-0">
                        <p className="truncate text-[13px] font-bold text-slate-800">{card.title}</p>
                        <p className="flex items-center gap-1 text-[10px] text-slate-400">
                          <MetaIcon icon="pin" />
                          {card.subtitle}
                        </p>
                      </div>
                    </div>
                    {(() => {
                      const colors = getBadgeColors(card.badgeTone);
                      return (
                        <span
                          className="flex h-6 items-center whitespace-nowrap rounded-full px-3 text-[10px] font-bold"
                          style={{
                            backgroundColor: colors.bgColor,
                            color: colors.textColor,
                          }}
                        >
                          {card.badgeLabel}
                        </span>
                      );
                    })()}
                  </div>

                  <div className="space-y-1 text-[11px] leading-5">
                    {card.fields.map((field) => (
                      <p key={`${card.id}-${field.label}`} className="text-slate-500">
                        <span className="font-semibold text-slate-700">{field.label}:</span>{" "}
                        <span className={field.accent ? "font-semibold text-[#003696]" : undefined}>{field.value}</span>
                      </p>
                    ))}
                  </div>

                  <div className="mt-3 flex gap-3">
                    <button 
                      className="flex-1 rounded-lg px-5 py-2 text-[12px] font-bold text-white hover:opacity-90 transition"
                      style={{ backgroundColor: NgoColors.navy }}
                    >
                      {card.actionLabel}
                    </button>
                  
                  </div>
                </article>
              ))}
            </div>
          ) : (
            <p className="rounded-2xl border border-dashed border-slate-300 bg-white px-5 py-10 text-center text-sm text-slate-500">
              {primaryEmptyMessage}
            </p>
          )}
        </section>

        <section className="mt-7 pb-8">
          <div className="mb-4 flex items-center justify-between gap-3">
            <h2 className="text-[15px] font-extrabold tracking-[-0.01em] text-slate-900">{secondarySection.title}</h2>
            <button className="rounded-md bg-[#003696] px-3 py-1.5 text-[10px] font-semibold text-white shadow-sm hover:bg-[#002060]\">
              {secondarySection.buttonLabel}
            </button>
          </div>

          <div className="space-y-3">
            <div className="grid grid-cols-[minmax(0,2.3fr)_minmax(0,1.5fr)_minmax(0,1fr)_72px] px-3 text-[10px] font-bold uppercase tracking-wide text-slate-400 sm:px-4">
              <div>{secondarySection.columns[0]}</div>
              <div>{secondarySection.columns[1]}</div>
              <div>{secondarySection.columns[2]}</div>
              <div className="text-right">{secondarySection.columns[3]}</div>
            </div>
            {secondaryRows.map((row) => (
              <div
                key={row.id}
                className="grid grid-cols-[minmax(0,2.3fr)_minmax(0,1.5fr)_minmax(0,1fr)_72px] items-center rounded-[14px] border border-[#DEE2E8] bg-white px-3 py-3 text-sm shadow-[0_1px_2px_rgba(15,23,42,0.04)] sm:px-4"
              >
                <div className="flex items-start gap-3">
                  <span className="mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-[#E7EAF0] text-[10px] font-bold text-slate-700">
                    {row.initials}
                  </span>
                  <div>
                    <p className="text-[12px] font-semibold text-slate-800">{row.title}</p>
                    <p className="text-[10px] text-slate-400">{row.subtitle}</p>
                  </div>
                </div>
                <div className="flex items-center gap-1.5 text-[11px] text-slate-500">
                  <MetaIcon icon={row.secondaryIcon} />
                  {row.secondaryText}
                </div>
                <div>
                  {(() => {
                    const colors = getBadgeColors(row.badgeTone);
                    return (
                      <span
                        className="inline-flex h-6 items-center whitespace-nowrap rounded-full px-3 text-[10px] font-bold"
                        style={{
                          backgroundColor: colors.bgColor,
                          color: colors.textColor,
                        }}
                      >
                        {row.badgeLabel}
                      </span>
                    );
                  })()}
                </div>
                <div className="text-right text-[12px] font-semibold text-slate-700">{row.metric}</div>
              </div>
            ))}
          </div>
        </section>
      </main>
      </div>

      <NgoDrawer
        isOpen={drawerOpen}
        onClose={handleDrawerClose}
        onProfileClick={onProfileClick || (() => {})}
        onNotificationsClick={onNotificationsClick || (() => {})}
        onPrivacyClick={onPrivacyClick || (() => {})}
        onLogoutClick={onLogoutClick || (() => {})}
      />
    </>
  );
}