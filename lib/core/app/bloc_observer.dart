import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesba_ai/core/helpers/app_logger.dart';

/// Bloc lifecycle events reported through the shared app logger, so the
/// whole state timeline is visible under the one `nesba` log name.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    appLog('onCreate -- ${bloc.runtimeType}', level: AppLogLevel.trace);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    appLog('onEvent -- ${bloc.runtimeType}', level: AppLogLevel.trace);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    appLog('onChange -- ${bloc.runtimeType}', level: AppLogLevel.trace);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLogger.error(
      'onError -- ${bloc.runtimeType}',
      error,
      stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    appLog('onClose -- ${bloc.runtimeType}', level: AppLogLevel.trace);
  }
}
