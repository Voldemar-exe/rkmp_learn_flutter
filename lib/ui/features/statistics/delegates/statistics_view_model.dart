import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/statistics.dart';
import '../../../../data/datasources/local/statistics_data_source.dart';
import 'states/statistics_state.dart';

part 'statistics_view_model.g.dart';

@riverpod
class StatisticsViewModel extends _$StatisticsViewModel {
  late final StatisticsLocalDataSource _repository;

  @override
  Future<StatisticsState> build() async {
    _repository = GetIt.I<StatisticsLocalDataSource>();
    try {
      final data = await _repository.calculateStatisticsForThisWeek();
      return StatisticsState(data: data, isLoading: false, error: null);
    } catch (e) {
      return StatisticsState(error: e.toString());
    }
  }

  Future<void> loadStatistics() async {
    _updateState(isLoading: true, error: null);
    try {
      final data = await _repository.calculateStatisticsForThisWeek();
      _updateState(data: data, isLoading: false);
    } catch (e) {
      _updateState(error: 'Failed to load statistics', isLoading: false);
    }
  }

  void _updateState({Statistics? data, bool? isLoading, String? error}) {
    state = AsyncValue.data(
      state.value!.copyWith(
        data: data ?? state.value!.data,
        isLoading: isLoading ?? state.value!.isLoading,
        error: error,
      ),
    );
  }
}
