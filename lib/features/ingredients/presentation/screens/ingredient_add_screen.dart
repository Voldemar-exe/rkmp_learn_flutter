import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/models/ingredient.dart';
import 'package:rkmp_learn_flutter/features/ingredients/presentation/store/ingredients_view_model.dart';

class IngredientAddScreen extends ConsumerStatefulWidget {
  const IngredientAddScreen({super.key});

  @override
  ConsumerState<IngredientAddScreen> createState() => _IngredientsAddScreenState();
}

class _IngredientsAddScreenState extends ConsumerState<IngredientAddScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(ingredientsViewModelProvider.notifier).loadAvailableIngredients();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(ingredientsViewModelProvider);
    final viewModel = ref.read(ingredientsViewModelProvider.notifier);

    if (asyncState.isLoading && asyncState.value == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final state = asyncState.value!;
    if (state.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Добавить ингредиент')),
        body: Center(child: Text('Error: ${state.error}')),
      );
    }

    final List<Ingredient> displayedList = _searchController.text.isEmpty
        ? state.availableIngredients
        : state.searchResults;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить ингредиент'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Поиск ингредиентов...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.searchAvailableIngredients(value),
            ),
          ),
          if (asyncState.isLoading && _searchController.text.isNotEmpty)
            const LinearProgressIndicator(),
          Expanded(
            child: displayedList.isEmpty
                ? const Center(child: Text('Ингредиенты не найдены'))
                : ListView.builder(
              itemCount: displayedList.length,
              itemBuilder: (context, index) {
                final ingredient = displayedList[index];
                return Card(
                  child: ListTile(
                    title: Text(ingredient.name),
                    subtitle: Text(ingredient.measureUnit ?? ''),
                    trailing: const Icon(Icons.add),
                    onTap: () => _showAddAmountDialog(context, viewModel, ingredient),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddAmountDialog(
      BuildContext context,
      IngredientsViewModel viewModel,
      Ingredient ingredient,
      ) {
    _amountController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Сколько добавить? (${ingredient.name} ${ingredient.measureUnit})'),
        content: TextField(
          controller: _amountController,
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
              final amountStr = _amountController.text.trim();
              if (amountStr.isNotEmpty) {
                final amount = double.tryParse(amountStr);
                if (amount != null && amount > 0) {
                  final ingredientToAdd = ingredient.copyWith(amount: amount);
                  viewModel.addOrUpdateIngredient(ingredientToAdd);
                  Navigator.of(context).pop();
                  context.pop();
                }
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}