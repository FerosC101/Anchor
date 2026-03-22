import 'package:flutter/material.dart';

import '../../../models/job_model.dart';
import 'report_job_screen.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key, required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('${job.company} • ${job.city}, ${job.country}'),
            const SizedBox(height: 12),
            Text(
                '${job.currency} ${job.salaryMin.toStringAsFixed(0)} - ${job.salaryMax.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Text(job.description),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.flag_outlined),
                label: const Text('Report this listing'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReportJobScreen(jobTitle: job.title),
                    ),
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
