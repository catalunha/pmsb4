import 'package:pmsb4/middlewares/auth_middleware.dart';
import 'package:pmsb4/redux/app_reducer.dart';
import 'package:pmsb4/redux/app_state.dart';
import 'package:redux/redux.dart';
// import 'package:redux_logging/redux_logging.dart';

Store<AppState> appStore = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: createAuthMiddleware(),
  // middleware: []..addAll(createAuthMiddleware())..addAll(LoggingMiddleware.printer()),
);
