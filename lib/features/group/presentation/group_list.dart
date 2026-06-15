import 'package:canya_mobile/common/async_value_widget.dart';
import 'package:canya_mobile/common/presentation/card_wrapper.dart';
import 'package:canya_mobile/common/routing/router.dart';
import 'package:canya_mobile/features/group/data/group.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import '../data/group_repo.dart';

class GroupList extends HookConsumerWidget with UiLoggy {
  const GroupList({super.key});

  // final List<GroupSummary> groups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    loggy.debug('Listing the groups');
    final AsyncValue<List<Group>> allGroups = ref.watch(
      allGroupsProvider,
    );
    return AsyncValueWidget(
      value: allGroups,
      data: (groups) {
        return ListView.builder(
          itemBuilder: (_, i) =>
              CardWrapper(
                child: ListTile(
                  // subtitle: Text(groups[i].group.id!),
                  subtitle: Text(
                    groups[i].subtitle ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                  title: Text(
                    groups[i].title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: TextButton(
                    onPressed: () =>
                        _navigate(
                          context,
                          groups[i].id ?? 'missing',
                        ),
                    child: Icon(
                        Icons.arrow_right, size: 40.0),
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
