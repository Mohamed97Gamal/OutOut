import 'package:json_annotation/json_annotation.dart';

part 'file_dto.g.dart';

@JsonSerializable()
class FilerResponse {
  String? file;
  String? fileName;

  FilerResponse({
    this.file,
    this.fileName,
  });

  factory FilerResponse.fromJson(Map<String, dynamic> json) => _$FilerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilerResponseToJson(this);
}
