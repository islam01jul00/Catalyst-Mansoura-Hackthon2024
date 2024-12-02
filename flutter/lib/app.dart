import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdg_app/config/router/app_router.dart';
import 'package:gdg_app/config/router/routes.dart';
import 'package:gdg_app/core/utils/locator.dart';
import 'package:gdg_app/features/auth/data/repositories/auth_repo.dart';
import 'package:gdg_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gdg_app/features/quiz/data/repositories/quiz_repos.dart';
import 'package:gdg_app/features/quiz/presentation/cubit/quiz_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(authRepo: getIt.get<AuthRepoImpl>()),
          ),
          BlocProvider(
            create: (context) => QuizCubit(
              quizRepos: getIt.get<QuizReposImpl>(),
            ),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: Routes.login,
        ),
      ),
    );
  }
}
