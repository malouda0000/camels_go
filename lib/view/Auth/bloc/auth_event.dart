part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogInEvent extends AuthEvent {
  final BuildContext theContext;

  AuthLogInEvent({required this.theContext});
}

final class AuthSignupEvet extends AuthEvent {
  final BuildContext theContext;
  AuthSignupEvet({required this.theContext});
}
// final class AuthLogInEvent extends AuthEvent {}
// final class AuthLogInEvent extends AuthEvent {}

// auth_event.dart

class SignOutEvent extends AuthEvent {}
