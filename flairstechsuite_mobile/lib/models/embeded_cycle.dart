import 'package:json_annotation/json_annotation.dart';

part 'embeded_cycle.g.dart';

@JsonSerializable()
class EmbededCycle {
  String? id;
  String? name;
  String? from;
  String? to;

  EmbededCycle({
    this.id,
    this.name,
    this.from,
    this.to,
  });


  factory EmbededCycle.fromJson(Map<String, dynamic> json) => _$EmbededCycleFromJson(json);

  Map<String, dynamic> toJson() => _$EmbededCycleToJson(this);


}
