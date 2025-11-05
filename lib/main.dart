import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_size/window_size.dart';

import 'app_router.dart';
import 'theme.dart';

/// Boots the Digital Lemonade Stand app and enforces the desktop window floor.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const Size minimumWindowSize = Size(800, 600);

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.macOS) {
    setWindowMinSize(minimumWindowSize);
  }

  runApp(const ProviderScope(child: MainApp()));
}

/// Root widget that wires Riverpod and the global router into MaterialApp.
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      routerConfig: router,
    );
  }
}
