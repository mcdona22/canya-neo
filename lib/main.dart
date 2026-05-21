import 'package:canya_mobile/features/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import 'common/routing/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );

  logInfo('🚀 Launching Canya');

  logInfo('Create Provider Container');
  final container = ProviderContainer(
    overrides: [
    ],
  );

  runApp(UncontrolledProviderScope(container: container,
      child: App()));

  logInfo('🥳 Canya up and running');

}

class App extends HookConsumerWidget  with UiLoggy {
  const App({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
  return MaterialApp.router(
    routerConfig: routerConfig,
    theme: ThemeData.from(colorScheme: lightColorScheme),
    darkTheme: ThemeData.from(colorScheme: darkColorScheme),
    themeMode: ThemeMode.dark

  );}
}
