class FriendState {
  final bool loading;
  final String error;
  final String token;
  final String userName;
  final List<dynamic> matches;
  final List<dynamic> users;

  FriendState(
      {required this.loading,
      required this.error,
      required this.token,
      required this.userName,
      required this.matches,
      required this.users});

  factory FriendState.initial() => FriendState(
      loading: false,
      error: '',
      token: "",
      userName: "",
      matches: [],
      users: []);

  FriendState copyWith({
    bool? loading,
    String? error,
    String? token,
    String? userName,
    List<dynamic>? matches,
    List<dynamic>? users,
  }) =>
      FriendState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        token: token ?? this.token,
        userName: userName ?? this.userName,
        matches: matches ?? this.matches,
        users: users ?? this.users,
      );

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is FriendState &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          error == other.error &&
          token == other.token &&
          userName == other.userName &&
          matches == other.matches &&
          users == other.users;

  @override
  int get hashCode =>
      super.hashCode ^
      runtimeType.hashCode ^
      loading.hashCode ^
      error.hashCode ^
      token.hashCode ^
      userName.hashCode ^
      matches.hashCode ^
      users.hashCode;

  @override
  String toString() =>
      "FriendState { loading: $loading,  error: $error, token: $token, userName: $userName, matches: $matches, users: $users}";
}
