part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class PasswordVisibility extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  String accessToken;

  LoginSuccessState(this.accessToken);
}

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

//create Project
class ProjectLoadingState extends LoginState {}

class ProjectSuccessState extends LoginState {}

class ProjectErrorState extends LoginState {
  final String error;

  ProjectErrorState(this.error);
}

class CreateUserLoadingState extends LoginState {}

class CreateUserSuccessState extends LoginState {}

class CreateUserErrorState extends LoginState {
  final String error;

  CreateUserErrorState(this.error);
}
