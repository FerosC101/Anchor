# Government Dashboard - Mobile UI Implementation

This is the 1:1 scale mobile Flutter implementation of the Government Dashboard homepage based on the design specification.

## Overview

The Government Dashboard provides government agencies with a comprehensive overview of flagged cases and active alerts within their jurisdiction. The interface displays key metrics, abuse reports data visualization, and recent alerts in a clean, accessible mobile format.

## Features

### 1. **Header Section**
- Logo and branding
- Notification and menu icons
- Consistent navigation experience

### 2. **Dashboard Title**
- Main heading: "Government Dashboard"
- Descriptive subtitle about the functionality

### 3. **System Overview Card**
- Gradient background (Navy blue)
- 4 key metrics displayed:
  - **47** Abuse Reports
  - **8** Support Requests
  - **23** High-Risk Employers
  - **12** Contract Issues
- Clean, readable typography with proper spacing

### 4. **Abuse Reports Summary Chart**
- Bar chart visualization showing reports by country
- Countries included:
  - Saudi Arabia (95 reports)
  - UAE (75 reports)
  - Kuwait (60 reports)
  - Qatar (45 reports)
  - Oman (35 reports)
  - Bahrain (25 reports)
- Responsive chart sizing
- Color-coded bars using app primary color

### 5. **Recent Alerts Feed**
- Displays 5 of 67 alerts
- "View all" link for navigation
- Each alert card contains:
  - Worker avatar/icon
  - Worker name
  - Country
  - Employer name
  - Date (2026-03-05 format)
  - Risk level (High/Medium/Low)
  - Status badge (In review)
  - Chevron for navigation
- Card-based layout with subtle borders
- Tap-able cards for detailed view

### 6. **Bottom Navigation**
- 4 tabs: Home, Monitoring, Assistance, Profile
- Active/inactive icon states
- Selected state highlighting with primary color

## Project Structure

```
features/government_dashboard/
├── models/
│   └── dashboard_models.dart          # Data models
├── screens/
│   └── government_dashboard_screen.dart # Main screen
├── widgets/
│   ├── dashboard_header.dart          # Header widget
│   ├── dashboard_title_section.dart   # Title section
│   ├── system_overview_card.dart      # Stats card
│   ├── abuse_reports_chart.dart       # Chart widget
│   ├── alert_item_card.dart           # Alert card
│   ├── recent_alerts_feed.dart        # Alerts list
│   ├── dashboard_bottom_nav.dart      # Bottom navigation
│   └── index.dart                     # Widget exports
├── index.dart                         # Feature exports
└── README.md                          # This file
```

## Components

### GovernmentDashboardScreen
Main stateful widget that orchestrates the dashboard layout and navigation.

**State Management:**
- `_selectedTab`: Tracks current bottom navigation tab

### DashboardHeader
Displays the app logo, branding, and top action icons.

**Parameters:**
- `onNotificationTapped`: Callback for notification icon tap
- `onMenuTapped`: Callback for menu icon tap

### DashboardTitleSection
Shows the main heading and subtitle.

### SystemOverviewCard
Displays 4 key metrics in a gradient card.

### AbuseReportsChart
Bar chart visualization of abuse reports by country.

### AlertItemCard
Individual alert card with worker information and status.

**Parameters:**
- `workerName`: Name of the worker
- `country`: Worker's country
- `employerName`: Employer name
- `date`: Alert date
- `riskLevel`: Risk level (High/Medium/Low)
- `onTapped`: Callback for card tap

### RecentAlertsFeed
List container for multiple alert items.

**Parameters:**
- `onViewAllTapped`: Callback for "View all" link

### DashboardBottomNav
Bottom navigation bar with 4 tabs.

**Parameters:**
- `selectedIndex`: Currently selected tab index
- `onTap`: Callback for tab selection

## Color Scheme

The dashboard uses the app's established color palette:

- **Primary**: `#0A2463` (Deep Navy)
- **Background**: `#F8FAFC` (Light Gray)
- **Surface**: `#FFFFFF` (White)
- **Text Primary**: `#0F172A` (Dark Navy)
- **Text Secondary**: `#64748B` (Slate Gray)
- **Border**: `#E2E8F0` (Light Border)
- **Info**: `#3B82F6` (Blue)
- **Error**: `#EF4444` (Red)

See `core/theme/app_colors.dart` for complete color definitions.

## Typography

- **Headings (24px)**: Bold, primary color
- **Section Titles (16px)**: Semi-bold, primary color
- **Body Text (14px)**: Regular weight, secondary color
- **Small Labels (12px)**: Regular weight, secondary color

## Spacing

- **Horizontal padding**: 16dp
- **Vertical spacing between sections**: 24-32dp
- **Card padding**: 16dp
- **Item spacing**: 12dp

## Responsive Design

The layout is designed for mobile-first approach:
- Safe area consideration for notches and system UI
- Scrollable content area
- Fixed header and bottom navigation
- Flexible spacing that adapts to content

## Integration Points

### Navigation
To integrate with the app's routing system, add to `core/router/app_router.dart`:

```dart
GoRoute(
  path: 'government-dashboard',
  builder: (context, state) => const GovernmentDashboardScreen(),
),
```

### Data Binding
The dashboard currently uses static data. To connect to real data:

1. Create a Riverpod provider for dashboard data
2. Replace static values with `ref.watch()` calls
3. Update alert list generation to use API data

Example:
```dart
final dashboardProvider = FutureProvider<DashboardData>((ref) async {
  // Fetch data from API
});
```

## State Management

Currently uses local state (`_selectedTab`). For production:
- Consider using Riverpod for tab management
- Implement data fetching with async providers
- Handle loading and error states

## Future Enhancements

1. **Real-time Updates**: Add WebSocket or Firebase real-time listeners
2. **Filtering**: Add filters for country, date range, risk level
3. **Sorting**: Add sort options for alert lists
4. **Pull to Refresh**: Implement refresh functionality
5. **Search**: Add search capability for alerts
6. **Export**: Add ability to export alert data
7. **Alerts Detail**: Implement detailed alert view
8. **Analytics**: Add chart interactions and drill-down

## Usage Example

```dart
import 'package:anchor/features/government_dashboard/index.dart';

// In your app routing
GovernmentDashboardScreen(),

// Access individual widgets
SystemOverviewCard(),
AbuseReportsChart(),
RecentAlertsFeed(
  onViewAllTapped: () => print('View all alerts'),
),
```

## Testing

To test this screen, ensure your Flutter environment is set up:

```bash
flutter pub get
flutter run
```

Navigate to the Government Dashboard screen through your app's routing.

## Notes

- All dimensions are pixel-perfect to the design specification
- Colors use Material 3 color system
- Icons use Material Icons
- Responsive spacing scales with content
- Accessibility considerations: sufficient color contrast, touch targets > 48dp

---

**Status**: Ready for integration with backend data and state management
**Last Updated**: March 10, 2026
**Developer**: Frontend Team
