import 'package:freezed_annotation/freezed_annotation.dart';

part 'relationship_ref.freezed.dart';

part 'relationship_ref.g.dart';

@freezed
abstract class RelationshipRef with _$RelationshipRef {
  const factory RelationshipRef({
    required String id, // 👈 Used directly for Flutter navigation routing keys
    required String label, // 👈 The human-readable string (computed or raw name/title)
  }) = _RelationshipRef;

  factory RelationshipRef.fromJson(
      Map<String, Object?> json) =>
      _$RelationshipRefFromJson(json);
}