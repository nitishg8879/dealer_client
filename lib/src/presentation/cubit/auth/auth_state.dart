part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthProcessing extends AuthState {
  final bool isLoading;
  AuthProcessing(this.isLoading);
}

final class AuthException extends AuthState {
  final String error;
  AuthException(this.error);
}
