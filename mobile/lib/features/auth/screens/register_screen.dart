import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/user_model.dart';
import '../providers/auth_provider.dart';

// ─── Register Screen ──────────────────────────────────────────────────────────

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _pageController = PageController();
  int _currentStep = 0;
  static const int _totalSteps = 3;

  // ── Step 1 – Basic Info ───────────────────────────────────────────────────
  final _step1Key = GlobalKey<FormState>();
  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String _country = 'Philippines';
  bool _showPass = false;
  bool _showConfirmPass = false;

  // ── Step 2 – Role ─────────────────────────────────────────────────────────
  UserRole? _selectedRole;

  // ── Step 3 – OFW ─────────────────────────────────────────────────────────
  final _ofwFormKey = GlobalKey<FormState>();
  final _passportCtrl = TextEditingController();
  String _destinationCountry = 'Saudi Arabia';
  final _jobTitleCtrl = TextEditingController();
  final _expYearsCtrl = TextEditingController();

  // ── Step 3 – Agency ──────────────────────────────────────────────────────
  final _agencyFormKey = GlobalKey<FormState>();
  final _agencyNameCtrl = TextEditingController();
  final _licenseCtrl = TextEditingController();
  String _agencyCountry = 'Philippines';
  final _agencyAddressCtrl = TextEditingController();
  final _agencyEmailCtrl = TextEditingController();
  final _agencyPhoneCtrl = TextEditingController();

  // ── Step 3 – Verifier ─────────────────────────────────────────────────────
  final _verifierFormKey = GlobalKey<FormState>();
  final _orgNameCtrl = TextEditingController();
  OrganizationType _orgType = OrganizationType.government;
  final _roleTitleCtrl = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _fullNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPassCtrl.dispose();
    _phoneCtrl.dispose();
    _passportCtrl.dispose();
    _jobTitleCtrl.dispose();
    _expYearsCtrl.dispose();
    _agencyNameCtrl.dispose();
    _licenseCtrl.dispose();
    _agencyAddressCtrl.dispose();
    _agencyEmailCtrl.dispose();
    _agencyPhoneCtrl.dispose();
    _orgNameCtrl.dispose();
    _roleTitleCtrl.dispose();
    super.dispose();
  }

  // ─── Navigation ────────────────────────────────────────────────────────────

  void _next() {
    FocusScope.of(context).unfocus();

    if (_currentStep == 0) {
      if (!_step1Key.currentState!.validate()) return;
      _goToStep(1);
    } else if (_currentStep == 1) {
      if (_selectedRole == null) {
        _showRoleError();
        return;
      }
      // Pre-fill agency contact fields from basic info
      if (_selectedRole == UserRole.agency) {
        if (_agencyEmailCtrl.text.isEmpty) {
          _agencyEmailCtrl.text = _emailCtrl.text;
        }
        if (_agencyPhoneCtrl.text.isEmpty) {
          _agencyPhoneCtrl.text = _phoneCtrl.text;
        }
      }
      _goToStep(2);
    } else {
      _submit();
    }
  }

  void _back() {
    if (_currentStep == 0) {
      context.pop();
    } else {
      _goToStep(_currentStep - 1);
    }
  }

  void _goToStep(int step) {
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _showRoleError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Please select your role to continue'),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ─── Submit registration ───────────────────────────────────────────────────

  Future<void> _submit() async {
    // Validate role-specific form
    bool valid = false;
    Map<String, dynamic> roleData = {};

    switch (_selectedRole!) {
      case UserRole.ofw:
        valid = _ofwFormKey.currentState?.validate() ?? true;
        if (valid) {
          roleData = {
            if (_passportCtrl.text.isNotEmpty)
              'passport_number': _passportCtrl.text.trim(),
            'destination_country': _destinationCountry,
            if (_jobTitleCtrl.text.isNotEmpty)
              'job_title': _jobTitleCtrl.text.trim(),
            if (_expYearsCtrl.text.isNotEmpty)
              'experience_years': int.tryParse(_expYearsCtrl.text) ?? 0,
          };
        }

      case UserRole.agency:
        valid = _agencyFormKey.currentState?.validate() ?? false;
        if (valid) {
          roleData = {
            'agency_name': _agencyNameCtrl.text.trim(),
            'license_number': _licenseCtrl.text.trim(),
            'country': _agencyCountry,
            'address': _agencyAddressCtrl.text.trim(),
            'contact_email': _agencyEmailCtrl.text.trim(),
            'contact_phone': _agencyPhoneCtrl.text.trim(),
          };
        }

      case UserRole.verifier:
        valid = _verifierFormKey.currentState?.validate() ?? false;
        if (valid) {
          roleData = {
            'organization_name': _orgNameCtrl.text.trim(),
            'organization_type': _orgType.name,
            'role_title': _roleTitleCtrl.text.trim(),
          };
        }

      default:
        valid = false;
    }

    if (!valid) return;

    final success = await ref.read(authNotifierProvider.notifier).register(
          email: _emailCtrl.text,
          password: _passwordCtrl.text,
          fullName: _fullNameCtrl.text,
          role: _selectedRole!,
          phoneNumber: _phoneCtrl.text,
          country: _country,
          roleData: roleData,
        );

    if (success && mounted) {
      context.go('/home');
    }
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    ref.listen(authNotifierProvider, (prev, next) {
      if (next.error != null && next.error != prev?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        ref.read(authNotifierProvider.notifier).clearError();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildStep1(),
                    _buildStep2(),
                    _buildStep3(),
                  ],
                ),
              ),
              _buildBottomBar(isLoading),
            ],
          ),

          // ── Global loading overlay ─────────────────────────────────────────
          if (isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: AppColors.primary),
                        SizedBox(height: 16),
                        Text('Creating your account…'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─── Header with step indicator ────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top row: back button + title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: _back,
                  ),
                  Expanded(
                    child: Text(
                      _stepTitle(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // balance the back button
                ],
              ),
            ),

            // Step dots + progress bar
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 20),
              child: Column(
                children: [
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_totalSteps, (i) {
                      final isActive = i == _currentStep;
                      final isDone = i < _currentStep;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: isActive ? 28 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: isDone || isActive
                              ? Colors.white
                              : Colors.white.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: isDone
                            ? const Center(
                                child: Icon(
                                  Icons.check,
                                  size: 8,
                                  color: AppColors.primary,
                                ),
                              )
                            : null,
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (_currentStep + 1) / _totalSteps,
                      backgroundColor: Colors.white.withOpacity(0.25),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Step ${_currentStep + 1} of $_totalSteps',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _stepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Basic Information';
      case 1:
        return 'Choose Your Role';
      case 2:
        return _roleStepTitle();
      default:
        return 'Create Account';
    }
  }

  String _roleStepTitle() {
    switch (_selectedRole) {
      case UserRole.ofw:
        return 'OFW Details';
      case UserRole.agency:
        return 'Agency Details';
      case UserRole.verifier:
        return 'Organization Details';
      default:
        return 'Your Details';
    }
  }

  // ─── Bottom navigation bar ─────────────────────────────────────────────────

  Widget _buildBottomBar(bool isLoading) {
    final isLastStep = _currentStep == _totalSteps - 1;
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: isLoading ? null : _next,
            child: Text(isLastStep ? 'Create Account' : 'Continue'),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STEP 1 – Basic Information
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _step1Key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel('Personal Information'),
            const SizedBox(height: 16),

            // Full name
            _buildField(
              controller: _fullNameCtrl,
              label: 'Full Name',
              hint: 'Juan dela Cruz',
              icon: Icons.person_outline_rounded,
              action: TextInputAction.next,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Full name is required'
                  : null,
            ),
            const SizedBox(height: 16),

            // Email
            _buildField(
              controller: _emailCtrl,
              label: 'Email Address',
              hint: 'juan@example.com',
              icon: Icons.email_outlined,
              keyboard: TextInputType.emailAddress,
              action: TextInputAction.next,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email is required';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Phone
            _buildField(
              controller: _phoneCtrl,
              label: 'Phone Number',
              hint: '+63 9XX XXX XXXX',
              icon: Icons.phone_outlined,
              keyboard: TextInputType.phone,
              action: TextInputAction.next,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Phone number is required'
                  : null,
            ),
            const SizedBox(height: 16),

            // Country
            _buildSearchablePickerField(
              label: 'Current Country',
              icon: Icons.public_rounded,
              value: _country,
              onTap: () => _showSearchablePicker(
                context: context,
                title: 'Select Country',
                items: AppConstants.countries,
                currentValue: _country,
                onSelect: (v) => setState(() => _country = v),
              ),
            ),
            const SizedBox(height: 24),

            _sectionLabel('Security'),
            const SizedBox(height: 16),

            // Password
            TextFormField(
              controller: _passwordCtrl,
              obscureText: !_showPass,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.textSecondary,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPass
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => setState(() => _showPass = !_showPass),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Password is required';
                if (v.length < 6)
                  return 'Password must be at least 6 characters';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Confirm password
            TextFormField(
              controller: _confirmPassCtrl,
              obscureText: !_showConfirmPass,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.textSecondary,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showConfirmPass
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () =>
                      setState(() => _showConfirmPass = !_showConfirmPass),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty)
                  return 'Please confirm your password';
                if (v != _passwordCtrl.text) return 'Passwords do not match';
                return null;
              },
            ),

            const SizedBox(height: 24),

            // Already have an account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style:
                      TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STEP 2 – Role Selection
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select the role that best describes you',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // OFW Card
          _RoleCard(
            role: UserRole.ofw,
            icon: Icons.flight_takeoff_rounded,
            title: 'OFW Worker',
            description:
                'I am an Overseas Filipino Worker seeking contract protection and employment support.',
            color: AppColors.ofwColor,
            isSelected: _selectedRole == UserRole.ofw,
            onTap: () => setState(() => _selectedRole = UserRole.ofw),
          ),
          const SizedBox(height: 16),

          // Agency Card
          _RoleCard(
            role: UserRole.agency,
            icon: Icons.business_rounded,
            title: 'Recruitment Agency',
            description:
                'I represent a licensed recruitment agency deploying Filipino workers abroad.',
            color: AppColors.agencyColor,
            isSelected: _selectedRole == UserRole.agency,
            onTap: () => setState(() => _selectedRole = UserRole.agency),
          ),
          const SizedBox(height: 16),

          // Verifier Card
          _RoleCard(
            role: UserRole.verifier,
            icon: Icons.verified_user_rounded,
            title: 'Government / NGO Verifier',
            description:
                'I work for a government agency, embassy, or NGO that verifies employment contracts.',
            color: AppColors.verifierColor,
            isSelected: _selectedRole == UserRole.verifier,
            onTap: () => setState(() => _selectedRole = UserRole.verifier),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STEP 3 – Role-specific Details
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildStep3() {
    switch (_selectedRole) {
      case UserRole.ofw:
        return _buildOfwStep();
      case UserRole.agency:
        return _buildAgencyStep();
      case UserRole.verifier:
        return _buildVerifierStep();
      default:
        return const Center(child: Text('Please go back and select a role.'));
    }
  }

  // ── OFW form ───────────────────────────────────────────────────────────────

  Widget _buildOfwStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _ofwFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _roleInfoBanner(
              icon: Icons.flight_takeoff_rounded,
              color: AppColors.ofwColor,
              label: 'OFW Worker',
              note: 'This information helps us protect your rights abroad. '
                  'You can update these details in your profile later.',
            ),
            const SizedBox(height: 24),
            _sectionLabel('Work Information'),
            const SizedBox(height: 16),
            _buildField(
              controller: _passportCtrl,
              label: 'Passport Number (optional)',
              hint: 'A1234567',
              icon: Icons.badge_outlined,
              action: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            _buildSearchablePickerField(
              label: 'Destination Country',
              icon: Icons.place_outlined,
              value: _destinationCountry,
              onTap: () => _showSearchablePicker(
                context: context,
                title: 'Select Destination Country',
                items: AppConstants.countries
                    .where((c) => c != 'Philippines')
                    .toList(),
                currentValue: _destinationCountry,
                onSelect: (v) => setState(() => _destinationCountry = v),
              ),
            ),
            const SizedBox(height: 16),
            _buildJobPickerField(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _expYearsCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Years of Experience (optional)',
                hintText: '0',
                prefixIcon: Icon(
                  Icons.star_border_rounded,
                  color: AppColors.textSecondary,
                ),
              ),
              validator: (v) {
                if (v != null && v.isNotEmpty) {
                  final years = int.tryParse(v);
                  if (years == null || years < 0 || years > 50) {
                    return 'Enter a valid number (0–50)';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── Agency form ────────────────────────────────────────────────────────────

  Widget _buildAgencyStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _agencyFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _roleInfoBanner(
              icon: Icons.business_rounded,
              color: AppColors.agencyColor,
              label: 'Recruitment Agency',
              note: 'Your agency will be reviewed by our team before being '
                  'listed on the platform. Ensure your POEA license is valid.',
            ),
            const SizedBox(height: 24),
            _sectionLabel('Agency Details'),
            const SizedBox(height: 16),
            _buildField(
              controller: _agencyNameCtrl,
              label: 'Agency Name',
              hint: 'ABC Recruitment Inc.',
              icon: Icons.business_rounded,
              action: TextInputAction.next,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Agency name is required'
                  : null,
            ),
            const SizedBox(height: 16),
            _buildField(
              controller: _licenseCtrl,
              label: 'POEA License Number',
              hint: 'POEA-XXX-LB-XXXXX-XX',
              icon: Icons.verified_outlined,
              action: TextInputAction.next,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'License number is required'
                  : null,
            ),
            const SizedBox(height: 16),
            _buildSearchablePickerField(
              label: 'Country of Operation',
              icon: Icons.public_rounded,
              value: _agencyCountry,
              onTap: () => _showSearchablePicker(
                context: context,
                title: 'Select Country of Operation',
                items: AppConstants.countries,
                currentValue: _agencyCountry,
                onSelect: (v) => setState(() => _agencyCountry = v),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _agencyAddressCtrl,
              maxLines: 2,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Office Address',
                hintText: 'Complete street address',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.textSecondary,
                  ),
                ),
                alignLabelWithHint: true,
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Office address is required'
                  : null,
            ),
            const SizedBox(height: 24),
            _sectionLabel('Contact Information'),
            const SizedBox(height: 16),
            _buildField(
              controller: _agencyEmailCtrl,
              label: 'Contact Email',
              hint: 'agency@example.com',
              icon: Icons.email_outlined,
              keyboard: TextInputType.emailAddress,
              action: TextInputAction.next,
              validator: (v) {
                if (v == null || v.trim().isEmpty)
                  return 'Contact email is required';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildField(
              controller: _agencyPhoneCtrl,
              label: 'Contact Phone',
              hint: '+63 2 XXXX XXXX',
              icon: Icons.phone_outlined,
              keyboard: TextInputType.phone,
              action: TextInputAction.done,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Contact phone is required'
                  : null,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── Verifier form ──────────────────────────────────────────────────────────

  Widget _buildVerifierStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _verifierFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _roleInfoBanner(
              icon: Icons.verified_user_rounded,
              color: AppColors.verifierColor,
              label: 'Government / NGO Verifier',
              note: 'Verifiers have access to contract review tools and can '
                  'flag or approve employment contracts submitted by OFWs.',
            ),
            const SizedBox(height: 24),
            _sectionLabel('Organization Details'),
            const SizedBox(height: 16),

            _buildField(
              controller: _orgNameCtrl,
              label: 'Organization Name',
              hint: 'e.g. OWWA, POEA, Philippine Embassy',
              icon: Icons.account_balance_outlined,
              action: TextInputAction.next,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Organization name is required'
                  : null,
            ),
            const SizedBox(height: 16),

            // Organization type dropdown
            DropdownButtonFormField<OrganizationType>(
              value: _orgType,
              decoration: const InputDecoration(
                labelText: 'Organization Type',
                prefixIcon: Icon(
                  Icons.category_outlined,
                  color: AppColors.textSecondary,
                ),
              ),
              items: [
                _orgTypeItem(OrganizationType.government, 'Government Agency'),
                _orgTypeItem(OrganizationType.ngo, 'NGO / Non-profit'),
                _orgTypeItem(OrganizationType.embassy, 'Embassy / Consulate'),
              ],
              onChanged: (v) => setState(() => _orgType = v!),
            ),
            const SizedBox(height: 16),

            _buildField(
              controller: _roleTitleCtrl,
              label: 'Your Role / Title',
              hint: 'e.g. Labor Attaché, Case Worker, Director',
              icon: Icons.badge_outlined,
              action: TextInputAction.done,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Role/title is required'
                  : null,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _roleInfoBanner({
    required IconData icon,
    required Color color,
    required String label,
    required String note,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  note,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    TextInputAction action = TextInputAction.next,
    String? Function(String?)? validator,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      textInputAction: action,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.textSecondary),
      ),
      validator: validator,
    );
  }

  // ── Searchable picker field (tappable, looks like a form field) ─────────────

  Widget _buildSearchablePickerField({
    required String label,
    required IconData icon,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.textSecondary),
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
      ),
    );
  }

  // ── Job picker field ──────────────────────────────────────────────────────────

  Widget _buildJobPickerField() {
    final hasValue = _jobTitleCtrl.text.isNotEmpty;
    return GestureDetector(
      onTap: () => _showJobPicker(
        context: context,
        currentValue: hasValue ? _jobTitleCtrl.text : null,
        onSelect: (job) => setState(() => _jobTitleCtrl.text = job),
      ),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Job Title (optional)',
          prefixIcon: Icon(
            Icons.work_outline_rounded,
            color: AppColors.textSecondary,
          ),
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
        ),
        child: Text(
          hasValue ? _jobTitleCtrl.text : 'Select job title',
          style: TextStyle(
            fontSize: 14,
            color: hasValue ? AppColors.textPrimary : AppColors.textHint,
          ),
        ),
      ),
    );
  }

  // ── Searchable country / list bottom sheet ────────────────────────────────────

  Future<void> _showSearchablePicker({
    required BuildContext context,
    required String title,
    required List<String> items,
    required String? currentValue,
    required void Function(String) onSelect,
  }) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SearchablePickerSheet(
        title: title,
        items: items,
        currentValue: currentValue,
      ),
    );
    if (selected != null) onSelect(selected);
  }

  // ── Categorised job picker bottom sheet ───────────────────────────────────────

  Future<void> _showJobPicker({
    required BuildContext context,
    required String? currentValue,
    required void Function(String) onSelect,
  }) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _JobPickerSheet(currentValue: currentValue),
    );
    if (selected != null) onSelect(selected);
  }

  DropdownMenuItem<OrganizationType> _orgTypeItem(
    OrganizationType type,
    String label,
  ) {
    return DropdownMenuItem(value: type, child: Text(label));
  }
}

// ─── Searchable Picker Sheet ─────────────────────────────────────────────────

class _SearchablePickerSheet extends StatefulWidget {
  const _SearchablePickerSheet({
    required this.title,
    required this.items,
    required this.currentValue,
  });

  final String title;
  final List<String> items;
  final String? currentValue;

  @override
  State<_SearchablePickerSheet> createState() => _SearchablePickerSheetState();
}

class _SearchablePickerSheetState extends State<_SearchablePickerSheet> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _ctrl.text.toLowerCase();
    final filtered = q.isEmpty
        ? widget.items
        : widget.items.where((i) => i.toLowerCase().contains(q)).toList();
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.92,
      minChildSize: 0.4,
      expand: false,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: _ctrl,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _ctrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _ctrl.clear();
                            setState(() {});
                          },
                        )
                      : null,
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                itemCount: filtered.length,
                itemBuilder: (_, i) {
                  final item = filtered[i];
                  final isSelected = item == widget.currentValue;
                  return ListTile(
                    title: Text(item),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check_rounded,
                            color: AppColors.primary,
                          )
                        : null,
                    selected: isSelected,
                    selectedTileColor:
                        AppColors.primary.withValues(alpha: 0.05),
                    onTap: () => Navigator.of(context).pop(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Job Picker Sheet ─────────────────────────────────────────────────────────

class _JobPickerSheet extends StatefulWidget {
  const _JobPickerSheet({required this.currentValue});

  final String? currentValue;

  @override
  State<_JobPickerSheet> createState() => _JobPickerSheetState();
}

class _JobPickerSheetState extends State<_JobPickerSheet> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _ctrl.text.toLowerCase();
    final isSearching = q.isNotEmpty;
    final allJobs = [
      for (final entry in AppConstants.jobCategories.entries)
        for (final job in entry.value) (category: entry.key, job: job),
    ];
    final filtered = isSearching
        ? allJobs
            .where((j) =>
                j.job.toLowerCase().contains(q) ||
                j.category.toLowerCase().contains(q))
            .toList()
        : <({String category, String job})>[];
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                'Select Job Title',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: _ctrl,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search jobs...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _ctrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _ctrl.clear();
                            setState(() {});
                          },
                        )
                      : null,
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            Expanded(
              child: isSearching
                  ? ListView.builder(
                      controller: scrollCtrl,
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final item = filtered[i];
                        final isSelected = item.job == widget.currentValue;
                        return ListTile(
                          title: Text(item.job),
                          subtitle: Text(
                            item.category,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: AppColors.primary,
                                )
                              : null,
                          onTap: () => Navigator.of(context).pop(item.job),
                        );
                      },
                    )
                  : ListView(
                      controller: scrollCtrl,
                      children: [
                        for (final entry in AppConstants.jobCategories.entries)
                          Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              title: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              children: entry.value.map((job) {
                                final isSelected = job == widget.currentValue;
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                  ),
                                  title: Text(
                                    job,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  trailing: isSelected
                                      ? const Icon(
                                          Icons.check_rounded,
                                          color: AppColors.primary,
                                        )
                                      : null,
                                  onTap: () => Navigator.of(context).pop(job),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Role Selection Card ──────────────────────────────────────────────────────

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.role,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final UserRole role;
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.06) : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? color : AppColors.border,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: color.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: color.withOpacity(isSelected ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? color : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),

                // Selection indicator
                const SizedBox(width: 8),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isSelected
                      ? Container(
                          key: const ValueKey('checked'),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        )
                      : Container(
                          key: const ValueKey('unchecked'),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.border,
                              width: 1.5,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
