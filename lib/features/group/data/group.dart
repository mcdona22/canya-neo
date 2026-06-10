import 'package:canya_mobile/common/data/navigable.dart';
import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';

part 'group.g.dart';

@freezed
abstract class Group with _$Group implements Navigable {
  const Group._();

  const factory Group({
    String? id,
    required String title,
    String? subtitle,
    @JsonKey(includeFromJson: false,
        includeToJson: false) @Default([]) List<
        RelationshipGroup> nodes,
  }) = _Group;

  @override
  String get title => this.title;

  @override
  String? get id => this.id;

  @override
  List<RelationshipGroup> get connectedNodes => this.nodes;

  factory Group.fromJson(Map<String, Object?> json) =>
      _$GroupFromJson(json);
}
