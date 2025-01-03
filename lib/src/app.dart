import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thoughtx/src/home/home.dart';
import 'package:thoughtx/src/home/home_contoller.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.settingsController,
      required this.homeController});

  final SettingsController settingsController;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],

          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.teal, brightness: Brightness.dark)),
          // theme: ThemeData.from(
          //     colorScheme: ColorScheme.fromSeed(
          //         seedColor: Colors.teal, brightness: Brightness.dark)),
          // darkTheme: ThemeData.from(
          //     colorScheme: ColorScheme.fromSeed(
          //         seedColor: Colors.teal, brightness: Brightness.dark)),
          // themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);

                  default:
                    return HomePage(
                      homeController: homeController,
                    );
                }
              },
            );
          },
        );
      },
    );
  }
}
