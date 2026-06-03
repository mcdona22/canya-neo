import 'package:canya_mobile/common/async_value_widget.dart';
import 'package:canya_mobile/common/presentation/card_wrapper.dart';
import 'package:canya_mobile/features/group/data/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class GroupList extends HookConsumerWidget with UiLoggy {
  const GroupList({super.key});

  // final List<GroupSummary> groups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    loggy.debug('Listing the groups');
    final allGroups = ref.watch(allGroupsProvider);
    return AsyncValueWidget(
      value: allGroups,
      data: (groups) {
        return ListView.builder(
          itemBuilder: (_, i) =>
              CardWrapper(
                child: ListTile(
                  subtitle: Text(groups[i].group.id!),
                  title: Text(groups[i].group.name),
                ),
              ),

          itemCount: groups.length,
        );
      },
    );
  }
}
