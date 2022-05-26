import 'package:build/models/user_model.dart';
import 'package:build/view/components/constant.dart';
import 'package:build/view/screens/feed_screen.dart';
import 'package:build/view/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(BuildContext context) {
    return BlocProvider.of((context));
  }

  List<Widget> screenList = [
    HomeScreen(),
    const FeedScreen(),
  ];
  int currentIndex = 0;
  void currentScreen(int index) {
    currentIndex = index;
    emit(CurrentScreen());
  }

  UserModel? userModel;

  void getData() {
    emit(GetDataLoading());
    FirebaseFirestore.instance
        .collection('User')
        .doc(token)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetDataSuccess());
    }).catchError((error) {
      emit(GetDataError(error.toString()));
    });
  }
}
