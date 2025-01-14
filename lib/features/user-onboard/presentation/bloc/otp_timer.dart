import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OTPTimerCubit extends Cubit<OTPTimerState> {
  OTPTimerCubit() : super(const OTPTimerInitial());

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
     Timer.periodic(oneSecond, (timer) {
      if (state.start == 0) {
        timer.cancel();
        emit(const OTPTimerFinished());
      } else {
        emit(OTPTimerTicking(state.start - 1));
      }
    });
  }

  void resetTimer() {
    emit(const OTPTimerInitial());
  }
}


@immutable
abstract class OTPTimerState {
  final int start;

  const OTPTimerState(this.start);
}

class OTPTimerInitial extends OTPTimerState {
  const OTPTimerInitial() : super(10);
}

class OTPTimerTicking extends OTPTimerState {
  const OTPTimerTicking(super.start);
}

class OTPTimerFinished extends OTPTimerState {
  const OTPTimerFinished() : super(0);
}
