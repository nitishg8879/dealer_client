import 'package:bike_client_dealer/src/domain/use_cases/auth/login_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/auth/logout_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase _loginUsecase;
  final LogoutUsecase _logoutUsecase;
  AuthCubit(this._loginUsecase, this._logoutUsecase) : super(AuthProcessing(false));

  Future<void> login() async {
    // if (state is AuthProcessing && (state as AuthProcessing).isLoading) return;
    emit(AuthProcessing(true));
    final resp = await _loginUsecase.call();
    emit(AuthProcessing(false));
  }
}
