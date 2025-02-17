import './friend/friend.state.dart';

class AppState {
  final FriendState friendState;
  AppState({required this.friendState});

  factory AppState.initial() => AppState(
        friendState: FriendState.initial(),
      );

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          friendState == other.friendState;

  @override
  int get hashCode => super.hashCode ^ friendState.hashCode;

  @override
  String toString() {
    return "AppState { friendState: $friendState }";
  }
}
