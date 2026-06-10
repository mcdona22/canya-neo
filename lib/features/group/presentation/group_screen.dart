import 'package:canya_mobile/common/async_value_widget.dart';
import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:canya_mobile/common/presentation/card_wrapper.dart';
import 'package:canya_mobile/common/presentation/centred_constrained_widget.dart';
import 'package:canya_mobile/common/presentation/navigable_list.dart';
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
    final textTheme = Theme.of(context).textTheme;
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

          final List<RelationshipGroup> names =
              group.connectedNodes;
          loggy.debug('relationships: ${names.length}');
          final members = names.first;
          // final nameList = members.nodes.map((member) =>
          // member.title)
          //     .toList().join(', ');
          loggy.debug('The members: ${members.nodes}');

          loggy.debug('The group is $group');
          child:
          return Column(
            children: [
              SizedBox(
                height: 200.0,
                child: CentredConstrainedWidget(
                  maxWidth: 400.0,
                  minWidth: 200.0,

                  child: CardWrapper(
                    child: ListTile(
                      title: Text(groupInfo.title),
                      subtitle: Text(subtitle),
                      leading: Icon(Icons.group),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView(
                    children: [
                      Text(
                        'Members',
                        style: textTheme.titleLarge,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 300.0,
                            minWidth: 150.0,
                          ),
                          child: NavigableList(
                            items: members.nodes,
                          ),
                        ),
                      ),
                      const Divider(height: 32.0),
                      // NavigableList(items: members.nodes),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
