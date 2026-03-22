import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final currentUser = FirebaseAuth.instance.currentUser;

    if (authState.isLoading && authState.user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final userId = currentUser?.uid ?? authState.user?.id;
    final fullName = authState.user?.fullName ?? 'Unknown User';
    final email = authState.user?.email ?? currentUser?.email ?? 'No email';
    final country = authState.user?.country ?? 'Unknown';
    final phone = authState.user?.phoneNumber ?? 'Not set';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const WorkerAppBar(showBackButton: true),
      endDrawer: const WorkerDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFDFEDFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person_outline, color: Color(0xFF003696)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        email,
                        style: const TextStyle(
                          color: Color(0xFF003696),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: userId == null
                      ? null
                      : () => _showEditProfileDialog(
                            context: context,
                            userId: userId,
                            currentName: fullName,
                            currentPhone: phone,
                            currentCountry: country,
                          ),
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (userId != null) _StatsRow(userId: userId),
          const SizedBox(height: 16),
          _ProfileField(label: 'Full Name', value: fullName),
          _ProfileField(label: 'Email', value: email),
          _ProfileField(label: 'Phone Number', value: phone),
          _ProfileField(label: 'Country', value: country),
        ],
      ),
    );
  }

  Future<void> _showEditProfileDialog({
    required BuildContext context,
    required String userId,
    required String currentName,
    required String currentPhone,
    required String currentCountry,
  }) async {
    final nameController = TextEditingController(text: currentName);
    final phoneController = TextEditingController(text: currentPhone);
    final countryController = TextEditingController(text: currentCountry);

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: countryController,
              decoration: const InputDecoration(labelText: 'Country'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection(FirebaseConstants.usersCollection)
                  .doc(userId)
                  .set(
                {
                  'full_name': nameController.text.trim(),
                  'phone_number': phoneController.text.trim(),
                  'country': countryController.text.trim(),
                  'updated_at': FieldValue.serverTimestamp(),
                },
                SetOptions(merge: true),
              );

              if (!context.mounted) return;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated.')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Contracts',
            stream: firestore
                .collection(FirebaseConstants.contractsCollection)
                .where('user_id', isEqualTo: userId)
                .snapshots(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            title: 'Wage Logs',
            stream: firestore
                .collection(FirebaseConstants.usersCollection)
                .doc(userId)
                .collection(FirebaseConstants.wageLogsSubcollection)
                .snapshots(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            title: 'Reports',
            stream: firestore
                .collection(FirebaseConstants.reportsCollection)
                .where('reporter_id', isEqualTo: userId)
                .snapshots(),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.stream});

  final String title;
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        final count = snapshot.data?.docs.length ?? 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF334155),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Color(0xFF64748B)),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
