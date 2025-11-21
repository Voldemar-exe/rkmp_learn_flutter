import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/delete_profile_use_case.dart';

part 'delete_profile_notifier.g.dart';

@riverpod
Future<void> deleteProfile(Ref ref) async {
  final useCase = GetIt.I<DeleteProfileUseCase>();
  await useCase.call();
}

