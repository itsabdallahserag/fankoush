import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void toggleRememberMe([bool? value]) {
    emit(state.copyWith(rememberMe: value ?? !state.rememberMe));
  }

  void selectCountry(String country) {
    emit(state.copyWith(selectedCountry: country));
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      // Simulate / perform login request
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'حدث خطأ أثناء تسجيل الدخول، يرجى المحاولة مرة أخرى',
      ));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String country,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      // Simulate / perform register request
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'حدث خطأ أثناء إنشاء الحساب، يرجى المحاولة مرة أخرى',
      ));
    }
  }
}
