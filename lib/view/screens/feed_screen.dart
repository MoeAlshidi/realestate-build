import 'package:build/shared/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);
  TextEditingController feedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Feed'),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () {},
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill in the field';
                    } else {
                      return null;
                    }
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
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
              ],
            ),
          ),
        );
      },
    );
  }
}
