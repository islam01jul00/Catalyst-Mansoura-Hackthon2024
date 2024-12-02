part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserModel userModel;
  LoginSuccessState({required this.userModel});
}

class LoginFailureState extends AuthState {
  final String errorMessage;
  LoginFailureState({required this.errorMessage});
}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final UserModel userModel;
  RegisterSuccessState({required this.userModel});
}

class RegisterFailureState extends AuthState {
  final String errorMessage;
  RegisterFailureState({required this.errorMessage});
}
