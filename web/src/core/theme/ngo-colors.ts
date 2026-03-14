/**
 * NGO Theme Colors
 * Inspired by the mobile NGO theme
 * Consistent color palette for NGO interface
 */

export const NgoColors = {
  // Primary colors
  blueDark: "#003696",
  blueLight: "#DFEDFF",
  navy: "#003696",
  
  // Background colors
  bg: "#F4F4F8",
  cardBg: "#FFFFFF",
  
  // Status badge colors (background and text pairs)
  inReviewBg: "#DFEDFF",
  inReviewText: "#003696",
  
  escalatedBg: "#FFF3F3",
  escalatedText: "#8E0012",
  
  pendingBg: "#FFFBE8",
  pendingText: "#AD4B00",
  
  resolvedBg: "#EEFDF3",
  resolvedText: "#00AA28",
  
  // Risk level colors
  highRiskText: "#AD4B00",
  criticalRiskBg: "#FFF3F3",
  criticalRiskText: "#8E0012",
  highRiskBg: "#FFFBE8",
  
  // Text colors
  textPrimary: "#0F172A",
  textSecondary: "#64748B",
  textHint: "#94A3B8",
  
  // Borders
  border: "#E2E8F0",
  
  // Common utility colors
  success: "#00AA28",
  warning: "#AD4B00",
  error: "#8E0012",
  info: "#003696",
} as const;

/**
 * Get status badge colors based on status type
 */
export type StatusType = "in-review" | "escalated" | "pending" | "resolved";
export type RiskLevel = "high" | "critical";

export const getStatusBadgeColors = (status: StatusType) => {
  const colorMap: Record<StatusType, { bg: string; text: string }> = {
    "in-review": { bg: NgoColors.inReviewBg, text: NgoColors.inReviewText },
    escalated: { bg: NgoColors.escalatedBg, text: NgoColors.escalatedText },
    pending: { bg: NgoColors.pendingBg, text: NgoColors.pendingText },
    resolved: { bg: NgoColors.resolvedBg, text: NgoColors.resolvedText },
  };
  return colorMap[status];
};

export const getRiskBadgeColors = (riskLevel: RiskLevel) => {
  const colorMap: Record<RiskLevel, { bg: string; text: string }> = {
    high: { bg: NgoColors.highRiskBg, text: NgoColors.highRiskText },
    critical: { bg: NgoColors.criticalRiskBg, text: NgoColors.criticalRiskText },
  };
  return colorMap[riskLevel];
};
