import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/models/ingredient.dart';
import 'package:rkmp_learn_flutter/features/ingredients/presentation/store/ingredients_view_model.dart';

class IngredientsListScreen extends ConsumerWidget {
  const IngredientsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(ingredientsViewModelProvider);
    final viewModel = ref.read(ingredientsViewModelProvider.notifier);

    if (asyncState.isLoading || asyncState.value == null ) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final state = asyncState.value!;

    if (state.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Холодильник')),
        body: Center(child: Text('Error: ${state.error}')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Холодильник'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel.loadUserIngredients,
          ),
        ],
      ),
      body: state.ingredients.isEmpty
          ? const Center(child: Text("Холодильник пуст. Добавьте ингредиенты!"))
          : ListView.builder(
              itemCount: state.ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = state.ingredients[index];
                return Card(
                  child: ListTile(
                    title: Text(ingredient.name),
                    subtitle: Text(
                      '${ingredient.amount ?? 0} ${ingredient.measureUnit ?? ''}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 20),
                          onPressed: () =>
                              viewModel.consumeAmount(ingredient.id, 100.0),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove, size: 16),
                          onPressed: () =>
                              viewModel.consumeAmount(ingredient.id, 10.0),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove, size: 12),
                          onPressed: () =>
                              viewModel.consumeAmount(ingredient.id, 1.0),
                        ),
                        const VerticalDivider(),
                        IconButton(
                          icon: const Icon(Icons.add, size: 12),
                          onPressed: () =>
                              viewModel.addAmount(ingredient.id, 1.0),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 16),
                          onPressed: () =>
                              viewModel.addAmount(ingredient.id, 10.0),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 20),
                          onPressed: () =>
                              viewModel.addAmount(ingredient.id, 100.0),
                        ),
                        const VerticalDivider(),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () => _showDeleteConfirmationDialog(
                            context,
                            viewModel,
                            ingredient,
                          ),
                        ),
                      ],
                    ),
                    onTap: () =>
                        _showEditAmountDialog(context, viewModel, ingredient),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/ingredients/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditAmountDialog(
    BuildContext context,
    IngredientsViewModel viewModel,
    Ingredient ingredient,
  ) {
    final amountController = TextEditingController(
      text: (ingredient.amount ?? 0).toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Изменить количество (${ingredient.name} ${ingredient.measureUnit})'),
        content: TextField(
          controller: amountController,
          decoration: const InputDecoration(hintText: 'Количество'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              final amountStr = amountController.text.trim();
              if (amountStr.isNotEmpty) {
                final amount = double.tryParse(amountStr);
                if (amount != null && amount >= 0) {
                  final currentAmount = ingredient.amount ?? 0;
                  final difference = amount - currentAmount;
                  if (difference > 0) {
                    viewModel.addAmount(ingredient.id, difference);
                  } else if (difference < 0) {
                    viewModel.consumeAmount(ingredient.id, -difference);
                  }
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    IngredientsViewModel viewModel,
    Ingredient ingredient,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить ингредиент?'),
        content: Text(
          'Вы уверены, что хотите удалить "${ingredient.name}" из холодильника?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              viewModel.removeIngredient(ingredient.id);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}
