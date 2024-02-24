import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:xissors/features/auth/data/respository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) => _login(event, emit));
  }

  _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await authRepository.login();
    if (response.isSuccess) {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure(response.message ?? 'An error occurred'));
    }
  }
}
