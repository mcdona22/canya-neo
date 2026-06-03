import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
abstract class Group with _$Group {
  const Group._();

  const factory Group({String? id, required String name}) =
      _Group;

  factory Group.fromJson(Map<String, Object?> json) =>
      _$GroupFromJson(json);
}
