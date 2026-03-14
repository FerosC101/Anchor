import React, { useState } from "react";
import { NgoColors } from "../../core/theme/ngo-colors";

interface FilterChip {
  label: string;
  value: string;
  onChange: (value: string) => void;
  options: string[];
  icon: React.ReactNode;
}

export function NgoFilterChip({ value, onChange, options, icon }: FilterChip) {
  const [open, setOpen] = useState(false);

  return (
    <>
      <button
        onClick={() => setOpen(!open)}
        className="flex items-center gap-2 rounded-full border px-3 py-2 shadow-sm transition hover:bg-slate-50"
        style={{
          backgroundColor: "white",
          borderColor: NgoColors.border,
        }}
      >
        <span style={{ color: "#64748B" }}>{icon}</span>
        <span
          className="text-xs font-medium leading-none"
          style={{ color: "#334155", maxWidth: "100px" }}
        >
          {value}
        </span>
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" style={{ color: "#64748B" }}>
          <path d="M6 9l6 6 6-6" />
        </svg>
      </button>

      {open && (
        <>
          <div className="fixed inset-0 z-40" onClick={() => setOpen(false)} />
          <div
            className="absolute right-0 top-full mt-2 z-50 min-w-max rounded-xl border shadow-lg"
            style={{
              backgroundColor: "white",
              borderColor: NgoColors.border,
            }}
          >
            {options.map((option) => (
              <button
                key={option}
                onClick={() => {
                  onChange(option);
                  setOpen(false);
                }}
                className={`block w-full px-4 py-2.5 text-left text-sm font-medium transition hover:bg-slate-50 first:rounded-t-lg last:rounded-b-lg ${
                  value === option ? "font-semibold" : ""
                }`}
                style={{
                  color: value === option ? NgoColors.navy : NgoColors.textSecondary,
                }}
              >
                {option}
              </button>
            ))}
          </div>
        </>
      )}
    </>
  );
}

interface NgoFilterChipsProps {
  country: string;
  issue: string;
  status: string;
  onCountryChange: (value: string) => void;
  onIssueChange: (value: string) => void;
  onStatusChange: (value: string) => void;
}

export function NgoFilterChips({
  country,
  issue,
  status,
  onCountryChange,
  onIssueChange,
  onStatusChange,
}: NgoFilterChipsProps) {
  return (
    <div className="flex gap-2">
      <div className="flex-1 relative">
        <NgoFilterChip
          label="Country"
          value={country}
          onChange={onCountryChange}
          options={["All Countries", "Saudi Arabia", "UAE", "Qatar", "Kuwait", "Bahrain"]}
          icon={
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path d="M12 21.9c4.595-4.095 7-6.747 7-11.4 0-4.08-2.239-7.5-7-7.5s-7 3.42-7 7.5c0 4.653 2.405 7.305 7 11.4z" />
              <circle cx="12" cy="10.5" r="1.5" />
            </svg>
          }
        />
      </div>
      <div className="flex-1 relative">
        <NgoFilterChip
          label="Issue"
          value={issue}
          onChange={onIssueChange}
          options={["All Issues", "Wage Theft", "Document Confiscation", "Physical Abuse", "Overwork / Rest Day Denial"]}
          icon={
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path d="M4 4h16v16H4z" />
              <path d="M9 9v6m6-6v6" />
            </svg>
          }
        />
      </div>
      <div className="flex-1 relative">
        <NgoFilterChip
          label="Status"
          value={status}
          onChange={onStatusChange}
          options={["All Status", "In Review", "Escalated", "Pending", "Resolved"]}
          icon={
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path d="M3 4a1 1 0 0 1 1-1h16a1 1 0 0 1 1 1v2.586a1 1 0 0 1-.293.707l-6.414 6.414a1 1 0 0 0-.293.707V17l-4 4v-6.586a1 1 0 0 0-.293-.707L3.293 7.293A1 1 0 0 1 3 6.586V4z" />
            </svg>
          }
        />
      </div>
    </div>
  );
}
