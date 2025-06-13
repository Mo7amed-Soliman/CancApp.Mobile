import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/helpers/database/secure_cache_helper.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/dio_consumer.dart';
import 'package:canc_app/core/services/refresh_token_service.dart';
import 'package:canc_app/core/services/token_service.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manager/community_cubit/community_cubit.dart';
import 'package:canc_app/core/shared_feature/forgot_password/data/data_sources/forget_password_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/forgot_password/data/repositories/forget_password_repository.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:canc_app/core/shared_feature/login/data/data_sources/login_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/login/data/repositories/login_repository.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/manager/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:canc_app/core/shared_feature/login/data/repositories/login_repository_impl.dart';
import 'package:canc_app/core/shared_feature/login/presentation/manager/login_cubit.dart';
import 'package:canc_app/core/shared_feature/otp/data/data_sources/otp_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/otp/data/repositories/otp_repository.dart';
import 'package:canc_app/core/shared_feature/otp/data/repositories/otp_repository_impl.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/repositories/sign_up_repository.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/manager/complete_pharmacy_registration_cubit/complete_pharmacy_registration_cubit.dart';
import 'package:canc_app/core/shared_feature/sign_up/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:canc_app/users/patient/chatbot/data/data_sources/chatbot_remote_data_source.dart';
import 'package:canc_app/users/patient/chatbot/data/repositories/chatbot_repository.dart';
import 'package:canc_app/users/patient/home/data/data_sources/nearest_pharmacy_data_source.dart';
import 'package:canc_app/users/patient/home/data/repositories/nearest_pharmacy_repository.dart';
import 'package:canc_app/users/patient/home/presentation/manager/nearest_pharmacy_cubit/nearest_pharmacy_cubit.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/medication_reminder_data_source_impl.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/visit_reminder_data_source_impl.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/medication_reminder_repository.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/medication_reminder_repository_impl.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/visit_reminder_repository.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/visit_reminder_repository_impl.dart';
import 'package:canc_app/users/patient/reminder/presentation/manager/medication_reminder_cubit/medication_reminder_cubit.dart';
import 'package:canc_app/users/patient/reminder/presentation/manager/visit_reminder_cubit/visit_reminder_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:canc_app/core/shared_feature/community/data/data_sources/community_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository_impl.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manager/comment_cubit/comment_cubit.dart';
import 'package:canc_app/core/shared_feature/change_password/data/datasources/change_password_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:canc_app/core/shared_feature/change_password/presentation/manager/change_password_cubit.dart';
import 'package:canc_app/core/shared_feature/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:canc_app/core/shared_feature/edit_profile/data/datasources/edit_profile_remote_data_source.dart';

import '../../users/patient/chatbot/data/repositories/chatbot_repository_impl.dart';
import '../../users/patient/chatbot/presentation/manager/chat_bot_cubit.dart';
import '../shared_feature/sign_up/presentation/manager/complete_doctor_registration_cubit/complete_doctor_registration_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  //! Core - Lazy singletons for core services
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerLazySingleton<SecureCacheHelper>(() => SecureCacheHelper());
  getIt.registerLazySingleton<TokenService>(() => TokenService());
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt
      .registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()));
  getIt.registerLazySingleton<RefreshTokenService>(() => RefreshTokenService(
        dio: getIt<Dio>(),
        tokenService: getIt<TokenService>(),
      ));

  //! Repositories - Lazy singletons for data access
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        loginDataSource: getIt<LoginRemoteDataSource>(),
      ));
  getIt.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImpl(
        signUpDataSource: getIt<SignUpRemoteDataSource>(),
      ));
  getIt.registerLazySingleton<OtpRepository>(() => OtpRepositoryImpl(
        otpRemoteDataSource: getIt<OtpRemoteDataSource>(),
      ));
  getIt.registerLazySingleton<ForgetPasswordRepository>(
      () => ForgetPasswordRepositoryImpl(
            remoteDataSource: getIt<ForgetPasswordRemoteDataSource>(),
          ));
  getIt.registerLazySingleton<MedicationReminderRepository>(
      () => MedicationReminderRepositoryImpl(
            MedicationReminderDataSourceImpl(),
          ));
  getIt.registerLazySingleton<VisitReminderRepository>(
      () => VisitReminderRepositoryImpl(
            VisitReminderDataSourceImpl(),
          ));
  getIt.registerLazySingleton<NearestPharmacyRepository>(
      () => NearestPharmacyRepositoryImpl(
            dataSource: NearestPharmacyDataSourceImpl(
              apiConsumer: getIt<ApiConsumer>(),
            ),
          ));
  getIt.registerLazySingleton<ChatBotRepository>(() => ChatbotRepositoryImpl(
        dataSource: ChatbotRemoteDataSource(
          dio: getIt<Dio>(),
        ),
      ));
  getIt
      .registerLazySingleton<CommunityRepository>(() => CommunityRepositoryImpl(
            dataSource: CommunityRemoteDataSource(
              apiConsumer: getIt<ApiConsumer>(),
            ),
          ));
  getIt.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepository(
            remoteDataSource: getIt<ChangePasswordRemoteDataSource>(),
          ));
  getIt.registerLazySingleton<EditProfileRepository>(
      () => EditProfileRepositoryImpl(
            remoteDataSource: getIt<EditProfileRemoteDataSource>(),
          ));

  //! Data Sources - Lazy singletons for remote data
  getIt
      .registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSource(
            apiConsumer: getIt<ApiConsumer>(),
          ));
  getIt.registerLazySingleton<SignUpRemoteDataSource>(
      () => SignUpRemoteDataSource(
            apiConsumer: getIt<ApiConsumer>(),
          ));
  getIt.registerLazySingleton<OtpRemoteDataSource>(() => OtpRemoteDataSource(
        apiConsumer: getIt<ApiConsumer>(),
      ));
  getIt.registerLazySingleton<ForgetPasswordRemoteDataSource>(
      () => ForgetPasswordRemoteDataSource(
            apiConsumer: getIt<ApiConsumer>(),
          ));
  getIt.registerLazySingleton<ChangePasswordRemoteDataSource>(
      () => ChangePasswordRemoteDataSourceImpl(
            apiConsumer: getIt<ApiConsumer>(),
          ));
  getIt.registerLazySingleton<EditProfileRemoteDataSource>(
      () => EditProfileRemoteDataSourceImpl(
            apiConsumer: getIt<ApiConsumer>(),
          ));

  //! Cubits - Factories for UI state management
  getIt.registerFactory<LoginCubit>(() => LoginCubit(
        loginRepository: getIt<LoginRepository>(),
      ));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(
        signUpRepository: getIt<SignUpRepository>(),
      ));
  getIt.registerFactory<CompleteDoctorRegistrationCubit>(
    () => CompleteDoctorRegistrationCubit(
      signUpRepository: getIt<SignUpRepository>(),
    ),
  );
  getIt.registerFactory<CompletePharmacyRegistrationCubit>(
    () => CompletePharmacyRegistrationCubit(
      signUpRepository: getIt<SignUpRepository>(),
    ),
  );
  getIt.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(
        forgetPasswordRepository: getIt<ForgetPasswordRepository>(),
      ));
  getIt.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(
        forgetPasswordRepository: getIt<ForgetPasswordRepository>(),
      ));
  getIt.registerFactory<MedicationReminderCubit>(() => MedicationReminderCubit(
        getIt<MedicationReminderRepository>(),
      ));
  getIt.registerFactory<VisitReminderCubit>(() => VisitReminderCubit(
        getIt<VisitReminderRepository>(),
      ));
  getIt.registerFactory<NearestPharmacyCubit>(() => NearestPharmacyCubit(
        repository: getIt<NearestPharmacyRepository>(),
      ));
  getIt.registerFactory<ChatBotCubit>(() => ChatBotCubit(
        chatbotRepository: getIt<ChatBotRepository>(),
      ));
  getIt.registerFactory<CommunityCubit>(() => CommunityCubit(
        getIt<CommunityRepository>(),
      ));
  getIt.registerFactory<CommentCubit>(() => CommentCubit(
        getIt<CommunityRepository>(),
      ));
  getIt.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(
        changePasswordRepository: getIt<ChangePasswordRepository>(),
      ));
}
