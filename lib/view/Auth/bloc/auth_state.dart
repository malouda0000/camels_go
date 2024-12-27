part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingStateSignIn extends AuthState {}

final class AuthSuccessStateSignIn extends AuthState {}

final class AuthErrorStateSignIn extends AuthState {
  final String errorMessage;
  AuthErrorStateSignIn({required this.errorMessage});
}


final class AuthLoadingStateSignUp extends AuthState {}

final class AuthSuccessStateSignUp extends AuthState {}

final class AuthErrorStateSignUp extends AuthState {
  final String errorMessage;
  AuthErrorStateSignUp({required this.errorMessage});
}


class AuthSignedOut extends AuthState {}