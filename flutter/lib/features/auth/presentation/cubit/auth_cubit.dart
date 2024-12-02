import 'package:bloc/bloc.dart';
import 'package:gdg_app/features/auth/data/models/user_model.dart';
import 'package:gdg_app/features/auth/data/repositories/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({
    required this.authRepo,
  }) : super(AuthInitial());
  Future login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    var result = await authRepo.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(LoginFailureState(errorMessage: failure.errorMessage)),
      (authModel) => emit(
        LoginSuccessState(userModel: authModel),
      ),
    );
  }

  Future register(
      {required String email,
      required String password,
      required String gender,
      required String name}) async {
    emit(RegisterLoadingState());
    var result = await authRepo.register(
      email: email,
      password: password,
      name: name,
      gender: gender,
    );
    result.fold(
      (failure) =>
          emit(RegisterFailureState(errorMessage: failure.errorMessage)),
      (authModel) => emit(
        RegisterSuccessState(userModel: authModel),
      ),
    );
  }
}
