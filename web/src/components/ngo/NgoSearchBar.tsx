import { NgoColors } from "../../core/theme/ngo-colors";

interface NgoSearchBarProps {
  value: string;
  onChange: (value: string) => void;
  placeholder?: string;
}

export function NgoSearchBar({ 
  value, 
  onChange, 
  placeholder = "Search worker by name or case ID" 
}: NgoSearchBarProps) {
  return (
    <div className="relative">
      <svg
        className="pointer-events-none absolute left-4 top-1/2 -translate-y-1/2"
        width="16"
        height="16"
        viewBox="0 0 24 24"
        fill="none"
        stroke={NgoColors.textHint}
        strokeWidth="2"
      >
        <circle cx="11" cy="11" r="8" />
        <path d="M21 21l-4.3-4.3" />
      </svg>
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className="h-14 w-full rounded-full border pl-11 pr-4 text-sm outline-none transition"
        style={{
          backgroundColor: "#F1F5F9",
          borderColor: NgoColors.border,
          color: "#334155",
        }}
      />
    </div>
  );
}
