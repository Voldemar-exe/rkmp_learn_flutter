import 'package:rkmp_learn_flutter/features/statistics/data/models/statistics.dart';

class StatisticsState {
  final Statistics? data;
  final bool isLoading;
  final String? error;

  StatisticsState({
    this.data,
    this.isLoading = false,
    this.error,
  });

  StatisticsState copyWith({
    Statistics? data,
    bool? isLoading,
    String? error,
  }) {
    return StatisticsState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}