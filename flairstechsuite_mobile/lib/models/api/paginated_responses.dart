import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/leave_request_dto.dart';
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_sliver_list_view.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_responses.g.dart';

@JsonSerializable()
class BasePaginatedResponseWrapper extends BaseAPIResponse {
  final PaginatedLocationRequestDTOList? result;

  const BasePaginatedResponseWrapper({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory BasePaginatedResponseWrapper.fromJson(Map<String, dynamic> json) => _$BasePaginatedResponseWrapperFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BasePaginatedResponseWrapperToJson(this);
}

@JsonSerializable()
class BasePaginatedResponse {
  final int? pageNumber;
  final int? pageSize;
  final int? pagesTotalCount;
  final int? recordsTotalCount;
  final bool? hasNext;
  final bool? hasPrevious;

  const BasePaginatedResponse({
    this.pageNumber,
    this.pageSize,
    this.pagesTotalCount,
    this.recordsTotalCount,
    this.hasNext,
    this.hasPrevious,
  });

  factory BasePaginatedResponse.fromJson(Map<String, dynamic> json) => _$BasePaginatedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasePaginatedResponseToJson(this);
}

@JsonSerializable()
class LeaveRequestDTOPageDTO extends BasePaginatedResponse {
  final List<LeaveRequestDTO>? records;

  const LeaveRequestDTOPageDTO({
    int? pagesTotalCount,
    int? pageNumber,
    int? pageSize,
    bool? hasNext,
    bool? hasPrevious,
    int? recordsTotalCount,
    this.records,
  }) : super(
          pagesTotalCount: pagesTotalCount,
          pageNumber: pageNumber,
          hasNext: hasNext,
          hasPrevious: hasPrevious,
          pageSize: pageSize,
          recordsTotalCount: recordsTotalCount,
        );

  PagedList<LeaveRequestDTO> toPagedList() {
    return new PagedList<LeaveRequestDTO>()
      ..pageSize = pageSize
      ..pageNumber = pageNumber
      ..hasNext = hasNext
      ..hasPrevious = hasPrevious
      ..recordsTotalCount = recordsTotalCount
      ..totalPages = pagesTotalCount
      ..records = records;
  }

  factory LeaveRequestDTOPageDTO.fromJson(Map<String, dynamic> json) => _$LeaveRequestDTOPageDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LeaveRequestDTOPageDTOToJson(this);
}

@JsonSerializable()
class EmployeeMinimizedDTOPageDTO extends BasePaginatedResponse {
  final List<EmployeeProfileDTO>? records;

  const EmployeeMinimizedDTOPageDTO({
    int? pagesTotalCount,
    int? pageNumber,
    int? pageSize,
    bool? hasNext,
    bool? hasPrevious,
    int? recordsTotalCount,
    this.records,
  }) : super(
    pagesTotalCount: pagesTotalCount,
    pageNumber: pageNumber,
    hasNext: hasNext,
    hasPrevious: hasPrevious,
    pageSize: pageSize,
    recordsTotalCount: recordsTotalCount,
  );

  PagedList<EmployeeProfileDTO> toPagedList() {
    return new PagedList<EmployeeProfileDTO>()
      ..pageSize = pageSize
      ..pageNumber = pageNumber
      ..hasNext = hasNext
      ..hasPrevious = hasPrevious
      ..recordsTotalCount = recordsTotalCount
      ..totalPages = pagesTotalCount
      ..records = records;
  }

  factory EmployeeMinimizedDTOPageDTO.fromJson(Map<String, dynamic> json) => _$EmployeeMinimizedDTOPageDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmployeeMinimizedDTOPageDTOToJson(this);
}


@JsonSerializable()
class PaginatedLocationDTOList extends BasePaginatedResponse {
  final List<LocationDTO>? records;

  const PaginatedLocationDTOList({
    int? pagesTotalCount,
    int? pageNumber,
    int? pageSize,
    int? recordsTotalCount,
    this.records,
  }) : super(
          pagesTotalCount: pagesTotalCount,
          pageNumber: pageNumber,
          pageSize: pageSize,
          recordsTotalCount: recordsTotalCount,
        );

  factory PaginatedLocationDTOList.fromJson(Map<String, dynamic> json) => _$PaginatedLocationDTOListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaginatedLocationDTOListToJson(this);
}

@JsonSerializable()
class PaginatedLocationRequestDTOList extends BasePaginatedResponse {
  final List<LocationRequestDTO>? records;

  const PaginatedLocationRequestDTOList({
    int? pagesTotalCount,
    int? pageNumber,
    int? pageSize,
    int? recordsTotalCount,
    this.records,
  }) : super(
          pagesTotalCount: pagesTotalCount,
          pageNumber: pageNumber,
          pageSize: pageSize,
          recordsTotalCount: recordsTotalCount,
        );

  factory PaginatedLocationRequestDTOList.fromJson(Map<String, dynamic> json) => _$PaginatedLocationRequestDTOListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaginatedLocationRequestDTOListToJson(this);
}

@JsonSerializable()
class PaginatedAnnouncementDTOList extends BasePaginatedResponse {
  final List<AnnouncementDTO>? records;

  const PaginatedAnnouncementDTOList({
    int? pagesTotalCount,
    int? pageNumber,
    int? pageSize,
    int? recordsTotalCount,
    this.records,
  }) : super(
          pagesTotalCount: pagesTotalCount,
          pageNumber: pageNumber,
          pageSize: pageSize,
          recordsTotalCount: recordsTotalCount,
        );

  factory PaginatedAnnouncementDTOList.fromJson(Map<String, dynamic> json) => _$PaginatedAnnouncementDTOListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaginatedAnnouncementDTOListToJson(this);
}
