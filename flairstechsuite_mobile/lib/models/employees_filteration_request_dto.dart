import 'package:json_annotation/json_annotation.dart';

part 'employees_filteration_request_dto.g.dart';

@JsonSerializable()
class EmployeesFilterationRequestDTO{
  List<String>? searchQueries;

  EmployeesFilterationRequestDTO({
    this.searchQueries,
  });


  factory EmployeesFilterationRequestDTO.fromJson(Map<String, dynamic> json) => _$EmployeesFilterationRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeesFilterationRequestDTOToJson(this);


}
