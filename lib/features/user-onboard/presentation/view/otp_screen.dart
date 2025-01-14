import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_base_project/features/home/presentation/view/home_screen.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/bloc/otp_timer.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/bloc/user_onboard_bloc.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/bloc/user_onboard_state.dart';
import 'package:flutter_base_project/utility/constants/color_constants.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});
  static const String path = '/otpScreen';
  static const String routeName = 'otpScreen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<OTPTimerCubit>().startTimer();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = ColorConst.colorPrimary;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    final defaultPinTheme = PinTheme(
      width:30,
      height: 55,
      constraints: BoxConstraints(
          minWidth: MediaQuery.sizeOf(context).width
      ),
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConst.textFieldColor
        // border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 31.0),
        child: FadeInUp(
          child: BlocListener<UserOnboardBloc, UserOnboardState>(
            listener: (context, state) {
              if (state.phoneVerificationStatus == StateUpdateStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Phone verification successful!")),
                );
                context.go(HomeScreen.path);
              } else if (state.phoneVerificationStatus == StateUpdateStatus.failed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OTPTimerCubit, OTPTimerState>(
      builder: (context, state) {
        if (state is OTPTimerInitial) {
          return const SizedBox();
        } else if (state is OTPTimerTicking) {
          return Row(
            children: [
              const Text(
                'Resend OTP in: ',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                '${state.start}',
                style: const TextStyle(
                  color: ColorConst.colorPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        } else if (state is OTPTimerFinished) {
          return Row(
            children: [
              const Text(
                "Didn’t receive code?",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // Trigger resend OTP logic here
                },
                child: const Text(
                  " Resend code",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
