import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/features/user-onboard/domain/repo/user_onboard_repo.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/bloc/user_onboard_event.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/bloc/user_onboard_state.dart';
import 'package:flutter_base_project/utility/utility_function.dart';
import '../../../../services/service_locator.dart';
import '../../../../services/session_manager/app_session_manager.dart';

class UserOnboardBloc extends Bloc<UserOnboardEvent, UserOnboardState> {
  UserOnboardBloc() : super(UserOnboardState()) {
    on<VerifyOtpEvent>(_verifyOtp);
    on<LoginEvent>(_login);
  }

  final UserOnboardRepo _userOnboardRepo = serviceLocator<UserOnboardRepo>();

  FutureOr<void> _verifyOtp(VerifyOtpEvent event, Emitter<UserOnboardState> emit) async {
    emit(state.copyWith(otpVerificationStatus: StateUpdateStatus.updating));
    final res = await _userOnboardRepo.verifyOtp(state.verificationID ?? '', event.otp ?? "");

    res.fold((left) {
      UtilityFunction.instance.showToast(left, level: ToastLevel.error);
      emit(state.copyWith(otpVerificationStatus: StateUpdateStatus.failed));
    }, (userCredential) {
      UtilityFunction.instance.showToast("OTP verification successful!", level: ToastLevel.success);
      emit(state.copyWith(otpVerificationStatus: StateUpdateStatus.success));
    });

    emit(state.copyWith(otpVerificationStatus: StateUpdateStatus.none));
  }

  FutureOr<void> _login(LoginEvent event, Emitter<UserOnboardState> emit) async {
    emit(state.copyWith(phoneLoginStatus: StateUpdateStatus.updating));
    final res = await _userOnboardRepo.loginWithPhone(event.phoneNumber);

    res.fold((left) {
      UtilityFunction.instance.showToast(left, level: ToastLevel.error);
      emit(state.copyWith(phoneLoginStatus: StateUpdateStatus.failed));
    }, (userData) {
      if (userData != null) {
        AppSessionManager.instance.saveMobileNumber(mobileNumber: event.phoneNumber);
        AppSessionManager.instance.saveAuthToken(authToken: userData.apiToken ?? "");
        AppSessionManager.instance.saveUserId(userId: "${userData.id}");
        UtilityFunction.instance.showToast("Login successful!", level: ToastLevel.success);
        emit(state.copyWith(phoneLoginStatus: StateUpdateStatus.success,userLoginData: userData));
      }
    });

    emit(state.copyWith(phoneLoginStatus: StateUpdateStatus.none));
  }
}


