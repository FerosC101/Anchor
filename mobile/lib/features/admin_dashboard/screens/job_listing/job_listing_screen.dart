import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Color _bg = Color(0xFFF4F4F8);

const BoxShadow _subtleBoxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.04),
  blurRadius: 6,
  offset: Offset(0, 2),
);

class JobListingScreen extends ConsumerStatefulWidget {
  const JobListingScreen({super.key});

  @override
  ConsumerState<JobListingScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends ConsumerState<JobListingScreen> {
  String _selectedCountry = 'Country';
  String _selectedStatus = 'Status';
  String _selectedDate = 'All Date';
  int _currentPage = 1;

  late List<JobData> _jobsList = [
    JobData(
      id: 'JOB-001',
      position: 'Factory Worker',
      employer: 'Quick Hire Agency',
      country: 'Malaysia',
      salary: '\$200/month',
      submittedDate: '2026-03-09',
      status: 'Pending',
      riskLevel: 'MEDIUM',
      complaints: 0,
    ),
    JobData(
      id: 'JOB-002',
      position: 'Construction Worker',
      employer: 'Build Strong Construction',
      country: 'UAE',
      salary: '\$250/month',
      submittedDate: '2026-03-08',
      status: 'Pending',
      riskLevel: 'HIGH',
      complaints: 2,
    ),
    JobData(
      id: 'JOB-003',
      position: 'Hotel Staff',
      employer: 'Dubai Hospitality Group',
      country: 'UAE',
      salary: '\$300/month',
      submittedDate: '2026-03-07',
      status: 'Pending',
      riskLevel: 'LOW',
      complaints: 0,
    ),
    JobData(
      id: 'JOB-004',
      position: 'Domestic Helper',
      employer: 'Elite Placements',
      country: 'Singapore',
      salary: '\$350/month',
      submittedDate: '2026-03-06',
      status: 'Pending',
      riskLevel: 'HIGH',
      complaints: 5,
    ),
    JobData(
      id: 'JOB-005',
      position: 'Farm Worker',
      employer: 'Agricultural Solutions',
      country: 'Thailand',
      salary: '\$180/month',
      submittedDate: '2026-03-05',
      status: 'Pending',
      riskLevel: 'MEDIUM',
      complaints: 1,
    ),
    JobData(
      id: 'JOB-001',
      position: 'Factory Worker',
      employer: 'Quick Hire Agency',
      country: 'Malaysia',
      salary: '\$200/month',
      submittedDate: '2026-02-15',
      status: 'Approved',
      riskLevel: 'LOW',
      complaints: 0,
    ),
    JobData(
      id: 'JOB-006',
      position: 'Nurse',
      employer: 'City Medical Center',
      country: 'Singapore',
      salary: '\$500/month',
      submittedDate: '2026-02-10',
      status: 'Approved',
      riskLevel: 'LOW',
      complaints: 0,
    ),
    JobData(
      id: 'JOB-007',
      position: 'IT Support Specialist',
      employer: 'Tech Solutions Ltd',
      country: 'Malaysia',
      salary: '\$400/month',
      submittedDate: '2026-02-08',
      status: 'Approved',
      riskLevel: 'LOW',
      complaints: 0,
    ),
  ];

  List<JobData> get _filteredJobsList {
    return _jobsList.where((job) {
      final matchesStatus = _selectedStatus == 'Status' ||
          _selectedStatus == 'All Status' ||
          job.status == _selectedStatus;
      final matchesCountry =
          _selectedCountry == 'Country' || job.country == _selectedCountry;
      return matchesStatus && matchesCountry;
    }).toList();
  }

  void _showJobReviewModal(JobData job) {
    showDialog(
      context: context,
      builder: (context) => _JobReviewModal(
        job: job,
        onApprove: () {
          setState(() {
            final index = _jobsList.indexWhere((item) => item.id == job.id);
            if (index != -1) {
              _jobsList[index] = JobData(
                id: job.id,
                position: job.position,
                employer: job.employer,
                country: job.country,
                salary: job.salary,
                submittedDate: job.submittedDate,
                status: 'Approved',
                riskLevel: job.riskLevel,
                complaints: job.complaints,
              );
            }
          });
          Navigator.pop(context);
        },
      ),
    );
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
              'Job Listings',
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
                        // TODO: Filter jobs based on search query
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _FilterBar(
                    selectedCountry: _selectedCountry,
                    selectedStatus: _selectedStatus,
                    selectedDate: _selectedDate,
                    onCountryChanged: (value) {
                      setState(() => _selectedCountry = value);
                    },
                    onStatusChanged: (value) {
                      setState(() => _selectedStatus = value);
                    },
                    onDateChanged: (value) {
                      setState(() => _selectedDate = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Text(
                      'Job Listings (${_filteredJobsList.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _filteredJobsList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final job = _filteredJobsList[index];
                        return job.status == 'Pending'
                            ? _PendingJobCard(
                                job: job,
                                onReview: () => _showJobReviewModal(job),
                                onRemove: () {
                                  setState(() {
                                    _jobsList.removeWhere(
                                        (item) => item.id == job.id);
                                  });
                                },
                              )
                            : _ApprovedJobCard(
                                job: job,
                                onReview: () => _showJobReviewModal(job),
                              );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _PaginationBar(
                      currentPage: _currentPage,
                      totalPages: 3,
                      onPreviousPage: _currentPage > 1
                          ? () {
                              setState(() => _currentPage--);
                            }
                          : null,
                      onNextPage: _currentPage < 3
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
          hintText: 'Search content',
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
  final String selectedDate;
  final Function(String) onCountryChanged;
  final Function(String) onStatusChanged;
  final Function(String) onDateChanged;

  const _FilterBar({
    required this.selectedCountry,
    required this.selectedStatus,
    required this.selectedDate,
    required this.onCountryChanged,
    required this.onStatusChanged,
    required this.onDateChanged,
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
              onTap: () => _showCountryModal(context),
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
          const SizedBox(width: 8),
          Expanded(
            child: _FilterButton(
              icon: Icons.calendar_today_outlined,
              label: selectedDate,
              onTap: () => _showDateModal(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showCountryModal(BuildContext context) {
    List<String> countries = [
      'Country',
      'Malaysia',
      'UAE',
      'Singapore',
      'Thailand',
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
    List<String> statuses = ['Status', 'All Status', 'Pending', 'Approved'];

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

  void _showDateModal(BuildContext context) {
    List<String> dates = [
      'All Date',
      'Last 24 hours',
      'Last 7 days',
      'Last 30 days'
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
          children: dates
              .map((date) => _ModalOption(
                    label: date,
                    isSelected: selectedDate == date,
                    onTap: () {
                      onDateChanged(date);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 14,
              color: const Color(0xFF6B7280),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.expand_more,
              size: 14,
              color: Color(0xFF6B7280),
            ),
          ],
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

// ─── Pending Job Card ──────────────────────────────────────────────────────────

class _PendingJobCard extends StatelessWidget {
  final JobData job;
  final VoidCallback onReview;
  final VoidCallback onRemove;

  const _PendingJobCard({
    required this.job,
    required this.onReview,
    required this.onRemove,
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
                Text(
                  job.id,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Pending',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF92400E),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              job.position,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3B3FA6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              job.employer,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _JobInfoField(label: 'Country', value: job.country),
                _JobInfoField(label: 'Salary', value: job.salary),
              ],
            ),
            const SizedBox(height: 8),
            _JobInfoField(label: 'Submitted', value: job.submittedDate),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onReview,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B3FA6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Approve',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onRemove,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3B3FA6),
                      side: const BorderSide(
                        color: Color(0xFF3B3FA6),
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReview,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3B3FA6),
                      side: const BorderSide(
                        color: Color(0xFF3B3FA6),
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Review',
                      style: TextStyle(
                        fontSize: 13,
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

// ─── Approved Job Card ─────────────────────────────────────────────────────────

class _ApprovedJobCard extends StatelessWidget {
  final JobData job;
  final VoidCallback onReview;

  const _ApprovedJobCard({
    required this.job,
    required this.onReview,
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
                Text(
                  job.id,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Approved',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              job.position,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3B3FA6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              job.employer,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _JobInfoField(label: 'Country', value: job.country),
                _JobInfoField(label: 'Salary', value: job.salary),
              ],
            ),
            const SizedBox(height: 8),
            _JobInfoField(label: 'Submitted', value: job.submittedDate),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B3FA6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Review',
                  style: TextStyle(
                    fontSize: 13,
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

// ─── Job Info Field ────────────────────────────────────────────────────────────

class _JobInfoField extends StatelessWidget {
  final String label;
  final String value;

  const _JobInfoField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
      ],
    );
  }
}

// ─── Job Review Modal ──────────────────────────────────────────────────────────

class _JobReviewModal extends StatefulWidget {
  final JobData job;
  final VoidCallback onApprove;

  const _JobReviewModal({
    required this.job,
    required this.onApprove,
  });

  @override
  State<_JobReviewModal> createState() => _JobReviewModalState();
}

class _JobReviewModalState extends State<_JobReviewModal> {
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

  Color _getRiskLevelColor(String level) {
    switch (level) {
      case 'HIGH':
        return const Color(0xFFDC2626);
      case 'MEDIUM':
        return const Color(0xFFD97706);
      default:
        return const Color(0xFF10B981);
    }
  }

  Color _getRiskLevelBgColor(String level) {
    switch (level) {
      case 'HIGH':
        return const Color(0xFFFEE2E2);
      case 'MEDIUM':
        return const Color(0xFFFEF3C7);
      default:
        return const Color(0xFFD1FAE5);
    }
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
                    widget.job.id,
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
                      color: const Color(0xFFD1FAE5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'APPROVED',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF065F46),
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
                      color: _getRiskLevelBgColor(widget.job.riskLevel),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'RISK: ${widget.job.riskLevel}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getRiskLevelColor(widget.job.riskLevel),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'JOB DETAILS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.work_outline,
                label: 'POSITION',
                value: widget.job.position,
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.business_outlined,
                label: 'EMPLOYER',
                value: widget.job.employer,
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.location_on_outlined,
                label: 'COUNTRY',
                value: widget.job.country,
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.attach_money_outlined,
                label: 'SALARY',
                value: widget.job.salary,
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.calendar_today_outlined,
                label: 'POSTED DATE',
                value: widget.job.submittedDate,
              ),
              const SizedBox(height: 12),
              _InfoField(
                label: 'WORKER COMPLAINTS',
                value: '${widget.job.complaints} complaints',
              ),
              const SizedBox(height: 24),
              const Text(
                'REVIEW NOTES',
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
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Add review notes about this job listing...',
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
                  onPressed: widget.onApprove,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B3FA6),
                    foregroundColor: Colors.white,
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

// ─── Job Data Model ────────────────────────────────────────────────────────────

class JobData {
  final String id;
  final String position;
  final String employer;
  final String country;
  final String salary;
  final String submittedDate;
  final String status;
  final String riskLevel;
  final int complaints;

  JobData({
    required this.id,
    required this.position,
    required this.employer,
    required this.country,
    required this.salary,
    required this.submittedDate,
    required this.status,
    required this.riskLevel,
    required this.complaints,
  });
}
