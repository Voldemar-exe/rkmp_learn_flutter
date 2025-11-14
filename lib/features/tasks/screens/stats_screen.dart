import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/stats_data.dart';
import 'package:rkmp_learn_flutter/features/tasks/widgets/stat_card.dart';

class StatsScreen extends ConsumerWidget {
  static const String statsIconicImageUrl =
      'https://cdn4.iconfinder.com/data/icons/success-filloutline/64/board-stats-report-presentation-diagram-512.png';

  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.read(statsDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Статистика')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Ваш прогресс',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 20),
                  CachedNetworkImage(
                    imageUrl: statsIconicImageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.image_not_supported, size: 60),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StatCard(
                label: 'Всего заданий',
                value: stats.total.toString(),
                color: Colors.blue,
              ),
              StatCard(
                label: 'Выполнено',
                value: stats.completed.toString(),
                color: Colors.green,
              ),
              StatCard(
                label: 'Осталось',
                value: stats.pending.toString(),
                color: Colors.orange,
              ),
              const SizedBox(height: 30),
              Text(
                'Выполненные по категориям:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              ...stats.tagCounts.entries.map((entry) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 12,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      entry.value.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  title: Text('#${entry.key}'),
                  trailing: Text('${entry.value} раз'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
