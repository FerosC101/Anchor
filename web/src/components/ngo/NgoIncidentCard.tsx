import { NgoColors, getStatusBadgeColors } from "../../core/theme/ngo-colors";

export interface NgoIncidentCardProps {
  workerName: string;
  country: string;
  employer: string;
  issue: string;
  reportId: string;
  status: "in-review" | "escalated" | "pending" | "resolved";
  onViewCase?: () => void;
}

export function NgoIncidentCard({
  workerName,
  country,
  employer,
  issue,
  reportId,
  status,
  onViewCase,
}: NgoIncidentCardProps) {
  const colors = getStatusBadgeColors(status);

  const getInitials = (name: string) => {
    return name
      .split(" ")
      .map((n) => n[0])
      .join("")
      .toUpperCase();
  };

  return (
    <div
      className="rounded-2xl p-4 shadow-sm"
      style={{
        backgroundColor: NgoColors.cardBg,
        border: `1px solid ${NgoColors.border}`,
      }}
    >
      {/* Header */}
      <div className="mb-3 flex items-start justify-between gap-3">
        <div className="flex min-w-0 items-start gap-3">
          <div
            className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl text-xs font-bold"
            style={{
              backgroundColor: NgoColors.blueLight,
              color: NgoColors.blueDark,
            }}
          >
            {getInitials(workerName)}
          </div>
          <div className="min-w-0">
            <p className="text-sm font-bold" style={{ color: NgoColors.textPrimary }}>
              {workerName}
            </p>
            <div className="mt-1 flex items-center gap-1">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke={NgoColors.textHint} strokeWidth="2">
                <path d="M12 21.9c4.595-4.095 7-6.747 7-11.4 0-4.08-2.239-7.5-7-7.5s-7 3.42-7 7.5c0 4.653 2.405 7.305 7 11.4z" />
              </svg>
              <p className="text-xs" style={{ color: NgoColors.textSecondary }}>
                {country}
              </p>
            </div>
          </div>
        </div>
        <div
          className="flex items-center gap-1 rounded-full px-3 py-1 text-xs font-semibold"
          style={{
            backgroundColor: colors.bg,
            color: colors.text,
          }}
        >
          {status === "in-review" && "In Review"}
          {status === "escalated" && "Escalated"}
          {status === "pending" && "Pending"}
          {status === "resolved" && "Resolved"}
        </div>
      </div>

      <div style={{ borderTop: `1px solid ${NgoColors.border}` }} className="my-3" />

      {/* Details */}
      <div className="mb-3 space-y-1">
        <div className="flex gap-3">
          <span className="inline-block w-20 text-xs font-bold" style={{ color: NgoColors.textPrimary }}>
            Employer:
          </span>
          <span className="text-xs" style={{ color: NgoColors.textPrimary }}>
            {employer}
          </span>
        </div>
        <div className="flex gap-3">
          <span className="inline-block w-20 text-xs font-bold" style={{ color: NgoColors.textPrimary }}>
            Issue:
          </span>
          <span className="text-xs" style={{ color: NgoColors.textPrimary }}>
            {issue}
          </span>
        </div>
        <div className="flex gap-3">
          <span className="inline-block w-20 text-xs font-bold" style={{ color: NgoColors.textPrimary }}>
            Report ID:
          </span>
          <span className="text-xs font-semibold" style={{ color: NgoColors.navy }}>
            {reportId}
          </span>
        </div>
      </div>

      {/* Button */}
      <button
        onClick={onViewCase}
        className="mt-3 h-9 w-full rounded-lg font-semibold text-xs text-white transition hover:opacity-90"
        style={{ backgroundColor: NgoColors.navy }}
      >
        View Case
      </button>
    </div>
  );
}
