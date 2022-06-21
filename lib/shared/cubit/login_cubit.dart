import 'package:bloc/bloc.dart';
import 'package:build/models/feed_model.dart';
import 'package:build/models/project_model.dart';
import 'package:build/models/user_model.dart';
import 'package:build/view/components/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(BuildContext context) {
    return BlocProvider.of((context));
  }

  bool isAgent = true;

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
      emit(LoginSuccessState(value.user!.uid));
    }).catchError(
      (error) {
        print("ERRRORR $error");
        emit(
          LoginErrorState(error.toString()),
        );
      },
    );
  }

  void createPoject({
    required String userID,
    required String fname,
    required String projectID,
  }) {
    ProjectModel projectModel = ProjectModel(
      progress: 0,
      latitude: '23.585890',
      longitude: '58.405922',
      userID: userID,
      username: '$fname Project',
      projectId: projectID,
      projectImages: [],
    );
    emit(ProjectLoadingState());
    FirebaseFirestore.instance
        .collection('Projects')
        .doc(projectModel.projectId)
        .set(projectModel.toMap())
        .then((value) {
      print("THIS IS THE PROJECT IDD ${projectModel.projectId}");
      selectedProject = projectModel.projectId!;
      emit(ProjectSuccessState());
    }).catchError((error) {
      emit(ProjectErrorState(error.toString()));
    });
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
      createUser(
        fname: fname,
        lname: lname,
        email: email,
        uId: value.user!.uid,
      );
      if (!isAgent) {
        createPoject(
          userID: value.user!.uid,
          fname: fname,
          projectID: value.user!.uid,
        );
      }

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
    UserModel user = UserModel(
      projectId: uId,
      fname: fname,
      lname: lname,
      email: email,
      uId: uId,
      role: isAgent ? 'Agent' : 'Customer',
      profileImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKKj4HIjucFnNOM1pMIUnB7PtWsdCym-4eCRjkV3OfYjKnxpkMJDOqHPIwK3pCd0aeQLc&usqp=CAU',
    );
    emit(CreateUserLoadingState());

    FirebaseFirestore.instance
        .collection('User')
        .doc(uId)
        .set(user.toMap())
        .then((value) {
      print(user.profileImage);
      emit(CreateUserSuccessState());
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
