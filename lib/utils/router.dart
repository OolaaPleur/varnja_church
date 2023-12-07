import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:varnja_church/screens/pages/gallery/particular_gallery_page.dart';

import '../screens/home/home.dart';
import '../screens/pages/contacts/contacts_page.dart';
import '../screens/pages/church/church_page.dart';
import '../screens/pages/donate/donate_page.dart';
import '../screens/pages/gallery/gallery_page.dart';
import '../screens/pages/timetable/timetable_page.dart';
part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeViewRoute.page,
      initial: true,
      children: [
        AutoRoute(page: ContactsRoute.page, path: 'contacts'),
        AutoRoute(page: ChurchRoute.page, path: 'church'),
        AutoRoute(page: TimetableRoute.page, path: 'timetable'),
        AutoRoute(page: GalleryRoute.page, path: 'gallery/', children: [
          CustomRoute(page: ParticularGalleryRoute.page, path: ':galleryName', transitionsBuilder: TransitionsBuilders.noTransition),
        ]),
        AutoRoute(page: DonateRoute.page, path: 'donate'),
      ],
    ),
  ];
}
