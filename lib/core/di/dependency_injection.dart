import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/database/secure_cache_helper.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/dio_consumer.dart';
import 'package:canc_app/core/services/refresh_token_service.dart';
import 'package:canc_app/core/services/token_service.dart';
import 'package:canc_app/core/shared_feature/login/data/data_sources/login_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/login/data/repositories/login_repository.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/manger/forgot_password_cubit.dart';
import 'package:canc_app/core/shared_feature/login/data/repositories/login_repository_impl.dart';
import 'package:canc_app/core/shared_feature/login/presentation/manger/login_cubit.dart';
import 'package:canc_app/core/shared_feature/otp/data/data_sources/otp_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/otp/data/repositories/otp_repository.dart';
import 'package:canc_app/core/shared_feature/otp/data/repositories/otp_repository_impl.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/repositories/sign_up_repository.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/manger/sign_up_cubit.dart';
import 'package:canc_app/users/patient/home/data/data_sources/nearest_pharmacy_data_source.dart';
import 'package:canc_app/users/patient/home/data/repositories/nearest_pharmacy_repository.dart';
import 'package:canc_app/users/patient/home/presentation/manger/nearest_pharmacy_cubit/nearest_pharmacy_cubit.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/medication_reminder_data_source_impl.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/visit_reminder_data_source_impl.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/medication_reminder_repository.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/medication_reminder_repository_impl.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/visit_reminder_repository.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/visit_reminder_repository_impl.dart';
import 'package:canc_app/users/patient/reminder/presentation/manger/medication_reminder_cubit/medication_reminder_cubit.dart';
import 'package:canc_app/users/patient/reminder/presentation/manger/visit_reminder_cubit/visit_reminder_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  //! Core
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerLazySingleton<SecureCacheHelper>(() => SecureCacheHelper());
  getIt.registerLazySingleton<TokenService>(() => TokenService());
  getIt.registerLazySingleton<RefreshTokenService>(() => RefreshTokenService(
        dio: getIt<Dio>(),
        tokenService: getIt<TokenService>(),
      ));

  //! Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  //! login cubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit(
        loginRepository: getIt<LoginRepository>(),
      ));

  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        loginDataSource: getIt<LoginRemoteDataSource>(),
      ));
  getIt
      .registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSource(
            apiConsumer: getIt<ApiConsumer>(),
          ));

  getIt.registerFactory<ApiConsumer>(() => DioConsumer(
        dio: getIt<Dio>(),
      ));

  //! sign up cubit
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(
        signUpRepository: getIt<SignUpRepository>(),
      ));
  getIt.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImpl(
        signUpDataSource: getIt<SignUpRemoteDataSource>(),
      ));
  getIt.registerLazySingleton<SignUpRemoteDataSource>(
      () => SignUpRemoteDataSource(
            apiConsumer: getIt<ApiConsumer>(),
          ));
  //! otp Repository
  getIt.registerLazySingleton<OtpRepository>(() => OtpRepositoryImpl(
        otpRemoteDataSource: getIt<OtpRemoteDataSource>(),
      ));
  getIt.registerLazySingleton<OtpRemoteDataSource>(() => OtpRemoteDataSource(
        apiConsumer: getIt<ApiConsumer>(),
      ));

  //! forgot password cubit
  getIt.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit());

  //! medication reminder cubit
  getIt.registerFactory<MedicationReminderCubit>(() => MedicationReminderCubit(
        getIt<MedicationReminderRepository>(),
      ));

  //! visit reminder cubit
  getIt.registerFactory<VisitReminderCubit>(() => VisitReminderCubit(
        getIt<VisitReminderRepository>(),
      ));

  getIt.registerLazySingleton<MedicationReminderRepository>(
      () => MedicationReminderRepositoryImpl(
            MedicationReminderDataSourceImpl(),
          ));

  //! visit reminder repository
  getIt.registerLazySingleton<VisitReminderRepository>(
      () => VisitReminderRepositoryImpl(
            VisitReminderDataSourceImpl(),
          ));

  //! nearest pharmacy cubit
  getIt.registerFactory<NearestPharmacyCubit>(() => NearestPharmacyCubit(
        repository: getIt<NearestPharmacyRepository>(),
      ));

  //! nearest pharmacy repository
  getIt.registerLazySingleton<NearestPharmacyRepository>(
      () => NearestPharmacyRepositoryImpl(
            dataSource: NearestPharmacyDataSourceImpl(
              dio: getIt<Dio>(),
            ),
          ));
}
