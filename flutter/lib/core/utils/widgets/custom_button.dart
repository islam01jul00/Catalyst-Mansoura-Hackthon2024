import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdg_app/core/utils/color.dart';
import 'package:gdg_app/features/auth/presentation/views/login_view.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                  (route) => false);
            },
            child: Text(
              "skip",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.hintColor),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(50000.r),
              ),
              alignment: AlignmentDirectional.center,
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
