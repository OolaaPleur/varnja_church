import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:varnja_church/utils/router.dart';

import '../screens/home/home.dart';
import '../screens/pages/contacts/contacts_page.dart';
import '../screens/settings/language_cubit/language_cubit.dart';
import '../theme/bloc/theme_bloc.dart';

/// Entry widget of the app.
class App extends StatefulWidget {
  /// Entry widget constructor.
  const App({super.key, this.locale});

  /// Set locale, used for TEST ONLY.
  final Locale? locale;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc()
            ..add(
              LoadThemeEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => PostsCubit()
            ..fetchSchedule()
            ..fetchGalleries(),
          lazy: false,
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, theme) {
          return MaterialApp.router(
            routerConfig: _appRouter.config(),
            locale: widget.locale ?? context.watch<LanguageCubit>().state,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              return supportedLocales.contains(deviceLocale)
                  ? deviceLocale
                  : supportedLocales.first;
            },
            theme: theme.themeData,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
          );
        },
      ),
    );
  }
}
