import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdg_app/config/router/routes.dart';
import 'package:gdg_app/core/utils/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  const CustomSmoothPageIndicator({
    super.key,
    required this.controller,
    required this.maxPageNumber,
  });

  final PageController controller;
  final int maxPageNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmoothPageIndicator(
          onDotClicked: (index) {
            if (controller.page == maxPageNumber) {
              navigateToLoginView(context);
            }
            navigateToNextView(controller);
          },
          controller: controller,
          count: 3,
          effect: ExpandingDotsEffect(
            dotColor: ColorManager.hintColor,
            dotHeight: 10.h,
            dotWidth: 10.w,
            activeDotColor: ColorManager.primaryColor,
          ),
        ),
      ],
    );
  }

  void navigateToNextView(PageController controller) {
    controller.nextPage(
      duration: const Duration(seconds: 2),
      curve: Easing.legacy,
    );
  }

  void navigateToLoginView(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }
}
