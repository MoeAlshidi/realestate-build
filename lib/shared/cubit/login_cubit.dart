import 'package:bloc/bloc.dart';
import 'package:build/models/agent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    required String email,
    required String password,
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
    required String email,
    required String password,
    required String fname,
    required String lname,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      createUser(
        fname: fname,
        lname: lname,
        email: email,
        uId: value.user!.uid,
      );
      emit(RegisterSuccessState());
    }).catchError(
      (error) {
        emit(
          RegisterErrorState(error.toString()),
        );
      },
    );
  }

  void createUser({
    required String fname,
    required String lname,
    required String email,
    required String uId,
  }) {
    Agent agent = Agent(
      fname: fname,
      lname: lname,
      email: email,
      uId: uId,
    );
    emit(CreateUserLoadingState());
    print('Start Create');
    FirebaseFirestore.instance
        .collection('Agent')
        .doc(uId)
        .set(agent.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
      print('Done');
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
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
