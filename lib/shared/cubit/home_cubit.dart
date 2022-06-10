import 'dart:io';

import 'package:build/models/comment_model.dart';
import 'package:build/models/feed_model.dart';
import 'package:build/models/project_model.dart';
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

  List<Widget> screenListAgent = [
    HomeScreen(),
    FeedScreen(),
    const SettingsScreen(),
  ];
  List<Widget> screenListCustomer = [
    HomeScreen(),
    const SettingsScreen(),
  ];
  int progress = 30;

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
      selectedProject = userModel!.projectId!;
      if (userModel!.role == 'Customer') {
        getProject(id: userModel!.uId);
      } else {
        getProject();
      }

      emit(GetDataSuccess());
    }).catchError((error) {
      emit(GetDataError(error.toString()));
    });
  }

  ProjectModel? projectModel;
  void getProject({
    String? id,
  }) {
    emit(GetProjectLoading());
    if (id != null) {
      FirebaseFirestore.instance
          .collection('Projects')
          .doc(id)
          .get()
          .then((value) {
        projectModel = ProjectModel.fromJson(value.data()!);
        print(projectModel!.progress!);
        progressprecent = (projectModel!.progress!);
        print(progressprecent);

        getPosts(projectId: selectedProject);
        getComments();
        emit(GetProjectSuccess());
      }).catchError((error) {
        emit(GetProjectError(error.toString()));
      });
    } else {
      FirebaseFirestore.instance.collection('Projects').get().then((value) {
        value.docs.forEach((element) {
          ProjectModel project = ProjectModel(
            username: element.data()['username'],
            projectId: element.data()['projectId'],
          );

          projects.add(project);
        });

        emit(GetProjectSuccess());
      }).catchError((error) {
        emit(GetProjectError(error.toString()));
      });
    }
  }

  void updateUserImage() {
    emit(UpdateImageLoading());
    FirebaseFirestore.instance.collection('User').doc(token).update({
      'imageProfile': profileImageUrl,
    }).then((value) {
      emit(UpdateImageSuccess());
    }).catchError((error) {
      emit(UpdateImageError(error.toString()));
    });
  }

  void updateProgress({
    required double progress,
    required String projectId,
  }) {
    emit(UpdateImageLoading());
    FirebaseFirestore.instance
        .collection('Projects')
        .doc(projectId)
        .update({'progress': progress}).then((value) {
      emit(UpdateImageSuccess());
    }).catchError((error) {
      emit(UpdateImageError(error.toString()));
    });
  }

  File? postImagePath;
  String postImageUrl = '';
  final pickerPost = ImagePicker();
  Future<void> getPostImagePath() async {
    final pickedFile = await pickerPost.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImagePath = File(pickedFile.path);
      emit(GetPostImageSuccess());
    } else {
      emit(GetPostImageError('No images Selected'));
    }
  }

  void uploadPostImage({required String feed, required DateTime date}) {
    emit(UploadPostFeedLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('feeds/${Uri.file(postImagePath!.path).pathSegments.last}')
        .putFile(postImagePath!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postImageUrl = value;
        createPost(
            feed: feed, date: date, image: value, projectID: selectedProject);
        emit(UploadPostFeedSuccess());
      });
    }).catchError((error) {
      emit(UploadPostFeedError(error.toString()));
    });
  }

  Future<void> createPost({
    required String feed,
    required String projectID,
    String? image,
    required DateTime date,
  }) async {
    FeedModel model = FeedModel(
        id: token,
        date: Timestamp.fromDate(date),
        profileImage: userModel!.profileImage,
        feed: feed,
        feedImages: image,
        name: '${userModel!.fname} ${userModel!.lname}',
        feedId: projectID);
    FirebaseFirestore.instance
        .collection('Projects')
        .doc(projectID)
        .collection('Feeds')
        .doc(model.feedId)
        .set(model.toMap())
        .then((value) {
      emit(PostFeedSuccess());
    }).catchError((error) {
      emit(PostFeedError(error.toString()));
    });
  }

  void sendComment({
    required String commentId,
    required String projectId,
    required String userComment,
  }) {
    Comment comment = Comment(
      id: projectId,
      userId: commentId,
      profileImage: userModel!.profileImage as String,
      comment: userComment,
      date: Timestamp.fromDate(DateTime.now()),
    );

    emit(SendCommentsLoading());
    FirebaseFirestore.instance
        .collection('Projects')
        .doc(projectId)
        .collection('Feeds')
        .doc(commentId)
        .collection('Comments')
        .add(comment.toMap())
        .then((value) {
      emit(SendCommentsSuccess());
    }).catchError((error) {
      emit(SendCommentsError(error.toString()));
    });
  }

  List<Comment> commentList = [];
  void getComments() {
    commentList.clear();
    emit(GetCommentsLoading());
    FirebaseFirestore.instance
        .collection('Projects')
        .doc(selectedProject)
        .collection('Feeds')
        .doc(selectedProject)
        .collection('Comments')
        .get()
        .then((value) {
      value.docs.forEach(
        (element) {
          commentList.add(Comment.fromJson(element.data()));
        },
      );
      emit(GetCommentsSuccess());
    }).catchError((error) {
      emit(GetCommentsError(error.toString()));
      print(error);
    });
  }

  String profileImageUrl = '';
  void uploadProfile() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('User/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(UploadProfileSuccess());
        updateUserImage();
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

  List<FeedModel> feeds = [];

  void getPosts({
    required String projectId,
  }) {
    feeds.clear();
    emit(GetPostFeedLoading());
    print('HEllo');
    print(selectedProject);
    FirebaseFirestore.instance
        .collection('Projects')
        .doc(selectedProject)
        .collection('Feeds')
        .get()
        .then((value) {
      print(value.docs.length);
      value.docs.forEach(
        (element) {
          feeds.add(FeedModel.fromJson(element.data()));
        },
      );
      print('HII');
      emit(GetPostFeedSuccess());
    }).catchError((error) {
      emit(GetPostFeedError(error.toString()));
    });
  }
}
