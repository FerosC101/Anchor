import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Color _bg = Color(0xFFF4F4F8);

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
  int _currentPage = 1;

  // Mock NGO data
  late List<NGOData> _ngoList = [
    NGOData(
      id: 'NGO-001',
      name: 'Green Earth Foundation',
      date: 'Jan 15, 2025',
      documents: ['Tax ID', 'Registration Certificate', 'Annual Report'],
      status: 'Approval Queue',
    ),
    NGOData(
      id: 'NGO-002',
      name: 'Global Health Initiative',
      date: 'Jan 10, 2025',
      documents: ['Tax ID', 'Registration Certificate', 'Annual Report'],
      status: 'Approval Queue',
    ),
    NGOData(
      id: 'NGO-003',
      name: 'Community Development Network',
      date: 'Jan 08, 2025',
      documents: ['Tax ID', 'Registration Certificate', 'Annual Report'],
      status: 'Approval Queue',
    ),
    NGOData(
      id: 'NGO-004',
      name: 'Education for All',
      date: 'Jan 05, 2025',
      documents: ['Tax ID', 'Registration Certificate', 'Annual Report'],
      status: 'Approval Queue',
    ),
    NGOData(
      id: 'NGO-005',
      name: 'Environmental Protection Society',
      date: 'Dec 28, 2024',
      documents: ['Tax ID', 'Registration Certificate', 'Annual Report'],
      status: 'Approval Queue',
    ),
  ];

  // Mock user data
  final List<UserData> _mockWorkers = [
    UserData(
      id: 'USR-008',
      name: 'Migrant Support Network',
      email: 'contact@msn.org',
      country: 'Middle East',
      registered: '2026-03-01',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-10',
      verified: false,
    ),
    UserData(
      id: 'USR-008',
      name: 'Migrant Support Network',
      email: 'contact@msn.org',
      country: 'Middle East',
      registered: '2026-03-01',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-10',
      verified: true,
    ),
    UserData(
      id: 'USR-008',
      name: 'Migrant Support Network',
      email: 'contact@msn.org',
      country: 'Middle East',
      registered: '2026-03-01',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-10',
      verified: false,
    ),
    UserData(
      id: 'USR-008',
      name: 'Migrant Support Network',
      email: 'contact@msn.org',
      country: 'Middle East',
      registered: '2026-03-01',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-10',
      verified: true,
    ),
    UserData(
      id: 'USR-008',
      name: 'Migrant Support Network',
      email: 'contact@msn.org',
      country: 'Middle East',
      registered: '2026-03-01',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-10',
      verified: false,
    ),
    UserData(
      id: 'USR-008',
      name: 'Migrant Support Network',
      email: 'contact@msn.org',
      country: 'Middle East',
      registered: '2026-03-01',
      status: 'Active',
      role: 'Worker',
      lastActive: '2026-03-10',
      verified: true,
    ),
  ];

  void _showUserProfileModal(UserData user) {
    showDialog(
      context: context,
      builder: (context) => _UserProfileModal(
        user: user,
        onVerify: () {
          setState(() {
            final index = _mockWorkers.indexOf(user);
            if (index != -1) {
              _mockWorkers[index] = UserData(
                id: user.id,
                name: user.name,
                email: user.email,
                country: user.country,
                registered: user.registered,
                status: user.status,
                role: user.role,
                lastActive: user.lastActive,
                verified: true,
              );
            }
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  List<NGOData> _getFilteredNGOs() {
    return _ngoList.where((ngo) {
      if (_selectedStatus == 'All Status') return true;
      return ngo.status == _selectedStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: _SearchBar(
                      onChanged: (value) {
                        // TODO: Filter users based on search query
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _TabSelector(
                      selectedTab: _selectedTab,
                      onTabChanged: (index) {
                        setState(() => _selectedTab = index);
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
                      'Users (1, 247)',
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
                            itemCount: _mockWorkers.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final user = _mockWorkers[index];
                              return _UserCard(
                                user: user,
                                onViewProfile: () =>
                                    _showUserProfileModal(user),
                                onVerify: () {
                                  setState(() {
                                    _mockWorkers[index] = UserData(
                                      id: user.id,
                                      name: user.name,
                                      email: user.email,
                                      country: user.country,
                                      registered: user.registered,
                                      status: user.status,
                                      role: user.role,
                                      lastActive: user.lastActive,
                                      verified: true,
                                    );
                                  });
                                },
                              );
                            },
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _getFilteredNGOs().length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final ngo = _getFilteredNGOs()[index];
                              return _NGOVerificationCard(
                                ngo: ngo,
                                onApprove: () {
                                  setState(() {
                                    final ngoIndex = _ngoList.indexWhere(
                                        (item) => item.id == ngo.id);
                                    if (ngoIndex != -1) {
                                      _ngoList[ngoIndex] = NGOData(
                                        id: ngo.id,
                                        name: ngo.name,
                                        date: ngo.date,
                                        documents: ngo.documents,
                                        status: 'Approved',
                                      );
                                    }
                                  });
                                },
                                onReject: () {
                                  setState(() {
                                    final ngoIndex = _ngoList.indexWhere(
                                        (item) => item.id == ngo.id);
                                    if (ngoIndex != -1) {
                                      _ngoList[ngoIndex] = NGOData(
                                        id: ngo.id,
                                        name: ngo.name,
                                        date: ngo.date,
                                        documents: ngo.documents,
                                        status: 'Rejected',
                                      );
                                    }
                                  });
                                },
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

// ─── Search Bar ────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search user by name',
          hintStyle: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF6B7280),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

// ─── Filter Bar ────────────────────────────────────────────────────────────────

class _FilterBar extends StatelessWidget {
  final String selectedCountry;
  final String selectedStatus;
  final int selectedTab;
  final Function(String) onCountryChanged;
  final Function(String) onStatusChanged;

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
              onTap: () {
                _showCountriesModal(context);
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _FilterButton(
              icon: Icons.info_outline,
              label: selectedStatus,
              onTap: () {
                _showStatusModal(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCountriesModal(BuildContext context) {
    List<String> countries = [
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
              .map((country) => _ModalOption(
                    label: country,
                    isSelected: selectedCountry == country,
                    onTap: () {
                      onCountryChanged(country);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showStatusModal(BuildContext context) {
    List<String> statuses = selectedTab == 0
        ? ['All Status', 'Verified', 'Unverified']
        : ['All Status', 'Approval Queue', 'Approved', 'Rejected'];

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
              .map((status) => _ModalOption(
                    label: status,
                    isSelected: selectedStatus == status,
                    onTap: () {
                      onStatusChanged(status);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}

// ─── Modal Option ────────────────────────────────────────────────────────────────

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

// ─── Filter Button ────────────────────────────────────────────────────────

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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: const Color(0xFF6B7280),
            ),
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

// ─── Tab Selector ──────────────────────────────────────────────────────────────

class _TabSelector extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;

  const _TabSelector({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TabButton(
            label: 'Workers',
            isSelected: selectedTab == 0,
            onTap: () => onTabChanged(0),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _TabButton(
            label: 'NGO',
            isSelected: selectedTab == 1,
            onTap: () => onTabChanged(1),
          ),
        ),
      ],
    );
  }
}

// ─── Tab Button ────────────────────────────────────────────────────────────────

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
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
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0052CC) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF0052CC)
                  : const Color(0xFFE5E7EB),
              width: 1,
            ),
            boxShadow: const [_subtleBoxShadow],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF374151),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── User Card ────────────────────────────────────────────────────────────────

class _UserCard extends StatelessWidget {
  final UserData user;
  final VoidCallback onViewProfile;
  final VoidCallback onVerify;

  const _UserCard({
    required this.user,
    required this.onViewProfile,
    required this.onVerify,
  });

  String _getInitials(String name) {
    return name.split(' ').map((e) => e[0]).take(2).join().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9D5FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _getInitials(user.name),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B46C1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4C1D95),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.id,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDEF7EC),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF065F46),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: user.verified
                            ? const Color(0xFFDEF7EC)
                            : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        user.verified ? 'Verified' : 'Unverified',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: user.verified
                              ? const Color(0xFF065F46)
                              : const Color(0xFF991B1B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Color(0xFF6B7280),
                ),
                const SizedBox(width: 4),
                Text(
                  'Country: ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  user.country,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Color(0xFF6B7280),
                ),
                const SizedBox(width: 4),
                Text(
                  'Registered: ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  user.registered,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (user.verified)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onViewProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF4C1D95),
                    side: const BorderSide(
                      color: Color(0xFF4C1D95),
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onViewProfile,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF4C1D95),
                        side: const BorderSide(
                          color: Color(0xFF4C1D95),
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onVerify,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B46C1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// ─── User Profile Modal ────────────────────────────────────────────────────────

class _UserProfileModal extends StatefulWidget {
  final UserData user;
  final VoidCallback onVerify;

  const _UserProfileModal({
    required this.user,
    required this.onVerify,
  });

  @override
  State<_UserProfileModal> createState() => _UserProfileModalState();
}

class _UserProfileModalState extends State<_UserProfileModal> {
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.user.id,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 24,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDEBEFE),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'WORKER',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B46C1),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDEF7EC),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF065F46),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'USER INFORMATION',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.person_outline,
                label: 'NAME',
                value: widget.user.name,
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.email_outlined,
                label: 'EMAIL',
                value: widget.user.email,
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.location_on_outlined,
                label: 'COUNTRY',
                value: widget.user.country,
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.calendar_today_outlined,
                label: 'REGISTERED',
                value: widget.user.registered,
              ),
              const SizedBox(height: 24),
              const Text(
                'ACCOUNT STATUS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              _InfoField(
                label: 'STATUS',
                value: widget.user.status,
              ),
              const SizedBox(height: 12),
              _InfoField(
                label: 'LAST ACTIVE',
                value: widget.user.lastActive,
              ),
              const SizedBox(height: 24),
              const Text(
                'ADMIN NOTES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _notesController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Add notes about this user...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement suspend user functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B3F5C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Suspend User',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF374151),
                    side: const BorderSide(
                      color: Color(0xFFD1D5DB),
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Info Field ────────────────────────────────────────────────────────────────

class _InfoField extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;

  const _InfoField({
    this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: const Color(0xFF6B7280),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6B7280),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
      ],
    );
  }
}

// ─── Pagination Bar ────────────────────────────────────────────────────────

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

// ─── NGO Verification Card ────────────────────────────────────────────────────

class _NGOVerificationCard extends StatelessWidget {
  final NGOData ngo;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _NGOVerificationCard({
    required this.ngo,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    ngo.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3B3FA6),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      ngo.date,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...ngo.documents.map((doc) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            doc,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color(0xFF9CA3AF),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            if (ngo.status == 'Approval Queue')
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onApprove,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B3FA6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
                    child: OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3B3FA6),
                        side: const BorderSide(
                          color: Color(0xFF3B3FA6),
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
              ),
          ],
        ),
      ),
    );
  }
}

// ─── User Data Model ──────────────────────────────────────────────────────

class NGOData {
  final String id;
  final String name;
  final String date;
  final List<String> documents;
  final String status;

  NGOData({
    required this.id,
    required this.name,
    required this.date,
    required this.documents,
    required this.status,
  });
}

// ─── User Data Model ──────────────────────────────────────────────────────

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
}
