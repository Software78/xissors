part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthSuccess extends AuthState {
  final String message;
  final bool isSuccess;

  AuthSuccess(this.message, this.isSuccess);

  @override
  List<Object?> get props => [message, isSuccess];
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
