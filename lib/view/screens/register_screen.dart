import 'package:build/shared/cubit/login_cubit.dart';
import 'package:build/view/components/constant.dart';
import 'package:build/view/screens/login_screen.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/component.dart' as components;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final fNameController = TextEditingController();

  final lNameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is CreateUserSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false);
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: screenSize.height,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: screenSize.height * 0.06),
                          child: const components.LoginText(
                            title: 'Create new account 🙌🏻',
                            message: 'Harry up and become financial free',
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.04,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              components.DefualtForm(
                                isPassword: false,
                                read: false,
                                controller: fNameController,
                                label: 'First Name',
                                prefixIcon: Icons.person_outlined,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              components.DefualtForm(
                                isPassword: false,
                                read: false,
                                controller: lNameController,
                                label: 'Last Name',
                                prefixIcon: Icons.person_outlined,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              components.DefualtForm(
                                isPassword: false,
                                read: false,
                                controller: emailController,
                                label: 'Email',
                                prefixIcon: Icons.email_outlined,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              components.DefualtForm(
                                isPassword: loginCubit.isPassword,
                                controller: passwordController,
                                label: 'Password',
                                read: false,
                                prefixIcon: Icons.lock_outlined,
                                function: loginCubit.passwordVisibility,
                                suffixIcon: loginCubit.suffix,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Agent',
                              style: TextStyle(
                                  color: CustomColors.KmainColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                            Checkbox(
                                value: loginCubit.isAgent,
                                onChanged: (value) {
                                  setState(() {
                                    loginCubit.isAgent = value!;
                                  });
                                }),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        ConditionalBuilderRec(
                          condition: state is! RegisterLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                              color: CustomColors.KredColor,
                            ),
                          ),
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
                                        loginCubit.userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          fname: fNameController.text,
                                          lname: lNameController.text,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Sign Up ',
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
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already Have an Account?"),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  color: CustomColors.KmainColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
