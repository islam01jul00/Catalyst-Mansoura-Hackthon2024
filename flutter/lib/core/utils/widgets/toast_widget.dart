import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToastWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDisappear;
  final Color color;

  const ToastWidget({
    super.key,
    required this.message,
    required this.color,
    required this.onDisappear,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      reverseDuration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      _controller.reverse().then((_) => widget.onDisappear());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(5000),
          ),
          child: Text(
            widget.message,
            style: const TextStyle(color: Colors.white, fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
