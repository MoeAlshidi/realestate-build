import 'package:build/shared/cubit/home_cubit.dart';
import 'package:build/view/screens/home_screen.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/constant.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  TextEditingController feedController = TextEditingController();

  Future<void> _showMyDialog(ctx) async {
    return showDialog<void>(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            AlertDialog(
              title: Text('Posting Your Feed'),
              content: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is UploadPostFeedLoading || state is PostFeedLoading) {
          _showMyDialog(context);
        }
        if (state is UploadPostFeedSuccess || state is PostFeedSuccess) {
          HomeCubit.get(context).isImage = false;
          Navigator.pop(context);
          HomeCubit.get(context).currentIndex = 0;
          feedController.clear();
        }
      },
      builder: (context, state) {
        HomeCubit homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Feed'),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () {
                  if (feedController.text.isNotEmpty) {
                    homeCubit.postImagePath == null
                        ? homeCubit.createPost(
                            feed: feedController.text,
                            date: DateTime.now(),
                            projectID: selectedProject)
                        : homeCubit.uploadPostImage(
                            feed: feedController.text, date: DateTime.now());
                  } else {
                    showFlash(
                      context: context,
                      duration: const Duration(seconds: 4),
                      builder: (context, controller) {
                        return Flash.bar(
                          backgroundGradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 204, 82, 41),
                              CustomColors.KredColor,
                            ],
                          ),
                          controller: controller,
                          useSafeArea: false,
                          child: FlashBar(
                            content: const Text(
                              "Please fill in the field",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(
                                '${homeCubit.userModel!.profileImage}'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${homeCubit.userModel!.fname} ${homeCubit.userModel!.lname}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: feedController,
                  decoration: const InputDecoration(
                      hintText: 'Anything new regarding the project..'),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        homeCubit.getPostImagePath();
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      'Upload a photo',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                if (homeCubit.isImage == true)
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child:
                            Image(image: FileImage(homeCubit.postImagePath!)),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
