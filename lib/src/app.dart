import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thoughtx/src/navigation/navigation_page.dart';

import 'settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

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
          home: const AppBackground(
            child: NavigationPage(),
          ),
        );
      },
    );
  }
}

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/background.svg',
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 20,
              right: 50,
              left: 50,
              child: Container(
                width: 50,
                height: 81,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 20),
                        spreadRadius: 10,
                        color: Colors.teal,
                        blurRadius: MediaQuery.sizeOf(context).width * 0.4)
                  ],
                ),
              )),
          Positioned(
              bottom: 0,
              right: 50,
              left: 50,
              child: Container(
                width: 50,
                height: 81,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 20),
                        spreadRadius: 2,
                        color: Colors.teal,
                        blurRadius: MediaQuery.sizeOf(context).width * 0.7)
                  ],
                ),
              )),
          child
        ],
      ),
    );
  }
}
