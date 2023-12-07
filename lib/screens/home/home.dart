export 'cubit/posts_cubit.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varnja_church/constants/constants.dart';
import 'package:varnja_church/l10n/l10n.dart';
import 'package:varnja_church/screens/home/widgets/language_dropdown.dart';
import 'package:varnja_church/theme/bloc/theme_bloc.dart';

import '../../utils/router.dart';
import '../pages/contacts/contacts_page.dart';
import '../pages/church/church_page.dart';
import 'cubit/posts_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeViewPage();
  }
}

@RoutePage()
class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  MaterialStateProperty<Icon?> _customThumbIcon(bool isDarkMode) {
    return MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        // Icon when the switch is on
        return Icon(Icons.nights_stay);
      } else {
        // Icon when the switch is off
        return Icon(Icons.wb_sunny);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SelectionArea(
      child: AutoTabsRouter(
        routes: [
          ChurchRoute(),
          TimetableRoute(),
          GalleryRoute(),
          ContactsRoute(),
          //ParticularGalleryRoute(),
          DonateRoute(),
        ],
        builder: (context, child) {
          final tabsRouter =
              AutoTabsRouter.of(context); // <--- configure the AutoTabsRouter parameter

          return Scaffold(
            body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            context.l10n.homeAppBarTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CategoryButton(tabsRouter: tabsRouter, title: 'Home', index: 0),
                            CategoryButton(tabsRouter: tabsRouter, title: 'Timetable', index: 1),
                            CategoryButton(tabsRouter: tabsRouter, title: 'Gallery', index: 2),
                            CategoryButton(tabsRouter: tabsRouter, title: 'Contacts', index: 3),
                            ElevatedButton(
                              onPressed: () => tabsRouter.setActiveIndex(5),
                              child: Text(
                                'Donate',
                                style: TextStyle(color: Colors.black),
                              ),
                              style:
                                  ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent[100]),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Center(
                                    // Center the dropdown within the Expanded space
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: 200), // Set your desired maximum width
                                      child: LanguageDropdown(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Switch(
                                    thumbIcon: _customThumbIcon(context.read<ThemeBloc>().isDarkMode),
                                    value: context.read<ThemeBloc>().isDarkMode,
                                    onChanged: (bool value) {
                                      context.read<ThemeBloc>().add(
                                            ChangeThemeEvent(
                                                appTheme: value ? AppTheme.dark : AppTheme.light),
                                          );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ))
                      // Add more buttons as needed
                    ],
                  ),
                  Expanded(
                    child: child,
                  ),
                  Text('Varnja church - 2023')
                ],
              ),
          );
        },
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.tabsRouter,
    required this.title,
    required this.index,
  });

  final TabsRouter tabsRouter;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => tabsRouter.setActiveIndex(index),
      child: Text(title),
      style: TextButton.styleFrom(
        side: tabsRouter.activeIndex == index ? BorderSide(width: 2, color: Colors.white) : null,
      ),
    );
  }
}


// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Expanded(flex: 5, child: Container()),
//     Expanded(
//       flex: 8,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text(context.l10n.homeAppBarTitle,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize)),
//       ),
//     ),
//     Expanded(
//       flex: 4,
//       child: Center(
//         // Center the dropdown within the Expanded space
//         child: ConstrainedBox(
//           constraints:
//               BoxConstraints(maxWidth: 200), // Set your desired maximum width
//           child: LanguageDropdown(),
//         ),
//       ),
//     ),
//     Expanded(
//       flex: 1,
//       child: Switch(
//         thumbIcon: _customThumbIcon(context.read<ThemeBloc>().isDarkMode),
//         value: context.read<ThemeBloc>().isDarkMode,
//         onChanged: (bool value) {
//           context.read<ThemeBloc>().add(
//                 ChangeThemeEvent(appTheme: value ? AppTheme.dark : AppTheme.light),
//               );
//         },
//       ),
//     ),
//   ],
// ),