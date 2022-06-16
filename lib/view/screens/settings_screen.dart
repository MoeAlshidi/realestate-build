import 'package:build/shared/cubit/home_cubit.dart';
import 'package:build/view/components/constant.dart';
import 'package:build/view/screens/edit_profile_screen.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit homeCubit = HomeCubit.get(context);
        var profileImage = HomeCubit.get(context).profileimage;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: CustomColors.KredColor,
            onPressed: () {
              homeCubit.projectModel!.projectImages!.length < 3
                  ? homeCubit.uploadProjectImage()
                  : showFlash(
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
                              "There is no Images to Upload",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        );
                      },
                    );
            },
            child: const Icon(
              Icons.upload,
            ),
          ),
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditScreen()));
                  },
                  icon: const Icon(
                    Icons.edit,
                  ))
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    image: DecorationImage(
                        image: profileImage == null
                            ? NetworkImage(
                                '${homeCubit.userModel!.profileImage}')
                            : FileImage(profileImage) as ImageProvider,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${homeCubit.userModel!.fname} ${homeCubit.userModel!.lname}',
                style: const TextStyle(
                    color: CustomColors.KmainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${homeCubit.userModel!.email}',
                style: TextStyle(
                  color: CustomColors.KmainColor.withOpacity(0.7),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 50,
                color: CustomColors.KredColor.withOpacity(0.8),
                child: TextButton(
                  onPressed: () {
                    homeCubit.getProjectImagesFile();
                  },
                  child: const Text(
                    'Upload Project Images',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
