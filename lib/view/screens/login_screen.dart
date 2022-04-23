import 'package:build/shared/cubit/login_cubit.dart';
import 'package:build/view/components/constant.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/component.dart' as components;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return Scaffold(
            body: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenSize.height * 0.1,
                        ),
                        child: const components.LoginText(
                          title: 'Welcome To Build ! 👀',
                          message: 'Please sign in to your account',
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            components.DefualtForm(
                              isPassword: false,
                              controller: emailController,
                              label: 'Email',
                              read: false,
                              prefixIcon: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            components.DefualtForm(
                              isPassword: true,
                              controller: passwordController,
                              label: 'Password',
                              read: false,
                              prefixIcon: Icons.lock_outlined,
                              function: () {},
                              suffixIcon: Icons.visibility,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                      ),
                      ConditionalBuilderRec(
                        condition: state is! LoginLoadingState,
                        fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                                color: CustomColors.KredColor)),
                        builder: (context) => Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: CustomColors.KredColor,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      loginCubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  child: const Text(
                                    'Sign in ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
