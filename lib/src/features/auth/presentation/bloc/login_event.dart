import 'package:equatable/equatable.dart';

/// Base auth event.
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Trigger login using provided credentials.
class LoginSubmitted extends LoginEvent {
  const LoginSubmitted({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object?> get props => <Object?>[username, password];
}
