// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clubs_controller.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClubStateCWProxy {
  ClubState clubs(List<ClubData> clubs);

  ClubState isLoading(bool isLoading);

  ClubState loadingClubId(String? loadingClubId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClubState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClubState(...).copyWith(id: 12, name: "My name")
  /// ````
  ClubState call({
    List<ClubData>? clubs,
    bool? isLoading,
    String? loadingClubId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClubState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClubState.copyWith.fieldName(...)`
class _$ClubStateCWProxyImpl implements _$ClubStateCWProxy {
  final ClubState _value;

  const _$ClubStateCWProxyImpl(this._value);

  @override
  ClubState clubs(List<ClubData> clubs) => this(clubs: clubs);

  @override
  ClubState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  ClubState loadingClubId(String? loadingClubId) =>
      this(loadingClubId: loadingClubId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClubState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClubState(...).copyWith(id: 12, name: "My name")
  /// ````
  ClubState call({
    Object? clubs = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? loadingClubId = const $CopyWithPlaceholder(),
  }) {
    return ClubState(
      clubs: clubs == const $CopyWithPlaceholder() || clubs == null
          ? _value.clubs
          // ignore: cast_nullable_to_non_nullable
          : clubs as List<ClubData>,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      loadingClubId: loadingClubId == const $CopyWithPlaceholder()
          ? _value.loadingClubId
          // ignore: cast_nullable_to_non_nullable
          : loadingClubId as String?,
    );
  }
}

extension $ClubStateCopyWith on ClubState {
  /// Returns a callable class that can be used as follows: `instanceOfClubState.copyWith(...)` or like so:`instanceOfClubState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClubStateCWProxy get copyWith => _$ClubStateCWProxyImpl(this);
}
