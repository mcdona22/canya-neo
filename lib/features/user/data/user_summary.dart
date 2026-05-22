import 'package:canya_mobile/features/user/data/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_summary.freezed.dart';
part 'user_summary.g.dart';

@freezed
abstract class UserSummary with _$UserSummary {
  const factory UserSummary({
    required User
    user, // 👈 Composition: Core domain model remains completely untouched
    required int
    groupCount, // 👈 Ephemeral dashboard-specific metadata
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, Object?> json) =>
      _$UserSummaryFromJson(json);
}
