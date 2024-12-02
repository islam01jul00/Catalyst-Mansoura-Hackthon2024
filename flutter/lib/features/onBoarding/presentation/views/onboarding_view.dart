import 'package:flutter/material.dart';
import 'package:gdg_app/features/onBoarding/presentation/widgets/onboarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: OnBoardingViewBody(),
    );
  }
}
