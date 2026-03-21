import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/admin/admin_button.dart';
import '../../widgets/admin/admin_search_bar.dart';
import '../../widgets/admin/admin_tab_bar.dart';

const Color _bg = Color(0xFFF5F5F5);

const BoxShadow _subtleBoxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.04),
  blurRadius: 6,
  offset: Offset(0, 2),
);

class UserManagementScreen extends ConsumerStatefulWidget {
  const UserManagementScreen({super.key});

  @override
  ConsumerState<UserManagementScreen> createState() =>
      _UserManagementScreenState();
}

class _UserManagementScreenState extends ConsumerState<UserManagementScreen> {
  int _selectedTab = 0; // 0 = Workers, 1 = NGO
  String _selectedCountry = 'All Countries';
  String _selectedStatus = 'All Status';
  String _searchQuery = '';
  int _currentPage = 1;

  final List<UserData> _workers = [
    UserData(
      id: 'USR-101',
      name: 'Maria Santos',
      email: 'maria.santos@anchor.app',
      country: 'Saudi Arabia',
      registered: '2026-03-01',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-10',
      verified: false,
    ),
    UserData(
      id: 'USR-102',
      name: 'Ahmed Rahman',
      email: 'ahmed.rahman@anchor.app',
      country: 'UAE',
      registered: '2026-02-28',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-11',
      verified: true,
    ),
    UserData(
      id: 'USR-103',
      name: 'Jessa Lim',
      email: 'jessa.lim@anchor.app',
      country: 'Qatar',
      registered: '2026-02-27',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-08',
      verified: false,
    ),
    UserData(
      id: 'USR-104',
      name: 'Carlo Dela Cruz',
      email: 'carlo.dc@anchor.app',
      country: 'Kuwait',
      registered: '2026-02-25',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-10',
      verified: true,
    ),
    UserData(
      id: 'USR-105',
      name: 'Nina Velasco',
      email: 'nina.velasco@anchor.app',
      country: 'Bahrain',
      registered: '2026-02-21',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-09',
      verified: false,
    ),
    UserData(
      id: 'USR-106',
      name: 'Luis Mendoza',
      email: 'luis.mendoza@anchor.app',
      country: 'Saudi Arabia',
      registered: '2026-02-19',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-07',
      verified: true,
    ),
    UserData(
      id: 'USR-107',
      name: 'Joy Bacani',
      email: 'joy.bacani@anchor.app',
      country: 'UAE',
      registered: '2026-02-18',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-06',
      verified: false,
    ),
    UserData(
      id: 'USR-108',
      name: 'Ramon Ortega',
      email: 'ramon.ortega@anchor.app',
      country: 'Qatar',
      registered: '2026-02-16',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-05',
      verified: false,
    ),
    UserData(
      id: 'USR-109',
      name: 'Ana Gutierrez',
      email: 'ana.gutierrez@anchor.app',
      country: 'Kuwait',
      registered: '2026-02-14',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-04',
      verified: false,
    ),
  ];

  late final List<NGOData> _ngos = [
    NGOData(
      id: 'NGO-001',
      name: 'Green Earth Foundation',
      email: 'hello@greenearth.org',
      country: 'UAE',
      registered: '2026-03-11',
      lastActive: '2026-03-18',
      status: 'Approval Queue',
      verified: false,
    ),
    NGOData(
      id: 'NGO-002',
      name: 'Global Health Initiative',
      email: 'admin@ghi.org',
      country: 'Saudi Arabia',
      registered: '2026-03-10',
      lastActive: '2026-03-16',
      status: 'Approval Queue',
      verified: false,
    ),
    NGOData(
      id: 'NGO-003',
      name: 'Community Development Network',
      email: 'contact@cdn.org',
      country: 'Qatar',
      registered: '2026-03-08',
      lastActive: '2026-03-12',
      status: 'Approved',
      verified: true,
    ),
    NGOData(
      id: 'NGO-004',
      name: 'Education for All',
      email: 'team@educationforall.org',
      country: 'Kuwait',
      registered: '2026-03-06',
      lastActive: '2026-03-10',
      status: 'Rejected',
      verified: false,
    ),
    NGOData(
      id: 'NGO-005',
      name: 'Environmental Protection Society',
      email: 'support@eps.org',
      country: 'Bahrain',
      registered: '2026-03-04',
      lastActive: '2026-03-08',
      status: 'Approval Queue',
      verified: false,
    ),
    NGOData(
      id: 'NGO-006',
      name: 'Safe Passage Collective',
      email: 'ops@safepassage.org',
      country: 'UAE',
      registered: '2026-03-03',
      lastActive: '2026-03-14',
      status: 'Approved',
      verified: true,
    ),
    NGOData(
      id: 'NGO-007',
      name: 'Workers Legal Aid Group',
      email: 'care@wlag.org',
      country: 'Saudi Arabia',
      registered: '2026-03-02',
      lastActive: '2026-03-13',
      status: 'Approval Queue',
      verified: false,
    ),
    NGOData(
      id: 'NGO-008',
      name: 'Bridge to Home Initiative',
      email: 'contact@bridgehome.org',
      country: 'Qatar',
      registered: '2026-03-01',
      lastActive: '2026-03-09',
      status: 'Rejected',
      verified: false,
    ),
  ];

  List<UserData> get _filteredWorkers {
    final query = _searchQuery.trim().toLowerCase();
    return _workers.where((worker) {
      final matchesCountry = _selectedCountry == 'All Countries' ||
          worker.country == _selectedCountry;
      final matchesStatus = _selectedStatus == 'All Status' ||
          (_selectedStatus == 'Verified' && worker.verified) ||
          (_selectedStatus == 'Unverified' && !worker.verified);
      final matchesQuery = query.isEmpty ||
          worker.id.toLowerCase().contains(query) ||
          worker.name.toLowerCase().contains(query) ||
          worker.email.toLowerCase().contains(query);
      return matchesCountry && matchesStatus && matchesQuery;
    }).toList();
  }

  List<NGOData> get _filteredNgos {
    final query = _searchQuery.trim().toLowerCase();
    return _ngos.where((ngo) {
      final matchesCountry = _selectedCountry == 'All Countries' ||
          ngo.country == _selectedCountry;
      final matchesStatus =
          _selectedStatus == 'All Status' || ngo.status == _selectedStatus;
      final matchesQuery = query.isEmpty ||
          ngo.id.toLowerCase().contains(query) ||
          ngo.name.toLowerCase().contains(query) ||
          ngo.email.toLowerCase().contains(query);
      return matchesCountry && matchesStatus && matchesQuery;
    }).toList();
  }

  void _verifyWorker(UserData worker) {
    final index = _workers.indexWhere((u) => u.id == worker.id);
    if (index == -1) return;
    setState(() {
      _workers[index] = worker.copyWith(verified: true);
    });
  }

  void _approveNgo(NGOData ngo) {
    final index = _ngos.indexWhere((n) => n.id == ngo.id);
    if (index == -1) return;
    setState(() {
      _ngos[index] = ngo.copyWith(status: 'Approved', verified: true);
    });
  }

  void _rejectNgo(NGOData ngo) {
    final index = _ngos.indexWhere((n) => n.id == ngo.id);
    if (index == -1) return;
    setState(() {
      _ngos[index] = ngo.copyWith(status: 'Rejected', verified: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalVisible =
        _selectedTab == 0 ? _filteredWorkers.length : _filteredNgos.length;

    return Container(
      color: _bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'User Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _TabSelector(
                      selectedTab: _selectedTab,
                      onTabChanged: (index) {
                        setState(() {
                          _selectedTab = index;
                          _selectedStatus = 'All Status';
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _SearchBar(
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  _FilterBar(
                    selectedCountry: _selectedCountry,
                    selectedStatus: _selectedStatus,
                    selectedTab: _selectedTab,
                    onCountryChanged: (value) {
                      setState(() => _selectedCountry = value);
                    },
                    onStatusChanged: (value) {
                      setState(() => _selectedStatus = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Text(
                      'Users ($totalVisible)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _selectedTab == 0
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _filteredWorkers.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final user = _filteredWorkers[index];
                              return _WorkerCard(
                                user: user,
                                onVerify: () => _verifyWorker(user),
                              );
                            },
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _filteredNgos.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final ngo = _filteredNgos[index];
                              return _NgoCard(
                                ngo: ngo,
                                onApprove: () => _approveNgo(ngo),
                                onReject: () => _rejectNgo(ngo),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _PaginationBar(
                      currentPage: _currentPage,
                      totalPages: 8,
                      onPreviousPage: _currentPage > 1
                          ? () {
                              setState(() => _currentPage--);
                            }
                          : null,
                      onNextPage: _currentPage < 8
                          ? () {
                              setState(() => _currentPage++);
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AdminSearchBar(
      hintText: 'Search user by name or ID',
      onChanged: onChanged,
    );
  }
}

class _FilterBar extends StatelessWidget {
  final String selectedCountry;
  final String selectedStatus;
  final int selectedTab;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStatusChanged;

  const _FilterBar({
    required this.selectedCountry,
    required this.selectedStatus,
    required this.selectedTab,
    required this.onCountryChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _FilterButton(
              icon: Icons.location_on_outlined,
              label: selectedCountry,
              onTap: () => _showCountriesModal(context),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _FilterButton(
              icon: Icons.info_outline,
              label: selectedStatus,
              onTap: () => _showStatusModal(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showCountriesModal(BuildContext context) {
    const countries = [
      'All Countries',
      'Saudi Arabia',
      'UAE',
      'Qatar',
      'Kuwait',
      'Bahrain',
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: countries
              .map(
                (country) => _ModalOption(
                  label: country,
                  isSelected: selectedCountry == country,
                  onTap: () {
                    onCountryChanged(country);
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showStatusModal(BuildContext context) {
    final statuses = selectedTab == 0
        ? const ['All Status', 'Verified', 'Unverified']
        : const ['All Status', 'Approval Queue', 'Approved', 'Rejected'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: statuses
              .map(
                (status) => _ModalOption(
                  label: status,
                  isSelected: selectedStatus == status,
                  onTap: () {
                    onStatusChanged(status);
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _ModalOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModalOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF0052CC),
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FilterButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: const [_subtleBoxShadow],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF6B7280)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.expand_more,
              size: 16,
              color: Color(0xFF6B7280),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const _TabSelector({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: selectedTab,
      child: AdminTabBar(
        onTap: onTabChanged,
        tabs: const [
          Tab(text: 'Workers'),
          Tab(text: 'NGO'),
        ],
      ),
    );
  }
}

class _WorkerCard extends StatelessWidget {
  final UserData user;
  final VoidCallback onVerify;

  const _WorkerCard({
    required this.user,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeader(
              icon: Icons.person,
              title: user.name,
              subtitle: user.id,
              statusLabel: user.verified ? 'Verified' : 'Unverified',
              statusBg: user.verified
                  ? const Color(0xFFDEF7EC)
                  : const Color(0xFFFEE2E2),
              statusFg: user.verified
                  ? const Color(0xFF065F46)
                  : const Color(0xFF991B1B),
            ),
            const SizedBox(height: 12),
            _MetaLine(label: 'Country', value: user.country),
            const SizedBox(height: 6),
            _MetaLine(label: 'Registered', value: user.registered),
            const SizedBox(height: 6),
            Text(
              user.email,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12),
            if (!user.verified)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onVerify,
                  style: AdminButtonStyles.primary,
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: AdminButtonStyles.secondary,
                  child: const Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NgoCard extends StatelessWidget {
  final NGOData ngo;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _NgoCard({
    required this.ngo,
    required this.onApprove,
    required this.onReject,
  });

  Color get _statusBg {
    switch (ngo.status) {
      case 'Approved':
        return const Color(0xFFDEF7EC);
      case 'Rejected':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFFEF3C7);
    }
  }

  Color get _statusFg {
    switch (ngo.status) {
      case 'Approved':
        return const Color(0xFF065F46);
      case 'Rejected':
        return const Color(0xFF991B1B);
      default:
        return const Color(0xFF92400E);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeader(
              icon: Icons.business,
              title: ngo.name,
              subtitle: ngo.id,
              statusLabel: ngo.status,
              statusBg: _statusBg,
              statusFg: _statusFg,
            ),
            const SizedBox(height: 12),
            _MetaLine(label: 'Country', value: ngo.country),
            const SizedBox(height: 6),
            _MetaLine(label: 'Registered', value: ngo.registered),
            const SizedBox(height: 6),
            Text(
              ngo.email,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12),
            if (ngo.status == 'Approval Queue')
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onApprove,
                      style: AdminButtonStyles.primary,
                      child: const Text(
                        'Approve',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onReject,
                      style: AdminButtonStyles.secondary,
                      child: const Text(
                        'Reject',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: AdminButtonStyles.secondary,
                  child: const Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String statusLabel;
  final Color statusBg;
  final Color statusFg;

  const _CardHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.statusBg,
    required this.statusFg,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFDFEDFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(icon, size: 24, color: const Color(0xFF003696)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: statusFg,
            ),
          ),
        ),
      ],
    );
  }
}

class _MetaLine extends StatelessWidget {
  final String label;
  final String value;

  const _MetaLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
      ],
    );
  }
}

class _PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onNextPage;

  const _PaginationBar({
    required this.currentPage,
    required this.totalPages,
    required this.onPreviousPage,
    required this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPreviousPage,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                '< Previous',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: onPreviousPage != null
                      ? const Color(0xFF6B46C1)
                      : const Color(0xFFD1D5DB),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'Page $currentPage of $totalPages',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(width: 16),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onNextPage,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                'Next >',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: onNextPage != null
                      ? const Color(0xFF6B46C1)
                      : const Color(0xFFD1D5DB),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const BoxDecoration _cardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(12)),
  boxShadow: [_subtleBoxShadow],
);

class NGOData {
  final String id;
  final String name;
  final String email;
  final String country;
  final String registered;
  final String lastActive;
  final String status;
  final bool verified;

  NGOData({
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    required this.registered,
    required this.lastActive,
    required this.status,
    required this.verified,
  });

  NGOData copyWith({
    String? status,
    bool? verified,
  }) {
    return NGOData(
      id: id,
      name: name,
      email: email,
      country: country,
      registered: registered,
      lastActive: lastActive,
      status: status ?? this.status,
      verified: verified ?? this.verified,
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;
  final String country;
  final String registered;
  final String status;
  final String role;
  final String lastActive;
  final bool verified;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    required this.registered,
    required this.status,
    required this.role,
    required this.lastActive,
    required this.verified,
  });

  UserData copyWith({
    bool? verified,
  }) {
    return UserData(
      id: id,
      name: name,
      email: email,
      country: country,
      registered: registered,
      status: status,
      role: role,
      lastActive: lastActive,
      verified: verified ?? this.verified,
    );
  }
}
