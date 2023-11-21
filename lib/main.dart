import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_view_model_example/modules/counter/counter_screen.dart';
import 'package:riverpod_view_model_example/global/dark_mode_controller.dart';
import 'package:riverpod_view_model_example/service_locator.dart';

void main() {
  App.registerSingletons();
  runApp(const MyApp());
}
final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB(244, 24, 145, 172), // Primary color for the app
   
    secondary: Colors.amber, // Secondary color for the app
    
    surface: Colors.white, // Background color for cards, dialogs, etc.
    background: Color.fromARGB(255, 255, 255, 255), // Background color for the app's scaffold
    error: Colors.red, // Color to use for input validation errors, etc.
    onPrimary: Colors.white, // Text color for components on primary color
    onSecondary: Colors.black, // Text color for components on secondary color
    onSurface: Colors.black, // Text color for components on surface color
    onBackground: Colors.black, // Text color for components on background color
    onError: Colors.white, // Text color for components on error color
    brightness: Brightness.light, // Overall theme brightness (light)
  ),
  // Other theme properties...
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final isDarkMode = ref.watch(DarkModeController.provider);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Sit to Stand',
            theme: isDarkMode
                ? ThemeData(brightness: Brightness.dark)
                : lightTheme,
            routeInformationParser: App.router.goRouter.routeInformationParser,
            routerDelegate: App.router.goRouter.routerDelegate,
            routeInformationProvider:
                App.router.goRouter.routeInformationProvider,
          );
        },
      ),
    );
  }
}
