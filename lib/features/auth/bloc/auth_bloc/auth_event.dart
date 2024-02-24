part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String email, password;

  AuthLoginEvent({required this.email, required this.password});
}
