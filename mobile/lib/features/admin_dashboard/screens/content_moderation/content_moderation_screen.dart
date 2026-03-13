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

class ContentModerationScreen extends ConsumerStatefulWidget {
  const ContentModerationScreen({super.key});

  @override
  ConsumerState<ContentModerationScreen> createState() =>
      _ContentModerationScreenState();
}

class _ContentModerationScreenState
    extends ConsumerState<ContentModerationScreen> {
  int _selectedTab = 0; // 0 = Workers, 1 = NGO
  String _selectedContentType = 'Content Type';
  String _selectedStatus = 'Status';
  String _selectedDate = 'All Date';
  int _currentPage = 1;

  late List<ContentData> _workersContentList = [
    ContentData(
      id: 'PST-001',
      author: 'Sarah Johnson',
      postDate: '2026-03-06',
      postType: 'Discussion',
      flagCount: 15,
      flagReason: 'Inappropriate content',
      content:
          'This contains inappropriate and offensive language that violates community guidelines. [FLAGGED CONTENT]',
      severity: 'HIGH',
      role: 'WORKER',
      status: 'Pending',
      likes: 2,
      comments: 8,
    ),
    ContentData(
      id: 'PST-002',
      author: 'John Smith',
      postDate: '2026-03-04',
      postType: 'Comment',
      flagCount: 8,
      flagReason: 'Spam',
      content:
          'This contains inappropriate and offensive language that violates community guidelines. [FLAGGED CONTENT]',
      severity: 'MEDIUM',
      role: 'WORKER',
      status: 'Pending',
      likes: 1,
      comments: 3,
    ),
    ContentData(
      id: 'PST-003',
      author: 'Mike Chen',
      postDate: '2026-03-02',
      postType: 'Post',
      flagCount: 15,
      flagReason: 'Inappropriate content',
      content:
          'This contains inappropriate and offensive language that violates community guidelines. [FLAGGED CONTENT]',
      severity: 'HIGH',
      role: 'WORKER',
      status: 'Pending',
      likes: 2,
      comments: 8,
    ),
  ];

  late List<ContentData> _ngoContentList = [
    ContentData(
      id: 'NGO-001',
      author: 'Global Aid Foundation',
      postDate: '2026-03-05',
      postType: 'Post',
      flagCount: 12,
      flagReason: 'Misleading information',
      content:
          'This contains inappropriate and offensive language that violates community guidelines. [FLAGGED CONTENT]',
      severity: 'HIGH',
      role: 'NGO',
      status: 'Pending',
      likes: 5,
      comments: 10,
    ),
    ContentData(
      id: 'NGO-002',
      author: 'Community Care Initiative',
      postDate: '2026-03-03',
      postType: 'Discussion',
      flagCount: 15,
      flagReason: 'Inappropriate content',
      content:
          'This contains inappropriate and offensive language that violates community guidelines. [FLAGGED CONTENT]',
      severity: 'HIGH',
      role: 'NGO',
      status: 'Pending',
      likes: 3,
      comments: 6,
    ),
    ContentData(
      id: 'NGO-003',
      author: 'Hope Foundation',
      postDate: '2026-03-01',
      postType: 'Media',
      flagCount: 6,
      flagReason: 'Unverified claims',
      content:
          'This contains inappropriate and offensive language that violates community guidelines. [FLAGGED CONTENT]',
      severity: 'MEDIUM',
      role: 'NGO',
      status: 'Pending',
      likes: 4,
      comments: 5,
    ),
  ];

  List<ContentData> get _currentContentList =>
      _selectedTab == 0 ? _workersContentList : _ngoContentList;

  void _showContentReviewModal(ContentData content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.82,
        maxChildSize: 0.92,
        minChildSize: 0.55,
        expand: false,
        builder: (context, scrollController) => _ContentReviewModal(
          content: content,
          scrollController: scrollController,
          onApprove: () {
            setState(() {
              _currentContentList.removeWhere((item) => item.id == content.id);
            });
            Navigator.pop(context);
          },
          onRemove: () {
            setState(() {
              _currentContentList.removeWhere((item) => item.id == content.id);
            });
            Navigator.pop(context);
          },
        ),
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
              'Content Moderation',
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
                        setState(() => _selectedTab = index);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _SearchBar(
                      onChanged: (value) {
                        // TODO: Filter content based on search query
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  _FilterBar(
                    selectedContentType: _selectedContentType,
                    selectedStatus: _selectedStatus,
                    selectedDate: _selectedDate,
                    onContentTypeChanged: (value) {
                      setState(() => _selectedContentType = value);
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
                      'Flagged Contents (${_currentContentList.length})',
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
                      itemCount: _currentContentList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final content = _currentContentList[index];
                        return _ContentCard(
                          content: content,
                          onReview: () => _showContentReviewModal(content),
                          onRemove: () {
                            setState(() {
                              _currentContentList.removeAt(index);
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
    return AdminSearchBar(
      hintText: 'Search content',
      onChanged: onChanged,
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

// ─── Filter Bar ────────────────────────────────────────────────────────────────

class _FilterBar extends StatelessWidget {
  final String selectedContentType;
  final String selectedStatus;
  final String selectedDate;
  final Function(String) onContentTypeChanged;
  final Function(String) onStatusChanged;
  final Function(String) onDateChanged;

  const _FilterBar({
    required this.selectedContentType,
    required this.selectedStatus,
    required this.selectedDate,
    required this.onContentTypeChanged,
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
              icon: Icons.category_outlined,
              label: selectedContentType,
              onTap: () => _showContentTypeModal(context),
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

  void _showContentTypeModal(BuildContext context) {
    List<String> types = [
      'Content Type',
      'Post',
      'Comment',
      'Discussion',
      'Media',
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
          children: types
              .map((type) => _ModalOption(
                    label: type,
                    isSelected: selectedContentType == type,
                    onTap: () {
                      onContentTypeChanged(type);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showStatusModal(BuildContext context) {
    List<String> statuses = [
      'Status',
      'Pending',
      'Reviewed',
      'Approved',
      'Removed'
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

// ─── Content Card ────────────────────────────────────────────────────────────────

class _ContentCard extends StatelessWidget {
  final ContentData content;
  final VoidCallback onReview;
  final VoidCallback onRemove;

  const _ContentCard({
    required this.content,
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
                  content.id,
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
              content.author,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.flag_outlined,
                  size: 14,
                  color: Color(0xFFDC2626),
                ),
                const SizedBox(width: 4),
                Text(
                  '${content.flagCount} Reports',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_rounded,
                    size: 14,
                    color: Color(0xFFDC2626),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      content.flagReason,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Submitted on ${content.postDate}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1,
                ),
              ),
              child: Text(
                content.content,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4B5563),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onReview,
                    style: AdminButtonStyles.primary,
                    child: const Text(
                      'Review',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onRemove,
                    style: AdminButtonStyles.secondary,
                    child: const Text(
                      'Remove',
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

// ─── Content Review Modal ──────────────────────────────────────────────────────

class _ContentReviewModal extends StatefulWidget {
  final ContentData content;
  final VoidCallback onApprove;
  final VoidCallback onRemove;
  final ScrollController? scrollController;

  const _ContentReviewModal({
    required this.content,
    required this.onApprove,
    required this.onRemove,
    this.scrollController,
  });

  @override
  State<_ContentReviewModal> createState() => _ContentReviewModalState();
}

class _ContentReviewModalState extends State<_ContentReviewModal> {
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

  Color _getSeverityBgColor(String severity) {
    switch (severity) {
      case 'HIGH':
        return const Color(0xFFFEE2E2);
      case 'MEDIUM':
        return const Color(0xFFFEF3C7);
      default:
        return const Color(0xFFD1FAE5);
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'HIGH':
        return const Color(0xFFDC2626);
      case 'MEDIUM':
        return const Color(0xFFD97706);
      default:
        return const Color(0xFF10B981);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          controller: widget.scrollController,
          padding: EdgeInsets.fromLTRB(
            24,
            14,
            24,
            24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Content Review',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        Text(
                          widget.content.id,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
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
                      widget.content.role,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B46C1),
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
                      color: _getSeverityBgColor(widget.content.severity),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.content.severity,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getSeverityColor(widget.content.severity),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'POST INFORMATION',
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
                label: 'AUTHOR',
                value: widget.content.author,
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.calendar_today_outlined,
                label: 'POSTED DATE',
                value: widget.content.postDate,
              ),
              const SizedBox(height: 12),
              _InfoField(
                icon: Icons.description_outlined,
                label: 'POST TYPE',
                value: widget.content.postType,
              ),
              const SizedBox(height: 12),
              _InfoField(
                label: 'FLAG COUNT',
                value: '${widget.content.flagCount} reports',
              ),
              const SizedBox(height: 24),
              const Text(
                'FLAG DETAILS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFFECDD0),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.warning_rounded,
                          size: 16,
                          color: Color(0xFFDC2626),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.content.flagReason,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFDC2626),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This content has been flagged by ${widget.content.flagCount} users for violating community guidelines.',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7F1D1D),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'CONTENT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.content.content,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4B5563),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'ENGAGEMENT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _EngagementBox(
                    label: 'LIKES',
                    value: widget.content.likes.toString(),
                  ),
                  _EngagementBox(
                    label: 'COMMENTS',
                    value: widget.content.comments.toString(),
                  ),
                  _EngagementBox(
                    label: 'REPORTS',
                    value: widget.content.flagCount.toString(),
                  ),
                ],
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
                    hintText: 'Add review notes...',
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
                  style: AdminButtonStyles.primary,
                  child: const Text(
                    'Approve Content',
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
                child: ElevatedButton(
                  onPressed: widget.onRemove,
                  style: AdminButtonStyles.secondary,
                  child: const Text(
                    'Remove Content',
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
                  style: AdminButtonStyles.secondary,
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

// ─── Engagement Box ────────────────────────────────────────────────────────────

class _EngagementBox extends StatelessWidget {
  final String label;
  final String value;

  const _EngagementBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3B3FA6),
            ),
          ),
        ],
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

// ─── Content Data Model ────────────────────────────────────────────────────────

class ContentData {
  final String id;
  final String author;
  final String postDate;
  final String postType;
  final int flagCount;
  final String flagReason;
  final String content;
  final String severity;
  final String role;
  final String status;
  final int likes;
  final int comments;

  ContentData({
    required this.id,
    required this.author,
    required this.postDate,
    required this.postType,
    required this.flagCount,
    required this.flagReason,
    required this.content,
    required this.severity,
    required this.role,
    required this.status,
    required this.likes,
    required this.comments,
  });
}
