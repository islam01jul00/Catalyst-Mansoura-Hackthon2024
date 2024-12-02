import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.hint,
      this.onChanged,
      this.obscureText = false,
      this.icon,
      this.keyboardType = TextInputType.text,
      this.contentPadding,
      this.isSuffixIcon = true,
      this.controller,
      this.borderRadius = 500,
      required this.validator,
      this.onFieldSubmitted});
  String hint;
  Function(String)? onChanged;
  bool obscureText;
  bool isSuffixIcon;
  Widget? icon;
  TextInputType keyboardType;
  EdgeInsetsGeometry? contentPadding;
  TextEditingController? controller;
  Function(String)? onFieldSubmitted;
  late double borderRadius;
  String? Function(String?) validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: widget.obscureText,
      focusNode: focusNode,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
          suffixIcon: widget.isSuffixIcon
              ? widget.icon
              : IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  icon: Icon(widget.obscureText
                      ? Icons.visibility
                      : Icons.visibility_off)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
          filled: true,
          fillColor: Color(0xffF4F3F3),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: widget.hint,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(224, 142, 141, 141),
          )),
      keyboardType: widget.keyboardType,
      scrollPhysics: const BouncingScrollPhysics(),
    );
  }
}
