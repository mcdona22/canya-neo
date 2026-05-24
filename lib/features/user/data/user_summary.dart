import 'package:canya_mobile/common/data/relationship_ref.dart';
import 'package:canya_mobile/features/user/data/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_summary.freezed.dart';
part 'user_summary.g.dart';

@freezed
abstract class UserSummary with _$UserSummary {
  const factory UserSummary({
    required User user,
    required List<RelationshipRef> memberOfGroups,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, Object?> json) =>
      _$UserSummaryFromJson(json);
}
