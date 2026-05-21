import 'package:flutter/material.dart';

PreferredSizeWidget createAppBar(
  BuildContext context,
  String title,
) {
  return AppBar(
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    toolbarHeight: 120.0,
    centerTitle: true,
    elevation: 1.0,
    // primary: true,
    backgroundColor: Theme.of(
      context,
    ).colorScheme.inversePrimary,
    actions: [],
  );
}
