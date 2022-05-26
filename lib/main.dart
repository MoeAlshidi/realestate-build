import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'shared/local/cache_helper.dart';
import 'view/components/constant.dart';
import 'view/screens/login_screen.dart';
import 'view/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'userToken') ?? '';

  Widget widget;

  if (token == '') {
    widget = const MyApp();
  } else {
    widget = const Wrapper();
  }
  runApp(
    MaterialApp(
      title: "Thises",
      debugShowCheckedModeBanner: false,
      home: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
