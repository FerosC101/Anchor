import { NgoColors } from "../../core/theme/ngo-colors";

export interface NgoEmployerCardProps {
  employer: string;
  type: string;
  country: string;
  riskLevel: "high" | "critical";
  reports: number;
  onViewDetails?: () => void;
}

function getRiskBadgeColor(level: "high" | "critical") {
  if (level === "critical") {
    return {
      bg: NgoColors.escalatedBg,
      text: NgoColors.escalatedText,
      dot: NgoColors.escalatedText,
    };
  }
  return {
    bg: NgoColors.highRiskBg,
    text: NgoColors.highRiskText,
    dot: NgoColors.highRiskText,
  };
}

export function NgoEmployerCard({
  employer,
  type,
  country,
  riskLevel,
  reports,
}: NgoEmployerCardProps) {
  const colors = getRiskBadgeColor(riskLevel);

  const getInitials = (name: string) => {
    return name
      .split(" ")
      .map((word) => word[0])
      .join("")
      .toUpperCase()
      .slice(0, 2);
  };

  return (
    <div
      className="rounded-2xl shadow-sm"
      style={{
        backgroundColor: NgoColors.cardBg,
        border: `1px solid ${NgoColors.border}`,
      }}
    >
      {/* Top Section */}
      <div className="border-b px-4 py-4" style={{ borderColor: NgoColors.border }}>
        <div className="flex items-start justify-between gap-3">
          <div className="flex min-w-0 items-start gap-3">
            <div
              className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl text-xs font-bold"
              style={{
                backgroundColor: NgoColors.blueLight,
                color: NgoColors.blueDark,
              }}
            >
              {getInitials(employer)}
            </div>
            <div className="min-w-0">
              <p className="truncate font-bold text-sm" style={{ color: NgoColors.textPrimary }}>
                {employer}
              </p>
              <p className="text-xs" style={{ color: NgoColors.textSecondary }}>
                {type}
              </p>
            </div>
          </div>

          {/* Risk Badge */}
          <div
            className="flex items-center gap-1.5 rounded-full px-2.5 py-1 text-xs font-semibold whitespace-nowrap"
            style={{
              backgroundColor: colors.bg,
              color: colors.text,
            }}
          >
            <div
              className="h-1.5 w-1.5 rounded-full"
              style={{ backgroundColor: colors.dot }}
            />
            {riskLevel === "critical" ? "Critical" : "High"}
          </div>
        </div>
      </div>

      {/* Bottom Section */}
      <div className="flex items-center justify-between px-4 py-4">
        <div className="flex items-center gap-1">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke={NgoColors.textHint} strokeWidth="2">
            <path d="M12 21.9c4.595-4.095 7-6.747 7-11.4 0-4.08-2.239-7.5-7-7.5s-7 3.42-7 7.5c0 4.653 2.405 7.305 7 11.4z" />
          </svg>
          <span className="text-xs" style={{ color: NgoColors.textSecondary }}>
            {country}
          </span>
        </div>

        <div className="text-right">
          <p className="text-xl font-bold leading-none" style={{ color: NgoColors.textPrimary }}>
            {reports}
          </p>
          <p className="text-xs" style={{ color: NgoColors.textSecondary }}>
            Reports
          </p>
        </div>
      </div>
    </div>
  );
}
