import 'package:canya_mobile/common/async_value_widget.dart';
import 'package:canya_mobile/common/presentation/ui_dimensions.dart';
import 'package:canya_mobile/common/routing/util.dart';
import 'package:canya_mobile/features/group/presentation/group_screen.dart';
import 'package:canya_mobile/features/user/data/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class UserListScreen extends HookConsumerWidget
    with UiLoggy {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(allUsersProvider);

    return Scaffold(
      appBar: createAppBar(context, 'Users'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingMedium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100.0,

                child: Text(
                  'App Users',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge,
                ),
              ),
              AsyncValueWidget(
                value: users,
                data: (users) => Wrap(
                  spacing: paddingMedium,
                  runSpacing: paddingMedium,
                  alignment: WrapAlignment.center,
                  children: users
                      .map(
                        (user) =>
                            NavSummaryChip(summary: user),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
