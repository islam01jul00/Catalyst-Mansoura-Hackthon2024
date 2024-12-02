import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdg_app/core/utils/assets.dart';
import 'package:gdg_app/core/utils/string.dart';
import 'package:gdg_app/features/onBoarding/data/models/onboarding_model.dart';
import 'package:gdg_app/features/onBoarding/presentation/widgets/page_view_item.dart';

class CustomPageView extends StatefulWidget {
  final PageController controller;
  final int maxPageNumber;

  const CustomPageView(
      {super.key, required this.controller, required this.maxPageNumber});

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  List<OnboardingItemModel> onboardingItemsModel = [
    OnboardingItemModel(
      description: StringManager.onBoardingDescriptionOne,
      image: AssetsManager.onBoardingImageOne,
    ),
    OnboardingItemModel(
      description: StringManager.onBoardingDescriptionTwo,
      image: AssetsManager.onBoardingImageTwo,
    ),
    OnboardingItemModel(
      description: StringManager.onBoardingDescriptionThree,
      image: AssetsManager.onBoardingImageThree,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 540.h,
      child: PageView.builder(
        controller: widget.controller,
        itemCount: onboardingItemsModel.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => PageViewItem(
          controller: widget.controller,
          maxPageNumber: widget.maxPageNumber,
          currentPage: index,
          itemData: onboardingItemsModel[index],
        ),
      ),
    );
  }
}
