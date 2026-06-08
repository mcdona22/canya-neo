import 'package:canya_mobile/common/async_value_widget.dart';
import 'package:canya_mobile/common/presentation/card_wrapper.dart';
import 'package:canya_mobile/common/presentation/centred_constrained_widget.dart';
import 'package:canya_mobile/common/routing/util.dart';
import 'package:canya_mobile/features/group/presentation/group_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class GroupScreen extends HookConsumerWidget with UiLoggy {
  final String groupId;

  const GroupScreen({required this.groupId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupState = ref.watch(
      groupScreenControllerProvider(groupId),
    );
    final appBarTitle =
        groupState.hasValue && groupState.value != null
        ? groupState.value!.title
        : 'Loading Group...';
    return Scaffold(
      appBar: createAppBar(context, appBarTitle),
      body: AsyncValueWidget(
        value: groupState,
        data: (group) {
          final groupInfo = group!;
          final subtitle = groupInfo.subtitle ?? 'Nothing';
          groupInfo.subtitle;

          loggy.debug('The group is $group');
          return CentredConstrainedWidget(
            maxWidth: 400.0,
            minWidth: 200.0,

            child: CardWrapper(
              child: ListTile(
                title: Text(groupInfo.title),
                subtitle: Text(subtitle),
                leading: Icon(Icons.group),
              ),
            ),
          );
        },
      ),
    );
  }
}
