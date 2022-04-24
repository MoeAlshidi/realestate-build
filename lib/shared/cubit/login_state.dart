part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class PasswordVisibility extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class RegisterLoadingState extends LoginState {}

class RegisterSuccessState extends LoginState {}

class RegisterErrorState extends LoginState {
  final String error;

  RegisterErrorState(this.error);
}
