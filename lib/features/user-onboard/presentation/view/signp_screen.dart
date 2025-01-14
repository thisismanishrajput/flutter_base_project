import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/bloc/user_onboard_bloc.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/bloc/user_onboard_state.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/view/otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String path = '/signup';
  static const String routeName = 'signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<UserOnboardBloc, UserOnboardState>(
        listener: (context, state) {
          if (state.phoneLoginStatus == StateUpdateStatus.failed) {
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
