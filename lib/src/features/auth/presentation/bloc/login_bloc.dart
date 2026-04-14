import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:clean_arch_base/src/core/utils/result.dart';
import 'package:clean_arch_base/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:clean_arch_base/src/features/auth/presentation/bloc/login_event.dart';
import 'package:clean_arch_base/src/features/auth/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC for login flow.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginUsecase loginUsecase})
    : _loginUsecase = loginUsecase,
      super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final LoginUsecase _loginUsecase;

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading, errorMessage: ''));
    final Result<void> result = await _loginUsecase(
      username: event.username,
      password: event.password,
    );

    result.when(
      success: (_) {
        emit(state.copyWith(status: LoginStatus.success));
      },
      failure: (failure) {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: failure.message.isEmpty
                ? AppStrings.invalidCredentials
                : failure.message,
          ),
        );
      },
    );
  }
}
