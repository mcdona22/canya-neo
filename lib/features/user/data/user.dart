import 'package:canya_mobile/common/data/Navigable.dart';
import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User implements Navigable {
  const User._();

  const factory User({
    String? id,
    required String title,
    String? subtitle,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<RelationshipGroup> nodes,
  }) = _User;

  @override
  String get title => this.title;

  @override
  String? get id => this.id;

  @override
  List<RelationshipGroup> get connectedNodes => this.nodes;

  factory User.fromJson(Map<String, Object?> json) =>
      _$UserFromJson(json);
}
