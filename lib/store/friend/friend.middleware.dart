import 'package:dio/dio.dart';
import 'package:friendlywar/repositories/auth_repository.dart';
import 'package:friendlywar/store/app.state.dart';
import 'package:friendlywar/store/friend/friend.action.dart';
import 'package:redux/redux.dart';

Middleware<AppState> getFriend(AuthRepository _repo) {
  return (Store<AppState> store, action, NextDispatcher dispatch) async {
    final token = store.state.friendState.token;

    //authentication actions
    if (action is AuthenticationAction) {
      try {
        dispatch(FriendAction());

        //loading datra from the API
        final response =
            await _repo.authenticateUser(action.username, action.password);
        final responseData = response["data"];
        final token = responseData["token"];
        final userName = responseData["user"]["username"];
        dispatch(FriendSuccessAction(token: token, userName: userName));
      } on DioException catch (e) {
        dispatch(FriendFailedAction(error: e.toString()));
      }
      ;
    }

    //matches actions
    if (action is MatchLoadingAction) {
      try {
        dispatch(FriendAction());

        //loading matches from the API
        final response = await _repo.loadMatches(token);
        dispatch(MatchSuccessAction(matches: response));
      } on DioException catch (e) {
        dispatch(FriendFailedAction(error: e.toString()));
      }
    }

    if (action is MatchLosingAction) {
      try {
        dispatch(FriendAction());

        //posting loser to the API
        final response = await _repo.lostMatch(token, action.opponent);
        final List<dynamic> newMatches = store.state.friendState.matches
          ..add(response);
        dispatch(MatchSuccessAction(matches: newMatches));
      } on DioException catch (e) {
        print(e.toString());
        dispatch(FriendFailedAction(error: e.toString()));
      }
    }

    //users actions
    if (action is UsersListingAction) {
      try {
        dispatch(FriendAction());

        //calling the API for users
        final response = await _repo.listUsers(token);
        dispatch(UsersSuccessAction(users: response));
      } on DioException catch (e) {
        dispatch(FriendFailedAction(error: e.toString()));
      }
    }
  };
}
