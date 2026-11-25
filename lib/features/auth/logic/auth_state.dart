enum AuthStatus { initial, loading, success, failure }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final bool rememberMe;
  final String selectedCountry;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.rememberMe = false,
    this.selectedCountry = 'مصر 🇪🇬',
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    bool? rememberMe,
    String? selectedCountry,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      rememberMe: rememberMe ?? this.rememberMe,
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }
}
