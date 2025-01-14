import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/bloc/user_onboard_bloc.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/bloc/user_onboard_state.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/view/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String path = '/login';
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<UserOnboardBloc, UserOnboardState>(
        listener: (context, state) {
          if (state.phoneLoginStatus == StateUpdateStatus.failed) {
            // Navigate to OTP screen
            context.pushNamed(
              OtpScreen.routeName,
              extra: state.verificationID,
            );
          }
        },
      ),
    );
  }
}
