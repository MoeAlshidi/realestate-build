import 'package:bloc/bloc.dart';
import 'package:build/shared/server/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(BuildContext context) {
    return BlocProvider.of((context));
  }

  void userLogin({
    required email,
    required password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      emit(LoginSuccessState());
    }).catchError(
      (error) {
        emit(
          LoginErrorState(error.toString()),
        );
      },
    );
  }

  void userRegister({
    required email,
    required password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      emit(RegisterSuccessState());
    }).catchError(
      (error) {
        emit(
          RegisterErrorState(error.toString()),
        );
      },
    );
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void passwordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(PasswordVisibility());
  }
}
