import 'dart:io';

import 'package:build/shared/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
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
              title: Text('Uploading Profile Picture..'),
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
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is UploadProfileLoading) {
            _showMyDialog(context);
          }
          if (state is UpdateImageSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          HomeCubit homeCubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Edit Profile"),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () => Navigator.pop(context, true),
              ),
              actions: [
                TextButton(
                  onPressed: () => homeCubit.uploadProfile(),
                  child: const Text(
                    'Upload',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            body: Center(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () => homeCubit.getImagePath(),
                child: const Text(
                  'Edit Now',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
