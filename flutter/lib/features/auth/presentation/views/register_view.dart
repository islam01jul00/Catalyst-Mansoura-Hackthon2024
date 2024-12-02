import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdg_app/core/utils/assets.dart';
import 'package:gdg_app/core/utils/color.dart';
import 'package:gdg_app/core/utils/extension.dart';
import 'package:gdg_app/core/utils/validator.dart';
import 'package:gdg_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gdg_app/features/auth/presentation/widgets/center_text.dart';
import 'package:gdg_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:gdg_app/features/auth/presentation/widgets/custom_text.dart';
import 'package:gdg_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:gdg_app/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:gdg_app/features/quiz/presentation/views/quiz_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();

  // Gender selection logic
  String? gender;

  final GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        autovalidateMode: autoValidateMode,
        key: key,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Image.asset(
              AssetsManager.header,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      hint: 'Name',
                      controller: name,
                      validator: Validator.validateName,
                      icon: Icon(
                        Icons.person,
                        color: ColorManager.hintColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    text(
                      title: 'Email',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.blackColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                        controller: email,
                        hint: 'Email',
                        validator: Validator.validateEmail,
                        icon: Icon(
                          Icons.email_outlined,
                          color: ColorManager.hintColor,
                        ),
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 10,
                    ),
                    text(
                      title: 'Password',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.blackColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      obscureText: true,
                      isSuffixIcon: false,
                      hint: 'Password',
                      validator: Validator.validatePassword,
                      controller: password,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    text(
                      title: 'Phone',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.blackColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      icon: const Icon(
                        Icons.phone,
                      ),
                      hint: 'Phone',
                      validator: Validator.validatePhone,
                      controller: phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    text(
                      title: 'Gender',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.blackColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'Male',
                                groupValue: gender,
                                activeColor: ColorManager.primaryColor,
                                onChanged: (String? value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                              const text(title: 'Male', fontSize: 16),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'Female',
                                groupValue: gender,
                                activeColor: ColorManager.primaryColor,
                                onChanged: (String? value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                              const text(title: 'Female', fontSize: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is RegisterSuccessState) {
                          context.showToast('Login Successfully');
                        }
                        if (state is RegisterFailureState) {
                          context.showToast(isError: true, state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterLoadingState) {
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
                              title: 'Register',
                              onTap: () async {
                                log(" email : ${email.text}\n password : ${password.text}\n name : ${name.text}\n phone : ${phone.text}\n gender : ${gender}");
                                if (key.currentState!.validate()) {
                                  if (gender != null) {
                                    await BlocProvider.of<AuthCubit>(context)
                                        .register(
                                            email: email.text,
                                            password: password.text,
                                            gender: gender!,
                                            name: name.text);
                                    if (state is RegisterSuccessState) {
                                      context
                                          .showToast('Register Successfully');
                                      //   Navigator.pushAndRemoveUntil(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) => QuizView()),
                                      //       (route) => false);
                                      //        BlocProvider.of<QuizCubit>(context)
                                      // .getQuestions();
                                    }
                                  } else {
                                    context.showToast('Please select a gender');
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
                      textHint: 'Already have an account?',
                      textButton: 'Login',
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    phone.dispose();
    super.dispose();
  }
}
