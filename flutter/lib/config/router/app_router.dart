import 'package:flutter/material.dart';
import 'package:gdg_app/config/router/routes.dart';
import 'package:gdg_app/features/auth/presentation/views/login_view.dart';
import 'package:gdg_app/features/auth/presentation/views/register_view.dart';
import 'package:gdg_app/features/onBoarding/presentation/views/onboarding_view.dart';
import 'package:gdg_app/features/quiz/presentation/views/quiz_view.dart';
import 'package:gdg_app/features/home/presentation/views/home_view.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterView(),
        );
      case Routes.quiz:
        return MaterialPageRoute(
          builder: (context) => const QuizView(),
        );
      default:
        return unDefineRoute();
    }
  }
}

Route unDefineRoute() {
  return MaterialPageRoute(
    builder: (context) => const Scaffold(
      body: Center(
        child: Text('No route defined'),
      ),
    ),
  );
}
