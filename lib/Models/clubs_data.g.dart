// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clubs_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClubDataCWProxy {
  ClubData addressDetails(String addressDetails);

  ClubData clubName(String clubName);

  ClubData clubPath(String clubPath);

  ClubData fetchedSchedules(
      Map<String, List<CourtScheduleData>> fetchedSchedules);

  ClubData street(String street);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClubData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClubData(...).copyWith(id: 12, name: "My name")
  /// ````
  ClubData call({
    String? addressDetails,
    String? clubName,
    String? clubPath,
    Map<String, List<CourtScheduleData>>? fetchedSchedules,
    String? street,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClubData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClubData.copyWith.fieldName(...)`
class _$ClubDataCWProxyImpl implements _$ClubDataCWProxy {
  final ClubData _value;

  const _$ClubDataCWProxyImpl(this._value);

  @override
  ClubData addressDetails(String addressDetails) =>
      this(addressDetails: addressDetails);

  @override
  ClubData clubName(String clubName) => this(clubName: clubName);

  @override
  ClubData clubPath(String clubPath) => this(clubPath: clubPath);

  @override
  ClubData fetchedSchedules(
          Map<String, List<CourtScheduleData>> fetchedSchedules) =>
      this(fetchedSchedules: fetchedSchedules);

  @override
  ClubData street(String street) => this(street: street);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClubData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClubData(...).copyWith(id: 12, name: "My name")
  /// ````
  ClubData call({
    Object? addressDetails = const $CopyWithPlaceholder(),
    Object? clubName = const $CopyWithPlaceholder(),
    Object? clubPath = const $CopyWithPlaceholder(),
    Object? fetchedSchedules = const $CopyWithPlaceholder(),
    Object? street = const $CopyWithPlaceholder(),
  }) {
    return ClubData(
      addressDetails: addressDetails == const $CopyWithPlaceholder() ||
              addressDetails == null
          ? _value.addressDetails
          // ignore: cast_nullable_to_non_nullable
          : addressDetails as String,
      clubName: clubName == const $CopyWithPlaceholder() || clubName == null
          ? _value.clubName
          // ignore: cast_nullable_to_non_nullable
          : clubName as String,
      clubPath: clubPath == const $CopyWithPlaceholder() || clubPath == null
          ? _value.clubPath
          // ignore: cast_nullable_to_non_nullable
          : clubPath as String,
      fetchedSchedules: fetchedSchedules == const $CopyWithPlaceholder() ||
              fetchedSchedules == null
          ? _value.fetchedSchedules
          // ignore: cast_nullable_to_non_nullable
          : fetchedSchedules as Map<String, List<CourtScheduleData>>,
      street: street == const $CopyWithPlaceholder() || street == null
          ? _value.street
          // ignore: cast_nullable_to_non_nullable
          : street as String,
    );
  }
}

extension $ClubDataCopyWith on ClubData {
  /// Returns a callable class that can be used as follows: `instanceOfClubData.copyWith(...)` or like so:`instanceOfClubData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClubDataCWProxy get copyWith => _$ClubDataCWProxyImpl(this);
}
