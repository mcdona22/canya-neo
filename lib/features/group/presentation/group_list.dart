import 'package:canya_mobile/common/async_value_widget.dart';
import 'package:canya_mobile/common/presentation/card_wrapper.dart';
import 'package:canya_mobile/common/routing/router.dart';
import 'package:canya_mobile/features/group/data/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                  // subtitle: Text(groups[i].group.id!),
                  subtitle: Text('Show Details'),
                  title: Text(groups[i].group.name),
                  leading: TextButton(
                    onPressed: () =>
                        _navigate(
                          context,
                          groups[i].group.id ?? 'missing',
                        ),
                    child: Text('Group Detail'),
                  ),
                ),
              ),

          itemCount: groups.length,
        );
      },
    );
  }

  _navigate(BuildContext context, String id) {
    final route = '${AppRoute.group.name}/$id';

    loggy.debug('Path to nav is $route');
    context.pushNamed(
      AppRoute.group.name,
      pathParameters: {'id': id},
    );
  }
}
