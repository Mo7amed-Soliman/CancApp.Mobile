import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/manger/forgot_password_cubit.dart';
import 'package:canc_app/core/shared_feature/login/presentation/manger/login_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupGetIt() {
  // cache helper
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  // login cubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit());
  // forgot password cubit
  getIt.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit());
}
