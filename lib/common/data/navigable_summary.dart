import 'package:canya_mobile/common/data/Navigable.dart';
import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigable_summary.freezed.dart';

part 'navigable_summary.g.dart';

@freezed
abstract class NavigableSummary
    with _$NavigableSummary
    implements Navigable {
  const NavigableSummary._();

  const factory NavigableSummary({
    String? id,
    required String title,
    String? subtitle,
  }) = _NavigableSummary;


  factory NavigableSummary.fromJson(
      Map<String, Object?> json,) =>
      _$NavigableSummaryFromJson(json);

  @override
  List<RelationshipGroup> get connectedNodes => [];
}
