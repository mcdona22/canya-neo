import 'package:canya_mobile/common/data/relationship_ref.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'group.dart';

part 'group_summary.freezed.dart';

part 'group_summary.g.dart';

@freezed
abstract class GroupSummary with _$GroupSummary {

  const factory GroupSummary ({
    required Group group,
    required List<RelationshipRef> groupUsers
  }) = _GroupSummary;

  factory GroupSummary.fromJson(Map<String, Object?>
  json) => _$GroupSummaryFromJson(json);
}