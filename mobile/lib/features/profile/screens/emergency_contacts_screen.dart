import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const WorkerAppBar(showBackButton: true),
      endDrawer: const WorkerDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Emergency Contacts',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'If you are in danger, call your local emergency number first.',
            style: TextStyle(color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 14),
          _ContactTile(
            title: 'Local Emergency',
            subtitle: 'Police / Ambulance',
            number: '999',
          ),
          _ContactTile(
            title: 'Philippine Embassy Hotline',
            subtitle: 'Consular support for OFWs',
            number: '+63 2 8551 0000',
          ),
          _ContactTile(
            title: 'POEA / DMW Assistance',
            subtitle: 'Worker protection and repatriation',
            number: '+63 2 8722 1144',
          ),
          _ContactTile(
            title: 'Anchor Support',
            subtitle: 'App support and safety guidance',
            number: '+63 2 7000 0000',
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.title,
    required this.subtitle,
    required this.number,
  });

  final String title;
  final String subtitle;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFDFEDFF),
          child: Icon(Icons.call_outlined, color: Color(0xFF003696)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: IconButton(
          tooltip: 'Copy number',
          icon: const Icon(Icons.copy_outlined),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: number));
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Copied: $number')),
            );
          },
        ),
      ),
    );
  }
}
