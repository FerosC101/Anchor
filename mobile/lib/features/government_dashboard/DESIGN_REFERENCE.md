# Government Dashboard - Design Reference

## 📐 Layout Structure

```
┌─────────────────────────────────────┐
│        HEADER (60dp)                │
│  [Logo] Anchor    [🔔] [≡]         │
├─────────────────────────────────────┤
│                                     │
│  Government Dashboard              │
│  Overview of flagged cases...       │  ← 24dp padding
│                                     │
├─────────────────────────────────────┤
│                                     │
│    ┌─────────────────────────────┐  │
│    │  System overview            │  │ ← Gradient Card
│    │  ┌──────┐ ┌──────┐ ...     │  │
│    │  │  47  │ │  8   │         │  │
│    │  │ Abuse│ │Support          │  │
│    │  └──────┘ └──────┘         │  │
│    └─────────────────────────────┘  │
│                                     │  ← 32dp gap
│    Abuse Reports Summary           │
│    ┌─────────────────────────────┐  │
│    │ ┌──┐    ┌──┐    ┌──┐       │  │
│    │ │  │    │  │    │  │       │  │
│    │ │  │ SA │  │ UAE│  │ Kuwait│  │
│    │ └──┘    └──┘    └──┘       │  │
│    └─────────────────────────────┘  │
│                                     │  ← 32dp gap
│    Recent Alerts Feed              │
│    ┌─────────────────────────────┐  │
│    │ [👤] Worker Name        [→] │  │ ← Alert Card
│    │     Country                 │  │
│    │     [In review]             │  │
│    └─────────────────────────────┘  │
│    ┌─────────────────────────────┐  │
│    │ [👤] Worker Name        [→] │  │ ← 12dp gap
│    │     Country                 │  │
│    │     [In review]             │  │
│    └─────────────────────────────┘  │
│    (3 more alerts...)               │
│                                     │
├─────────────────────────────────────┤
│ [🏠] [📊] [👥] [👤]                │  ← Bottom Nav (56dp)
│ Home Monitoring Assistance Profile  │
└─────────────────────────────────────┘
```

---

## 🎨 Color Palette

```
PRIMARY GRADIENT
┌────────────────────────┐
│ #0A2463 (Navy Dark)    │ Top-Left
│         ↘              │
│    #1E3A8A (Navy)      │ Bottom-Right
└────────────────────────┘

WHITE BACKGROUNDS
┌────────────────────────┐
│ #FFFFFF (Pure White)   │ Cards & Surface
│ #F8FAFC (Light Gray)   │ Page Background
└────────────────────────┘

TEXT COLORS
┌────────────────────────┐
│ #0F172A (Dark Navy)    │ Primary Text
│ #64748B (Slate Gray)   │ Secondary Text
│ #94A3B8 (Light Slate)  │ Tertiary Text
│ #FFFFFF (White)        │ On Primary
└────────────────────────┘

STATUS COLORS
┌────────────────────────┐
│ #3B82F6 (Blue)         │ Info/In Review
│ #10B981 (Green)        │ Success
│ #F59E0B (Amber)        │ Warning
│ #EF4444 (Red)          │ Error/High Risk
└────────────────────────┘

BORDERS & DIVIDERS
┌────────────────────────┐
│ #E2E8F0 (Light Border) │ Default
│ #0A2463 (Navy)         │ Focus State
└────────────────────────┘
```

---

## 📏 Sizing Reference

```
HEADER
├─ Height: 60dp (including top safe area padding)
├─ Logo Circle: 36x36dp
├─ Icon Buttons: 48x48dp (tap target)
└─ Padding: 16dp horizontal, 12dp vertical

SYSTEM OVERVIEW CARD
├─ Border Radius: 16dp
├─ Padding: 24dp vertical, 16dp horizontal
├─ Title Font: 16px semi-bold
├─ Number Font: 28px bold
├─ Label Font: 12px semi-bold
└─ Column Width: Equal distribution

CHART
├─ Container Height: ~250dp (with labels)
├─ Chart Area: 180dp
├─ Bar Width: 32dp each
├─ Bar Border Radius: 8dp (top only)
├─ Label Font: 10px
└─ Divider: 1dp line

ALERT CARDS
├─ Height: ~96dp per card
├─ Border Radius: 12dp
├─ Border: 1dp solid #E2E8F0
├─ Padding: 16dp all around
├─ Avatar: 48x48dp circle
├─ Status Badge: 10px font, 6dp border radius
└─ Chevron Icon: 20x20dp

BOTTOM NAVIGATION
├─ Height: 56dp
├─ Tab Width: 25% of screen
├─ Icon Size: 24dp
├─ Label Font: 12px
└─ Selected Color: Primary (#0A2463)
```

---

## 📊 Chart Data Breakdown

```
COUNTRIES DISPLAYED (6 total)
┌────────────────────────────────────────┐
│ Country        │ Reports │ % of Max   │
├────────────────────────────────────────┤
│ Saudi Arabia   │  95     │ 95%  ████  │
│ UAE            │  75     │ 75%  ███   │
│ Kuwait         │  60     │ 60%  ██    │
│ Qatar          │  45     │ 45%  ██    │
│ Oman           │  35     │ 35%  █     │
│ Bahrain        │  25     │ 25%  █     │
└────────────────────────────────────────┘

VISUAL REPRESENTATION
  ┌──────────────────────────────────────┐
  │ Bar heights scale proportionally:    │
  │                                      │
  │ █████  ████   ███    ██    █     █   │
  │ █████  ████   ███    ██    █     █   │
  │ █████  ████   ███    ██    █     █   │
  │ █████  ████   ███    ██    █     █   │
  │ █████  ████   ███    ██    █     █   │
  │ SA     UAE   Kuwait Qatar Oman Bahr   │
  └──────────────────────────────────────┘
```

---

## 🎭 System Overview Stats

```
┌──────────────────────────────────────────┐
│    47    │    8     │    23    │    12    │
├──────────┼──────────┼──────────┼──────────┤
│  Abuse   │ Support  │ High-Risk│ Contract │
│ Reports  │ Requests │Employers │  Issues  │
└──────────┴──────────┴──────────┴──────────┘

Each stat:
- Large number (28px bold white)
- Label text (12px semi-bold white)
- Equal width distribution
- Vertical alignment: centered
```

---

## 📋 Alert Card Structure

```
┌────────────────────────────────────────────┐
│ [👤] Worker Name           [In review] [→] │
│      Country              Details Info      │
│                                            │
│ Layout:                                    │
│ ┌────┬──────────────────────┬───┬──────┐  │
│ │ 👤 │ Name & Country       │   │ [→] │  │
│ │    │                      │Stα│     │  │
│ │48x │ Left-aligned text    │us│20dp │  │
│ │48  │                      │   │     │  │
│ └────┴──────────────────────┴───┴──────┘  │
│                                            │
│ 16dp padding on all sides                  │
│ 8dp gap between sections                   │
└────────────────────────────────────────────┘

Text Hierarchy:
- Worker Name: 14px semi-bold (#0F172A)
- Country: 12px regular (#64748B)
- Status Badge: 11px semi-bold (#3B82F6) on light blue
- Details: 10px regular (#64748B)
```

---

## 🎯 Typography Scale

```
Headings
├─ 24px bold (#0F172A)     "Government Dashboard"
├─ 16px semi-bold (#0F172A) "Section Titles"
└─ 14px semi-bold (#0F172A) "Card Headers"

Body Text
├─ 14px regular (#0F172A)   "Normal text"
├─ 13px regular (#64748B)   "Secondary text"
├─ 12px regular (#64748B)   "Small text"
└─ 10px regular (#64748B)   "Micro text"

Special Cases
├─ 28px bold white (Chart stats)
├─ 18px bold (#0A2463) (Logo text "Anchor")
└─ 11px semi-bold (Status badges)
```

---

## 🎪 State Variations

### Bottom Navigation States
```
INACTIVE STATE          ACTIVE STATE
├─ Color: #CBD5E1       ├─ Color: #0A2463
├─ Icon: outlined       ├─ Icon: filled
└─ Label: gray          └─ Label: navy

HOME  MONITORING    →    HOME  MONITORING
(outlined)  (filled)      (filled) (outlined)
```

### Alert Status Badge
```
"In review" Badge
┌──────────────┐
│ In review    │  Light blue background (#EBF5FF)
└──────────────┘  Blue text (#3B82F6)
                  Border radius: 6dp
                  Padding: 10px horizontal, 4px vertical
```

---

## 🔲 Responsive Breakpoints

```
MOBILE (Default: 320dp - 600dp width)
├─ Horizontal Padding: 16dp
├─ Layout: Single column
└─ Safe Area: Managed

TABLET (600dp+)
├─ Could use 2-column layout
├─ Larger spacing
└─ Future enhancement

Current Implementation: Mobile First
```

---

## ⚠️ Edge Cases

```
TRUNCATION
- Long names: Truncate with ellipsis
- Long country names: Abbreviate (2-letter code)
- Long employer names: Truncate gracefully

EMPTY STATES
- No alerts: Show empty state message
- No data: Show loading skeleton
- Error: Show error with retry button

OVERFLOW
- Text: Uses maxLines and overflow properties
- Content: Uses SingleChildScrollView
- Cards: Fixed sizes to prevent overflow
```

---

## 🎬 Animation & Interactions

```
CURRENTLY IMPLEMENTED:
- Tap feedback on alert cards
- Icon tap feedback
- Navigation transitions
- Scroll animations (built-in)

FUTURE ENHANCEMENTS:
- Pull-to-refresh animation
- List item slide transitions
- Chart bar animations on load
- Page transition effects
- Skeleton loading animations
```

---

## 📦 Component Hierarchy

```
GovernmentDashboardScreen
├── DashboardHeader
│   ├── Logo Circle
│   ├── App Title
│   ├── Notification Icon
│   └── Menu Icon
├── SingleChildScrollView
│   └── Column
│       ├── DashboardTitleSection
│       │   ├── Main Title (24px)
│       │   └── Subtitle (14px)
│       ├── SystemOverviewCard
│       │   └── 4x StatItem
│       ├── AbuseReportsChart
│       │   └── BarChart
│       │       └── 6x BarColumn
│       └── RecentAlertsFeed
│           └── 5x AlertItemCard
│               ├── Avatar Circle
│               ├── Name & Country Text
│               ├── Status Badge
│               └── Chevron Icon
└── DashboardBottomNav
    └── 4x BottomNavItem
```

---

## 🔗 File Dependencies

```
government_dashboard_screen.dart
├── widgets/dashboard_header.dart
├── widgets/dashboard_title_section.dart
├── widgets/system_overview_card.dart
├── widgets/abuse_reports_chart.dart
├── widgets/recent_alerts_feed.dart
│   └── widgets/alert_item_card.dart
└── widgets/dashboard_bottom_nav.dart

providers/dashboard_providers.dart
└── models/dashboard_models.dart
```

---

## ✅ Quality Checklist

- [x] All colors from app palette
- [x] Proper typography scale
- [x] Consistent spacing (16dp base)
- [x] Rounded corners (16/12/8dp)
- [x] Proper shadows and elevation
- [x] Touch targets ≥ 48dp
- [x] Accessible color contrast
- [x] Safe area considered
- [x] Responsive layout
- [x] Mobile optimized

---

**Last Updated**: March 10, 2026
**Design System**: Material 3
**Platform**: Flutter (Mobile)
**Status**: Reference Complete ✅
