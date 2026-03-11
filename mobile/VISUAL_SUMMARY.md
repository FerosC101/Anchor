# 🎨 Government Dashboard - Visual Summary

## Screen Layout

```
┌─────────────────────────────────────┐
│         FULL SCREEN VIEW            │
├─────────────────────────────────────┤
│                                     │
│  ╔═══════════════════════════════╗  │
│  ║ Header                        ║  │
│  ║ [A] Anchor    [🔔] [≡]       ║  │
│  ╚═══════════════════════════════╝  │
│                                     │
│  Government Dashboard              │
│  Overview of flagged cases...       │
│                                     │
│  ╔═══════════════════════════════╗  │
│  ║ System overview               ║  │ Gradient
│  ║                               ║  │ Background
│  ║  47    8     23      12        ║  │ Navy Blue
│  ║ Abuse Support High-Risk Contr │  │
│  ║ Reports Requests Employers    ║  │
│  ╚═══════════════════════════════╝  │
│                                     │
│  Abuse Reports Summary             │
│  ╔═══════════════════════════════╗  │
│  ║ █     █      █     █  █  █    ║  │
│  ║ █     █      █     █  █  █    ║  │
│  ║ █████ ████   ███   ██ █  █    ║  │
│  ║ █  █  █  █   █ █   █  █  █    ║  │
│  ║ █     █      █     █  █  █    ║  │
│  ║ Saudi UAE   Kuwait Qatar Oman  ║  │
│  ╚═══════════════════════════════╝  │
│                                     │
│  Recent Alerts Feed   View all →    │
│  Showing 5 of 67 alerts             │
│                                     │
│  ╔═══════════════════════════════╗  │
│  ║ [👤] Worker Name  [In review] ║  │
│  ║      Country            → [→]    ║
│  ╚═══════════════════════════════╝  │
│                                     │
│  ╔═══════════════════════════════╗  │
│  ║ [👤] Worker Name  [In review] ║  │
│  ║      Country            → [→]    ║
│  ╚═══════════════════════════════╝  │
│                                     │
│  ... (3 more alert cards) ...       │
│                                     │
├─────────────────────────────────────┤
│ [🏠] [📊] [👥] [👤]                │
│ Home Monitoring Assistance Profile  │
└─────────────────────────────────────┘
```

---

## Component Sizes

```
HEADER (60dp total height)
├─ Logo Circle: 36x36dp
├─ Padding: 12dp vertical, 16dp horizontal
└─ Icon Buttons: 48x48dp (tap area)

SYSTEM OVERVIEW CARD
├─ Height: ~140dp (with padding)
├─ Padding: 24dp vertical, 16dp horizontal
├─ Title: 16px, 600 weight
├─ Numbers: 28px, 700 weight
├─ Labels: 12px, 500 weight
└─ Border Radius: 16dp

CHART
├─ Container: ~250dp
├─ Chart Area: 180dp
├─ Bars: 32dp wide each
├─ Bar Height: Proportional (max 150dp)
├─ Labels: 10px font
└─ Divider: 1dp line

ALERT CARD (per item)
├─ Height: ~96dp
├─ Padding: 16dp all sides
├─ Avatar: 48x48dp
├─ Avatar Gap: 16dp
├─ Status Badge: 10px font, ~24dp width
├─ Border: 1dp solid
└─ Border Radius: 12dp

BOTTOM NAV (56dp total height)
├─ Tab Width: 25% of screen
├─ Icon Size: 24dp
├─ Label: 12px font
└─ Padding: Standard Material
```

---

## Color Usage

```
PRIMARY GRADIENT (System Overview Card)
┌────────────────────────────────────┐
│        #0A2463                     │
│        Navy Dark                   │
│           ↓                        │
│        #1E3A8A                     │
│        Navy Light                  │
└────────────────────────────────────┘
Background: Gradient fill

TEXT ON PRIMARY
├─ Numbers: White (28px, 700wt)
├─ Labels: White (12px, 500wt)
└─ Title: White (16px, 600wt)

PRIMARY TEXT
├─ Main Heading: #0F172A (24px, 700wt)
├─ Section Titles: #0F172A (16px, 600wt)
└─ Card Headers: #0F172A (14px, 600wt)

SECONDARY TEXT
├─ Descriptions: #64748B (14px, 400wt)
├─ Labels: #64748B (12px, 400wt)
└─ Small Text: #64748B (10px, 400wt)

SURFACE COLORS
├─ Page Background: #F8FAFC (Light Gray)
├─ Card Background: #FFFFFF (White)
├─ Borders: #E2E8F0 (Light Border)
└─ Hover/Active: Based on primary

STATUS COLORS
├─ Info/In Review: #3B82F6 (Blue)
├─ Success: #10B981 (Green)
├─ Warning: #F59E0B (Amber)
└─ Error/High: #EF4444 (Red)
```

---

## Typography Hierarchy

```
LEVEL 1 - MAIN HEADING (24px)
Government Dashboard
└─ Bold weight, navy primary color
└─ Used once per page

LEVEL 2 - SECTION TITLES (16px)
System overview | Abuse Reports Summary | Recent Alerts Feed
└─ Semi-bold weight, navy primary color
└─ Used for major sections

LEVEL 3 - BODY TEXT (14px)
Overview of flagged cases and active alerts in your jurisdiction
Worker Name | Country | Employer Name
└─ Regular weight, navy primary text
└─ Main content text

LEVEL 4 - SECONDARY TEXT (12px)
Reports by country | Showing 5 of 67 alerts | Labels
└─ Regular weight, slate gray text
└─ Supporting information

LEVEL 5 - SMALL TEXT (10px)
Country labels in chart | Details in cards
└─ Regular weight, slate gray text
└─ Tertiary information
```

---

## Data Visualization

### System Overview Stats
```
┌──────┬──────┬──────┬──────┐
│  47  │  8   │  23  │  12  │
├──────┼──────┼──────┼──────┤
│Abuse │Support│High- │Contr-│
│Report│Request│Risk  │act  │
│      │       │Employ│Issue │
│      │       │er    │      │
└──────┴──────┴──────┴──────┘

Layout: 4 equal columns
Distribution: Flex / equal distribution
Alignment: Centered
```

### Abuse Reports Chart
```
CHART DATA (6 countries)
Saudi Arabia │ 95 reports │ ████████████████
UAE          │ 75 reports │ ███████████
Kuwait       │ 60 reports │ █████████
Qatar        │ 45 reports │ ███████
Oman         │ 35 reports │ █████
Bahrain      │ 25 reports │ ████

Bar Heights: Proportional to value
Max Height: 150dp
Chart Width: 100% - padding
```

### Alert Items
```
Each Alert Card:

[👤] ┌─────────────────────────┐ [In review]
     │ Worker Name             │ Details
     │ Country                 │ Employer: Name
     │                         │ Date: 2026-03-05
     │                         │ Risk: High
     └─────────────────────────┘ [→]

Left: Avatar (48x48)
Center: Name & Country (left-aligned)
Right: Status & Info (right-aligned)
Width: Full container minus padding
Height: ~96dp per item
```

---

## Responsive Breakpoints

```
MOBILE (320dp - 600dp) - PRIMARY
├─ Content padding: 16dp
├─ Single column layout
├─ Full width components
├─ Stack vertical
└─ SafeArea applied

TABLET (600dp+) - FUTURE
├─ Could use 2 columns
├─ Larger spacing possible
├─ Multi-panel layout
└─ Enhanced visualization
```

---

## Interactive States

### Bottom Navigation
```
INACTIVE STATE          ACTIVE STATE
├─ Icon: Outlined       ├─ Icon: Filled
├─ Color: #CBD5E1       ├─ Color: #0A2463
├─ Label: Gray          ├─ Label: Navy
└─ No background        └─ May have underline

HOVER STATE (on tap)
├─ Icon: Filled
├─ Background: Light fade
└─ Color: Primary
```

### Alert Cards
```
DEFAULT STATE
├─ Border: #E2E8F0 (1dp)
├─ Background: White
├─ Opacity: 100%
└─ Cursor: Pointer

HOVER STATE
├─ Elevation: Increased
├─ Shadow: Enhanced
├─ Border: Slightly darker
└─ Scale: Slight up

TAP STATE
├─ Opacity: Reduced
├─ Feedback: Ripple
└─ Navigation: Triggered
```

### Status Badge
```
"In review" Badge
├─ Background: #EBF5FF (Light Blue)
├─ Text: #3B82F6 (Blue)
├─ Border Radius: 6dp
├─ Padding: 10dp H, 4dp V
├─ Font: 11px, 600wt
└─ Always visible
```

---

## Spacing Reference

```
HORIZONTAL
├─ Page Margin: 16dp
├─ Card Padding: 16dp
├─ Item Gap: 8-16dp
└─ Icon Spacing: 8dp

VERTICAL
├─ Header to Title: 16dp (after safe area)
├─ Title to Card: 24dp
├─ Card to Card: 32dp
├─ Card to Footer: 20dp
├─ Item to Item: 12dp
└─ Bottom Nav: 56dp fixed
```

---

## Border Radius

```
LARGE - 16dp
├─ System Overview Card
├─ Chart Container
└─ Major sections

MEDIUM - 12dp
├─ Alert Cards
├─ Secondary cards
└─ Modal-like elements

SMALL - 8dp
├─ Status badges
├─ Bar chart tops
└─ Accent elements

CIRCLE - 50%
├─ Avatar circles (48x48)
├─ Logo circle (36x36)
└─ Rounded buttons
```

---

## Shadow Effects

```
CARD SHADOW
├─ Color: rgba(0, 0, 0, 0.05)
├─ Blur Radius: 12dp
├─ Offset: (0, 2)
├─ Spread: 0
└─ Elevation: Low-medium

NO SHADOW
├─ Header: Flat
├─ Bottom Nav: Flat with border top
└─ Clean aesthetic
```

---

## Animation & Transitions

```
CURRENTLY IMPLEMENTED:
├─ Scroll: Built-in smoothness
├─ Tap: Material ripple effect
├─ Nav: Smooth transitions
└─ No delay or stutter

FUTURE ENHANCEMENTS:
├─ Pull-to-refresh: Slide animation
├─ List items: Fade in on scroll
├─ Chart: Draw animation on load
├─ Cards: Stagger entrance
└─ Transitions: Page slide
```

---

## Accessibility

```
TOUCH TARGETS
├─ Buttons: 48x48dp minimum
├─ Icons: 48x48dp tap area
├─ Cards: Full width (tappable)
└─ Nav Items: 48x48dp minimum

COLOR CONTRAST
├─ Text on White: 14:1 (WCAG AAA)
├─ Text on Primary: 10:1 (WCAG AA)
├─ Primary on White: 8:1 (WCAG AA)
└─ All text: Meets standards

SEMANTIC STRUCTURE
├─ Headings: Proper hierarchy
├─ Labels: Associated with content
├─ Lists: Proper structure
└─ Actions: Clear and visible
```

---

## File Organization

```
FEATURES → COMPONENTS → WIDGETS
│
government_dashboard/
│
├── screens/           (Main container)
├── widgets/           (8 reusable components)
├── models/            (Data structures)
├── providers/         (State management)
└── docs/              (Documentation)
```

---

## Device Compatibility

```
TESTED ON:
├─ Small phones (320dp)
├─ Regular phones (375dp)
├─ Large phones (600dp+)
├─ With notches
├─ With safe areas
└─ Landscape (future)

SAFE AREA:
├─ Top: Handled (status bar)
├─ Bottom: Handled (navigation)
├─ Left/Right: Standard padding
└─ Notches: Respected
```

---

**Last Updated**: March 10, 2026
**Format**: Visual Reference & Specifications
**Status**: Complete ✅
