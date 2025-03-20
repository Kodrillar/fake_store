import 'package:fake_store/src/core/utils/async_state.dart';

class AuthState {
  final AsyncState asyncState;
  final bool obscureText;

  AuthState({
    required this.asyncState,
    required this.obscureText,
  });

  factory AuthState.initial() =>
      AuthState(asyncState: AsyncData(null), obscureText: true);

  @override
  String toString() =>
      'AuthState(asyncState: $asyncState, obscureText: $obscureText)';

  AuthState copyWith({
    AsyncState? asyncState,
    bool? obscureText,
  }) {
    return AuthState(
      asyncState: asyncState ?? this.asyncState,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}
