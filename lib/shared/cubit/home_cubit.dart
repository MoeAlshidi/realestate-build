import 'dart:io';

import 'package:build/models/user_model.dart';
import 'package:build/view/components/constant.dart';
import 'package:build/view/screens/feed_screen.dart';
import 'package:build/view/screens/home_screen.dart';
import 'package:build/view/screens/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(BuildContext context) {
    return BlocProvider.of((context));
  }

  List<Widget> screenList = [
    HomeScreen(),
    FeedScreen(),
    const SettingsScreen(),
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

  void updateUserData() {
    emit(UpdateDataLoading());
    FirebaseFirestore.instance.collection('User').doc(token).update({
      'imageProfile': profileImageUrl,
    }).then((value) {
      emit(UpdateDataSuccess());
      print("done");
    }).catchError((error) {
      emit(UpdateDataError(error.toString()));
    });
  }

  void createPost({
    required String id,
    required String feed,
    List<String>? image,
    required DateTime date,
  }) {
    emit(PostFeedLoading());
    // firebase_storage.FirebaseStorage.instance.ref().child('feeds/${}')
  }

  String profileImageUrl = '';
  void uploadProfile() {
    print(token);
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('User/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(UploadProfileSuccess());
        updateUserData();
      });
    }).catchError((error) {
      emit(UploadProfileError(error.toString()));
    });
  }

  File? profileimage;

  final picker = ImagePicker();
  Future<void> getImagePath() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      emit(GetImageSuccess());
    } else {
      emit(GetImageError('No images Selected'));
    }
  }
}
