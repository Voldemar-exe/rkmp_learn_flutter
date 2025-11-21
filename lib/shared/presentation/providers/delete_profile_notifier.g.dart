// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_profile_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteProfile)
const deleteProfileProvider = DeleteProfileProvider._();

final class DeleteProfileProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const DeleteProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteProfileHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return deleteProfile(ref);
  }
}

String _$deleteProfileHash() => r'8dfcab2315d45fb8f402a86340c830ef14f791a6';
