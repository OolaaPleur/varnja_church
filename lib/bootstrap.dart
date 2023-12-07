import 'dart:async';
import 'dart:developer';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onClose(BlocBase<dynamic> bloc) {
    log('onClose(${bloc.runtimeType})');
    super.onClose(bloc);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  usePathUrlStrategy();
  /// Logger initialisation.
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log('${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}');
  });

  /// Log errors.
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) => '';
  }
  /// Start BLoC observer.
  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here

  runApp(await builder());
}
