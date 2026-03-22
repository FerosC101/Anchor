import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/job_model.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';
import '../providers/jobs_provider.dart';
import 'job_detail_screen.dart';

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobsProvider);

    return Scaffold(
      appBar: const WorkerAppBar(),
      endDrawer: const WorkerDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: jobsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Failed to load jobs: $e')),
          data: (jobs) {
            if (jobs.isEmpty)
              return const Center(child: Text('No job listings yet.'));
            return ListView.separated(
              itemCount: jobs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) => _JobTile(job: jobs[i]),
            );
          },
        ),
      ),
    );
  }
}

class _JobTile extends StatelessWidget {
  const _JobTile({required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(job.title),
        subtitle: Text('${job.company} • ${job.city}, ${job.country}'),
        trailing: Text(
            '${job.currency} ${job.salaryMin.toStringAsFixed(0)}-${job.salaryMax.toStringAsFixed(0)}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => JobDetailScreen(job: job)),
          );
        },
      ),
    );
  }
}
