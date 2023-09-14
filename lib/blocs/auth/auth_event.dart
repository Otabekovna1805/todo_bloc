part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String prePassword;

  const SignUpEvent({
    required this.username,
    required this.email,
    required this.password,
    required this.prePassword,
  });

  @override
  List<Object?> get props => [username, email, password, prePassword];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
