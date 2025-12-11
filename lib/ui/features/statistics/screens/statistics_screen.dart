import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../delegates/statistics_view_model.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(statisticsViewModelProvider);
    final viewModel = ref.read(statisticsViewModelProvider.notifier);

    if (asyncState.isLoading || asyncState.value == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final state = asyncState.value!;
    if (state.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Статистика')),
        body: Center(child: Text('Error: ${state.error}')),
      );
    }

    final data = state.data;
    if (data == null) {
      return const Scaffold(
        body: Center(child: Text('Нет данных для отображения')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel.loadStatistics,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.mostEatenRecipeThisWeek != null)
                _buildSection(
                  title: 'Любимое блюдо за неделю',
                  child: ListTile(
                    title: Text(data.mostEatenRecipeThisWeek!.name),
                    subtitle: Text(data.mostEatenRecipeThisWeek!.category),
                  ),
                ),
              _buildSection(
                title: 'Распределение блюд по дням',
                child: _buildChart(data.recipeCountByDay),
              ),
              _buildSection(
                title: 'Любимые категории',
                child: _buildList(
                  data.categoryCount.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value)),
                ),
              ),
              _buildSection(
                title: 'Часто используемые ингредиенты',
                child: _buildList(
                  data.ingredientUsageCount.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value)),
                ),
              ),
              _buildSection(
                title:
                    'Предлагаем попробовать',
                child: _buildList(
                  data.suggestedIngredients
                      .map((ing) => MapEntry(ing, 0))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildChart(Map<String, int> data) {
    if (data.isEmpty) {
      return const Text('Нет данных');
    }
    return Column(
      children: data.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text(entry.key)),
              Expanded(
                flex: 3,
                child: LinearProgressIndicator(
                  value:
                      entry.value /
                      data.values.reduce((a, b) => a > b ? a : b).toDouble(),
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Expanded(flex: 1, child: Text(entry.value.toString())),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildList(List<MapEntry<String, int>> entries) {
    if (entries.isEmpty) {
      return const Text('Нет данных');
    }
    return Column(
      children: entries
          .take(5)
          .map(
            (entry) => ListTile(
              title: Text(entry.key),
              trailing: entry.value > 0 ? Text(entry.value.toString()) : null,
            ),
          )
          .toList(),
    );
  }
}
