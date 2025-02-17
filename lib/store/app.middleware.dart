import 'package:friendlywar/repositories/auth_repository.dart';
import 'package:friendlywar/store/friend/friend.action.dart';
import 'package:friendlywar/store/friend/friend.middleware.dart';
import 'package:redux/redux.dart';
import './app.state.dart';

final AuthRepository _authRepository = AuthRepository();

List<Middleware<AppState>> appMiddleware() {
  final Middleware<AppState> friendMiddleware = getFriend(_authRepository);

  return [
    //authentication call action
    TypedMiddleware<AppState, AuthenticationAction>(friendMiddleware).call,

    //matches actions
    TypedMiddleware<AppState, MatchLoadingAction>(friendMiddleware).call,
    TypedMiddleware<AppState, MatchLosingAction>(friendMiddleware).call,

    //users actions
    TypedMiddleware<AppState, UsersListingAction>(friendMiddleware).call,
  ];
}
