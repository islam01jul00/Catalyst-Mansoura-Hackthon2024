import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdg_app/core/utils/assets.dart';
import 'package:gdg_app/core/utils/color.dart';
import 'package:gdg_app/core/utils/extension.dart';
import 'package:gdg_app/core/utils/validator.dart';
import 'package:gdg_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gdg_app/features/auth/presentation/views/register_view.dart';
import 'package:gdg_app/features/auth/presentation/widgets/center_text.dart';
import 'package:gdg_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:gdg_app/features/auth/presentation/widgets/custom_text.dart';
import 'package:gdg_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:gdg_app/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:gdg_app/features/quiz/presentation/views/quiz_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(AssetsManager.header),
          Form(
            autovalidateMode: autoValidateMode,
            key: key,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 235.h,
                ),
                text(
                  title: 'Welcome back !',
                  textAlign: TextAlign.center,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.blackColor,
                ),
                const SizedBox(
                  height: 30,
                ),
                text(
                  title: 'Username',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.blackColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    hint: 'Email',
                    controller: email,
                    validator: Validator.validateEmail,
                    icon: Icon(
                      Icons.email_outlined,
                      color: ColorManager.hintColor,
                    ),
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                text(
                  title: 'password',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.blackColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  isSuffixIcon: false,
                  obscureText: true,
                  controller: password,
                  validator: Validator.validatePassword,
                  hint: 'Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      context.showToast('Login Successfully');
                    }
                    if (state is LoginFailureState) {
                      context.showToast(isError: true, state.errorMessage);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoadingState) {
                      return const Center(
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else {
                      return CustomButton(
                          title: 'Sign in',
                          onTap: () async {
                            if (key.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).login(
                                  email: email.text, password: password.text);

                              if (state is LoginSuccessState) {
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => QuizView()),
                                //     (route) => false);
                                // BlocProvider.of<QuizCubit>(context)
                                //     .getQuestions();
                              }
                            } else {
                              setState(() {
                                autoValidateMode = AutovalidateMode.always;
                              });
                            }
                          });
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CenterText(
                  textHint: 'New user? ',
                  textButton: 'Sign up',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterView(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void CustomSnackBar(content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
