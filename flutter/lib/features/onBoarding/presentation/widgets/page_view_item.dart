import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdg_app/config/router/routes.dart';
import 'package:gdg_app/core/utils/style.dart';
import 'package:gdg_app/features/onBoarding/data/models/onboarding_model.dart';

class PageViewItem extends StatelessWidget {
  final OnboardingItemModel itemData;
  const PageViewItem(
      {super.key,
      required this.itemData,
      required this.controller,
      required this.maxPageNumber,
      required this.currentPage});
  final PageController controller;
  final int maxPageNumber;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
              height: 316.h, width: 316.w, child: Image.asset(itemData.image)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              itemData.description,
              style: StyleManager.textStyle16,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
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

void navigateToPreviousView(PageController controller) {
  controller.previousPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
}
