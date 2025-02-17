class FriendAction {
  @override
  String toString() {
    return 'FriendAction { }';
  }
}

class FriendSuccessAction {
  final String token;
  final String userName;

  FriendSuccessAction({required this.token, required this.userName});

  @override
  String toString() {
    return 'FriendSuccessAction { token: $token, userName: $userName }';
  }
}

class FriendFailedAction {
  final String error;

  FriendFailedAction({required this.error});

  @override
  String toString() {
    return 'FriendFailedAction { error: $error }';
  }
}

//authentication actions
class AuthenticationAction {
  final String username;
  final String password;

  const AuthenticationAction({required this.username, required this.password});

  @override
  String toString() {
    return "AuthenticateAction {username: $username, passsword: $password}";
  }
}

//match actions
class MatchLoadingAction {
  @override
  String toString() {
    // TODO: implement toString
    return "MatchLoadingAction {}";
  }
}

class MatchLosingAction {
  final String opponent;

  const MatchLosingAction({required this.opponent});

  @override
  String toString() {
    // TODO: implement toString
    return "MatchLosingAction {}";
  }
}

class MatchSuccessAction {
  final List<dynamic> matches;
  const MatchSuccessAction({required this.matches});

  @override
  String toString() {
    return "MatchSuccessAction {matches: $matches}";
  }
}

//users actions
class UsersListingAction {
  @override
  String toString() {
    // TODO: implement toString
    return "UsersListingAction {}";
  }
}

class UsersSuccessAction {
  final List<dynamic> users;

  const UsersSuccessAction({required this.users});

  @override
  String toString() {
    // TODO: implement toString
    return "UsersSuccessAction {users: $users}";
  }
}
