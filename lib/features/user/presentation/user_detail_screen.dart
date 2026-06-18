import 'package:canya_mobile/common/async_value_widget.dart';
import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:canya_mobile/common/routing/util.dart';
import 'package:canya_mobile/features/user/data/user.dart';
import 'package:canya_mobile/features/user/presentation/user_detail_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class UserDetailScreen extends HookConsumerWidget
    with UiLoggy {
  final String id;
  final relationships = const [RelationshipType.memberOf];

  const UserDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(
      userDetailScreenControllerProvider(
        id,
        relations: relationships,
      ),
    );

    return Scaffold(
      appBar: createAppBar(
        context,
        userState.value != null
            ? userState.value!.displayName
            : 'Loading  User',
      ),
      body: AsyncValueWidget(
        value: userState,
        data: (User? user) {
          if (user == null)
            return Center(
              child: Text('User with id $id not found'),
            );
          loggy.debug('In the screen the state is $user');
          return _UserWidget(user: user);
        },
      ),
    );
  }
}

class _UserWidget extends StatelessWidget with UiLoggy {
  final User user;

  const _UserWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;

    return SizedBox(
      width: double.infinity,
      // color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12.0,
        children: [
          Text(
            user.displayName,
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium!.copyWith(
              letterSpacing: 4.0,
            ),
          ),
          Text(user.title, style: textTheme.headlineSmall),
        ],
      ),
    );
  }
}
