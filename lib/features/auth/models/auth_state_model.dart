class AuthState {
  final bool isAuthenticated;
  final String? userName;

  const AuthState({this.isAuthenticated = false, this.userName});

  AuthState copyWith({bool? isAuthenticated, String? userName}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userName: userName ?? this.userName,
    );
  }
}
