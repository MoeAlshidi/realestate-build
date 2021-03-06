import 'package:build/shared/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = HomeCubit.get(context);
          return Scaffold(
            body: homeCubit.userModel?.role == 'Agent'
                ? homeCubit.screenListAgent[homeCubit.currentIndex]
                : homeCubit.screenListCustomer[homeCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) => homeCubit.currentScreen(value),
              currentIndex: homeCubit.currentIndex,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                if (homeCubit.userModel?.role == 'Agent')
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add,
                    ),
                    label: 'Feeds',
                  ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings',
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
