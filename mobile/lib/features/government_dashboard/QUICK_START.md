# 🚀 Government Dashboard - Quick Start Guide

## Getting Started in 5 Minutes

### Step 1: Add to Your Router
Open `lib/core/router/app_router.dart` and add:

```dart
GoRoute(
  path: 'government-dashboard',
  builder: (context, state) => const GovernmentDashboardScreen(),
),
```

### Step 2: Import the Screen
```dart
import 'package:anchor/features/government_dashboard/screens/government_dashboard_screen.dart';

// Or use the barrel export
import 'package:anchor/features/government_dashboard/index.dart';
```

### Step 3: Navigate to Dashboard
```dart
// In your navigation code
context.go('/government-dashboard');

// Or with GoRouter
GoRouter.of(context).go('/government-dashboard');
```

### Step 4: Run Your App
```bash
flutter pub get
flutter run
```

---

## 📦 What You Have

| Component | File | Purpose |
|-----------|------|---------|
| Main Screen | `government_dashboard_screen.dart` | Dashboard container |
| Header | `dashboard_header.dart` | Top navigation bar |
| Title | `dashboard_title_section.dart` | Dashboard heading |
| Stats Card | `system_overview_card.dart` | 4 key metrics |
| Chart | `abuse_reports_chart.dart` | Bar chart visualization |
| Alert Card | `alert_item_card.dart` | Single alert item |
| Alerts List | `recent_alerts_feed.dart` | Alerts container |
| Bottom Nav | `dashboard_bottom_nav.dart` | Navigation bar |
| Models | `dashboard_models.dart` | Data structures |
| Providers | `dashboard_providers.dart` | Riverpod state |

---

## 🎨 Key Features

✅ **1:1 Scale Design** - Perfectly matches the design specification
✅ **Mobile Optimized** - Responsive and touch-friendly
✅ **Component-Based** - Reusable, modular widgets
✅ **State-Ready** - Riverpod providers included
✅ **Well-Documented** - Comments and documentation
✅ **Production-Ready** - Follows Flutter best practices

---

## 🔄 Connecting Real Data

### Option 1: Using Riverpod Providers (Recommended)

Update `dashboard_providers.dart`:

```dart
// Replace static provider with async provider
final systemOverviewStatsProvider = 
  FutureProvider<SystemOverviewStats>((ref) async {
    final response = await ref.watch(apiClientProvider)
      .getSystemStats();
    return SystemOverviewStats.fromJson(response);
  });
```

### Option 2: Direct Firebase Access

```dart
final recentAlertsFeedProvider = 
  StreamProvider<List<DashboardAlert>>((ref) {
    return FirebaseFirestore.instance
      .collection('alerts')
      .snapshots()
      .map((snapshot) => snapshot.docs
        .map((doc) => DashboardAlert.fromFirestore(doc))
        .toList());
  });
```

---

## 📱 Component Usage Examples

### Use Individual Components

```dart
import 'package:anchor/features/government_dashboard/widgets/index.dart';

// Header
DashboardHeader(
  onNotificationTapped: () => print('Notifications'),
  onMenuTapped: () => print('Menu'),
)

// Stats Card
SystemOverviewCard()

// Chart
AbuseReportsChart()

// Alert Item
AlertItemCard(
  workerName: 'John Doe',
  country: 'Saudi Arabia',
  employerName: 'Company X',
  date: '2026-03-05',
  riskLevel: 'High',
  onTapped: () => print('Alert tapped'),
)

// Alerts Feed
RecentAlertsFeed(
  onViewAllTapped: () => context.go('/alerts'),
)

// Bottom Navigation
DashboardBottomNav(
  selectedIndex: 0,
  onTap: (index) => print('Tab: $index'),
)
```

---

## 🎨 Customization

### Change Colors
Edit `lib/core/theme/app_colors.dart`:
```dart
static const Color primary = Color(0xFF0A2463); // Change this
```

### Update Chart Data
Modify `abuse_reports_chart.dart`:
```dart
final List<Map<String, dynamic>> chartData = [
  {'label': 'Country', 'value': 100, 'maxValue': 100},
  // Add more...
];
```

### Add More Stats
Update `system_overview_card.dart` to add more stat items.

---

## 🔌 API Integration Template

```dart
// Create an API service
class GovernmentDashboardService {
  Future<SystemOverviewStats> getSystemStats() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/dashboard/stats'),
      headers: {'Authorization': 'Bearer $token'},
    );
    
    if (response.statusCode == 200) {
      return SystemOverviewStats.fromJson(
        jsonDecode(response.body)
      );
    }
    throw Exception('Failed to load stats');
  }

  Stream<List<DashboardAlert>> getRecentAlerts() {
    // Return stream from Firebase or WebSocket
  }
}

// Use in provider
final dashboardServiceProvider = Provider((ref) {
  return GovernmentDashboardService();
});
```

---

## 📊 Current Data (Static)

The dashboard comes with sample data:
- **Abuse Reports**: 47
- **Support Requests**: 8
- **High-Risk Employers**: 23
- **Contract Issues**: 12

**Chart Countries** (by report count):
1. Saudi Arabia: 95
2. UAE: 75
3. Kuwait: 60
4. Qatar: 45
5. Oman: 35
6. Bahrain: 25

**Alerts**: 5 sample alerts (from 67 total)

---

## ✅ Testing Checklist

- [ ] Screen renders without errors
- [ ] Bottom navigation tabs work
- [ ] Alert cards are tap-able
- [ ] View all link is clickable
- [ ] Menu and notification icons respond
- [ ] Layout adapts to different screen sizes
- [ ] Scrolling works smoothly
- [ ] No visual glitches or text overflow

---

## 🐛 Troubleshooting

### Screen not showing?
✓ Check router configuration
✓ Verify import path
✓ Run `flutter pub get`

### Layout looks wrong?
✓ Check device orientation (portrait only)
✓ Verify theme is loaded
✓ Check `app_colors.dart` is accessible

### Colors not showing?
✓ Verify `AppColors` import
✓ Check `app_colors.dart` exists
✓ Rebuild app with `flutter clean && flutter pub get`

---

## 📚 Related Files

- **Router**: `lib/core/router/app_router.dart`
- **Theme**: `lib/core/theme/app_theme.dart`
- **Colors**: `lib/core/theme/app_colors.dart`
- **Main**: `lib/main.dart`

---

## 💡 Tips

1. **Use DevTools** to inspect widget tree
2. **Check console** for performance warnings
3. **Test on multiple devices** for responsive validation
4. **Use hot reload** while developing
5. **Keep components stateless** for better performance

---

## 📞 Support

For issues or questions:
1. Check the feature `README.md`
2. Review component comments
3. Check Flutter documentation
4. Review example code in screens

---

## ✨ Next: Backend Integration

Once you're ready to connect real data:

1. Set up API/Firebase calls
2. Update providers with real data fetching
3. Add loading/error states
4. Implement real-time updates
5. Add offline support (if needed)

See `GOVERNMENT_DASHBOARD_SUMMARY.md` for detailed integration guide.

---

**Created**: March 10, 2026
**Status**: Ready to Use! 🎉
