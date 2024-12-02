import 'package:flutter/material.dart';
import 'package:gdg_app/core/utils/widgets/toast_widget.dart';

extension ExtensionBuild on BuildContext {
  double get deviceWidth => MediaQuery.sizeOf(this).width;
  double get deviceHeight => MediaQuery.sizeOf(this).height;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void showToast(String message, {bool isError = false}) {
    final overlay = Overlay.of(this);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 50.0,
          left: deviceWidth * 0.1,
          right: deviceWidth * 0.1,
          child: Material(
            color: Colors.transparent,
            child: ToastWidget(
              message: message,
              color: isError
                  ? const Color.fromARGB(255, 129, 8, 8)
                  : const Color.fromARGB(255, 102, 102, 102),
              onDisappear: () => overlayEntry.remove(),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
  }
}
