import { getStatusBadgeColors, RiskLevel, getRiskBadgeColors } from "../../core/theme/ngo-colors";

interface StatusBadgeProps {
  status: "in-review" | "escalated" | "pending" | "resolved";
  className?: string;
}

/**
 * StatusBadge - NGO inspired badge with filled background, no border
 */
export function StatusBadge({ status, className = "" }: StatusBadgeProps) {
  const colors = getStatusBadgeColors(status);
  const statusLabels = {
    "in-review": "In Review",
    escalated: "Escalated",
    pending: "Pending",
    resolved: "Resolved",
  };

  return (
    <span
      className={`inline-flex items-center whitespace-nowrap rounded-full px-3 py-1 text-xs font-semibold ${className}`}
      style={{
        backgroundColor: colors.bg,
        color: colors.text,
      }}
    >
      {statusLabels[status]}
    </span>
  );
}

/**
 * RiskBadge - Badge for risk levels (High/Critical)
 */
interface RiskBadgeProps {
  level: RiskLevel;
  className?: string;
}

export function RiskBadge({ level, className = "" }: RiskBadgeProps) {
  const colors = getRiskBadgeColors(level);
  const labels = {
    high: "High",
    critical: "Critical",
  };

  return (
    <span
      className={`inline-flex items-center whitespace-nowrap rounded-full px-3 py-1 text-xs font-semibold ${className}`}
      style={{
        backgroundColor: colors.bg,
        color: colors.text,
      }}
    >
      {labels[level]}
    </span>
  );
}
