import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/recipe.dart';
import '../delegates/recipes_view_model.dart';

class RecipesScreen extends ConsumerStatefulWidget {
  const RecipesScreen({super.key});

  @override
  ConsumerState<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends ConsumerState<RecipesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(recipesViewModelProvider);
    final viewModel = ref.read(recipesViewModelProvider.notifier);

    if (asyncState.isLoading && asyncState.value == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (asyncState.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Рецепты')),
        body: Center(child: Text(asyncState.error.toString())),
      );
    }

    final state = asyncState.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепты'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel.loadUserRecipes,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Мои'),
            Tab(text: 'База'),
          ],
          onTap: (index) {
            viewModel.resetSearchResults();
            _searchController.clear();
          },
        ),
      ),
      body: Column(
        children: [
          if (state!.randomRecipe != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Случайный рецепт',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        title: Text(
                          state.randomRecipe!.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          '${state.randomRecipe!.category} - ${state.randomRecipe!.area}',
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            state.randomRecipe!.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported_outlined),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          viewModel.selectRecipe(state.randomRecipe!);
                          context.push('/home/recipes/recipe_details');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Ищем рецепты...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      if (_tabController.index == 0) {
                        viewModel.searchUserRecipes(value);
                      } else {
                        viewModel.searchRecipes(value);
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_tabController.index == 0) {
                      viewModel.searchUserRecipes(_searchController.text);
                    } else {
                      viewModel.searchRecipes(_searchController.text);
                    }
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRecipeList(
                  state.searchResults.isEmpty
                      ? state.userRecipes
                      : state.searchResults,
                  viewModel,
                  context,
                ),
                _buildRecipeList(
                  state.searchResults.isEmpty ? [] : state.searchResults,
                  viewModel,
                  context,
                  isApiSearch: true,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: viewModel.loadRandomRecipe,
            child: const Icon(Icons.shuffle),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeList(
    List<Recipe> recipes,
    RecipesViewModel viewModel,
    BuildContext context, {
    bool isApiSearch = false,
  }) {
    if (ref.read(recipesViewModelProvider).isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recipes.isEmpty) {
      return const Center(child: Text('Рецепты не найдены'));
    }

    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Card(
          child: ListTile(
            title: Text(recipe.name),
            subtitle: Text('${recipe.category} - ${recipe.area}'),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                recipe.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported_outlined),
              ),
            ),
            trailing: isApiSearch
                ? IconButton(
              icon: const Icon(Icons.bookmark_add_outlined),
              onPressed: () => viewModel.saveRecipe(recipe),
            )
                : IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Theme.of(context).colorScheme.error,
              onPressed: () => viewModel.removeRecipe(recipe.id),
            ),
            onTap: () {
              viewModel.selectRecipe(recipe);
              // _searchController.dispose();
              context.push('/home/recipes/recipe_details');
            },
          ),
        );
      },
    );
  }
}
