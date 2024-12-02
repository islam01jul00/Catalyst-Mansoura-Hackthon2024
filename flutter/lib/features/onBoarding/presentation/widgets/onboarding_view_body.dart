import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdg_app/config/router/routes.dart';
import 'package:gdg_app/features/onBoarding/presentation/widgets/custom_page_view.dart';
import 'package:gdg_app/features/onBoarding/presentation/widgets/custom_smooth_page_indicator.dart';

import '../../../../core/utils/widgets/custom_button.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({
    super.key,
  });

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30.h,
          ),
        ),
        SliverToBoxAdapter(
          child: CustomPageView(
            maxPageNumber: 2,
            controller: controller,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10.h,
          ),
        ),
        SliverToBoxAdapter(
          child: CustomSmoothPageIndicator(
            controller: controller,
            maxPageNumber: 2,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10.h,
          ),
        ),
        SliverToBoxAdapter(
          child: CustomButton(
            onTap: () {
              if (controller.page == 2) {
                navigateToLoginView(context);
              }
              navigateToNextView(controller);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20.h,
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
