// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../stats_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(statsData)
const statsDataProvider = StatsDataProvider._();

final class StatsDataProvider extends $FunctionalProvider<Stats, Stats, Stats>
    with $Provider<Stats> {
  const StatsDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsDataHash();

  @$internal
  @override
  $ProviderElement<Stats> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Stats create(Ref ref) {
    return statsData(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Stats value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Stats>(value),
    );
  }
}

String _$statsDataHash() => r'62719533d5c6c53dd91b17ea23638da5cbd19ce1';
