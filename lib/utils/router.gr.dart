// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ChurchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChurchPage(),
      );
    },
    ContactsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ContactsPage(),
      );
    },
    DonateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DonatePage(),
      );
    },
    GalleryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GalleryPage(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeViewPage(),
      );
    },
    ParticularGalleryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ParticularGalleryRouteArgs>(
          orElse: () => ParticularGalleryRouteArgs(
              galleryName: pathParams.getString('galleryName')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ParticularGalleryPage(
          args.galleryName,
          key: args.key,
        ),
      );
    },
    TimetableRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TimetablePage(),
      );
    },
  };
}

/// generated route for
/// [ChurchPage]
class ChurchRoute extends PageRouteInfo<void> {
  const ChurchRoute({List<PageRouteInfo>? children})
      : super(
          ChurchRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChurchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ContactsPage]
class ContactsRoute extends PageRouteInfo<void> {
  const ContactsRoute({List<PageRouteInfo>? children})
      : super(
          ContactsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DonatePage]
class DonateRoute extends PageRouteInfo<void> {
  const DonateRoute({List<PageRouteInfo>? children})
      : super(
          DonateRoute.name,
          initialChildren: children,
        );

  static const String name = 'DonateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GalleryPage]
class GalleryRoute extends PageRouteInfo<void> {
  const GalleryRoute({List<PageRouteInfo>? children})
      : super(
          GalleryRoute.name,
          initialChildren: children,
        );

  static const String name = 'GalleryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeViewPage]
class HomeViewRoute extends PageRouteInfo<void> {
  const HomeViewRoute({List<PageRouteInfo>? children})
      : super(
          HomeViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ParticularGalleryPage]
class ParticularGalleryRoute extends PageRouteInfo<ParticularGalleryRouteArgs> {
  ParticularGalleryRoute({
    required String galleryName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ParticularGalleryRoute.name,
          args: ParticularGalleryRouteArgs(
            galleryName: galleryName,
            key: key,
          ),
          rawPathParams: {'galleryName': galleryName},
          initialChildren: children,
        );

  static const String name = 'ParticularGalleryRoute';

  static const PageInfo<ParticularGalleryRouteArgs> page =
      PageInfo<ParticularGalleryRouteArgs>(name);
}

class ParticularGalleryRouteArgs {
  const ParticularGalleryRouteArgs({
    required this.galleryName,
    this.key,
  });

  final String galleryName;

  final Key? key;

  @override
  String toString() {
    return 'ParticularGalleryRouteArgs{galleryName: $galleryName, key: $key}';
  }
}

/// generated route for
/// [TimetablePage]
class TimetableRoute extends PageRouteInfo<void> {
  const TimetableRoute({List<PageRouteInfo>? children})
      : super(
          TimetableRoute.name,
          initialChildren: children,
        );

  static const String name = 'TimetableRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
