import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:xissors/config/initializer.dart';
import 'package:xissors/features/auth/data/respository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthRepository _authRepository;
  AuthBloc() : super(AuthInitial()) {
    _authRepository = AppInitializer.instanceLocator.get<AuthRepository>();
    on<AuthLoginEvent>((event, emit) => _login(event, emit));
  }

  _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final response = await _authRepository.login();
    if (response.isSuccess) {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure(response.message ?? 'An error occurred'));
    }
  }
}
