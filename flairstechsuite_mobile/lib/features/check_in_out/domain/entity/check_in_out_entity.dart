import 'package:equatable/equatable.dart';

class CheckInOutEntity extends Equatable {
  final String? id;
  final double? longitude;
  final double? latitude;
  final int? checkType;
  final String? employeeId;
  final DateTime? creationDate;
  final DateTime? modificationDate;
  final int? placeType;
  final String? placeId;
  final String? placeName;
  final bool? isAutomatic;
  final bool? isForgotten;

  const CheckInOutEntity({
    this.id,
    this.longitude,
    this.latitude,
    this.checkType,
    this.employeeId,
    this.creationDate,
    this.modificationDate,
    this.placeType,
    this.placeId,
    this.placeName,
    this.isAutomatic,
    this.isForgotten,
  });

  @override
  List<Object?> get props => [
        id,
        longitude,
        latitude,
        checkType,
        employeeId,
        creationDate,
        modificationDate,
        placeType,
        placeId,
        placeName,
        isAutomatic,
        isForgotten,
      ];
}
