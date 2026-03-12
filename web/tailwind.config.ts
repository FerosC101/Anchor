import type { Config } from "tailwindcss";

export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        anchor: {
          primary: "#0A2463",
          "primary-light": "#1E3A8A",
          "primary-dark": "#061540",
          secondary: "#F4A261",
          "secondary-light": "#F7C59F",
          "secondary-dark": "#E07B32",
          accent: "#3A86FF",
          bg: "#F8FAFC",
          surface: "#FFFFFF",
          "surface-variant": "#F1F5F9",
          success: "#10B981",
          warning: "#F59E0B",
          error: "#EF4444",
          info: "#3B82F6",
          "text-primary": "#0F172A",
          "text-secondary": "#64748B",
          "text-hint": "#94A3B8",
          border: "#E2E8F0",
          ofw: "#0EA5E9",
          government: "#8B5CF6",
          ngo: "#10B981",
        },
      },
      backgroundImage: {
        "anchor-gradient": "linear-gradient(135deg, #0A2463 0%, #1E3A8A 100%)",
      },
    },
  },
  plugins: [],
} satisfies Config;
