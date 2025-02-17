import 'package:friendlywar/store/friend/friend.action.dart';
import 'package:redux/redux.dart';
import './friend.state.dart';

final friendReducer = combineReducers<FriendState>([
  TypedReducer<FriendState, FriendAction>(_startFriendAction).call,
  TypedReducer<FriendState, FriendSuccessAction>(_successfullAction).call,
  TypedReducer<FriendState, MatchSuccessAction>(_matchSuccessAction).call,
  TypedReducer<FriendState, UsersSuccessAction>(_usersSuccessAction).call,
  TypedReducer<FriendState, FriendFailedAction>(_failedAction).call,
]);

//reducer functions
FriendState _startFriendAction(FriendState state, FriendAction action) {
  return state.copyWith(loading: true);
}

FriendState _successfullAction(FriendState state, FriendSuccessAction action) {
  return state.copyWith(
      loading: false, token: action.token, userName: action.userName);
}

FriendState _matchSuccessAction(FriendState state, MatchSuccessAction action) {
  return state.copyWith(loading: false, matches: action.matches);
}

FriendState _failedAction(FriendState state, FriendFailedAction action) {
  return state.copyWith(loading: false, error: action.error);
}

FriendState _usersSuccessAction(FriendState state, UsersSuccessAction action) {
  return state.copyWith(loading: false, users: action.users);
}
