import { NgoColors } from "../../core/theme/ngo-colors";

export interface NgoStatCardProps {
  icon: React.ReactNode;
  iconColor: string;
  iconBg: string;
  label: string;
  value: string;
  change: string;
  changeLabel: string;
  positive?: boolean;
  isStable?: boolean;
}

export function NgoStatCard({
  icon,
  iconBg,
  label,
  value,
  change,
  changeLabel,
  positive = true,
  isStable = false,
}: NgoStatCardProps) {
  const trendColor = isStable || positive ? NgoColors.resolvedText : NgoColors.escalatedText;

  return (
    <div
      className="rounded-2xl p-3 shadow-sm"
      style={{
        backgroundColor: NgoColors.cardBg,
        border: `1px solid ${NgoColors.border}`,
      }}
    >
      <div className="mb-3 flex items-start justify-between">
        <div
          className="flex h-9 w-9 items-center justify-center rounded-xl text-white"
          style={{ backgroundColor: iconBg }}
        >
          {icon}
        </div>
        <div className="flex items-center gap-1 text-xs font-semibold" style={{ color: trendColor }}>
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M13 2H3m0 0v10m0-10l10 10" />
          </svg>
          {change}
        </div>
      </div>

      <p className="text-2xl font-bold leading-none" style={{ color: NgoColors.textPrimary }}>
        {value}
      </p>
      <p className="mt-2 text-xs font-semibold" style={{ color: "#4A5565" }}>
        {label}
      </p>
      <p className="text-xs" style={{ color: "#4A5565" }}>
        {changeLabel}
      </p>
    </div>
  );
}

export function NgoStatCardGrid() {
  return (
    <div className="grid grid-cols-2 gap-3">
      <NgoStatCard
        icon={<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M12 2v20M2 12h20" /></svg>}
        iconColor="white"
        iconBg={NgoColors.navy}
        label="Total Reports"
        value="8"
        change="+12%"
        changeLabel="vs last month"
        positive
      />
      <NgoStatCard
        icon={<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M3 3v18h18" /></svg>}
        iconColor="white"
        iconBg={NgoColors.navy}
        label="Active Cases"
        value="5"
        change="+8%"
        changeLabel="vs last month"
        positive
      />
      <NgoStatCard
        icon={<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" /></svg>}
        iconColor="white"
        iconBg={NgoColors.navy}
        label="High Risk Employers"
        value="4"
        change="+3"
        changeLabel="new this week"
        positive
      />
      <NgoStatCard
        icon={<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2z" /></svg>}
        iconColor="white"
        iconBg={NgoColors.navy}
        label="Countries Monitored"
        value="10"
        change="Stable"
        changeLabel="no change"
        isStable
      />
    </div>
  );
}
