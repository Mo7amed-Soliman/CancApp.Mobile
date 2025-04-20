import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:canc_app/core/shared_feature/forgot_password/presentation/manger/forgot_password_cubit.dart';
import 'package:canc_app/core/shared_feature/login/presentation/manger/login_cubit.dart';
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
void setupGetIt() {
  // cache helper
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  // login cubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit());
  // sign up cubit
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit());
  // forgot password cubit
  getIt.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit());

  // medication reminder cubit
  getIt.registerFactory<MedicationReminderCubit>(() => MedicationReminderCubit(
        getIt<MedicationReminderRepository>(),
      ));

  // visit reminder cubit
  getIt.registerFactory<VisitReminderCubit>(() => VisitReminderCubit(
        getIt<VisitReminderRepository>(),
      ));

  getIt.registerLazySingleton<MedicationReminderRepository>(
      () => MedicationReminderRepositoryImpl(
            MedicationReminderDataSourceImpl(),
          ));

  // visit reminder repository
  getIt.registerLazySingleton<VisitReminderRepository>(
      () => VisitReminderRepositoryImpl(
            VisitReminderDataSourceImpl(),
          ));

  // nearest pharmacy cubit
  getIt.registerFactory<NearestPharmacyCubit>(() => NearestPharmacyCubit(
        repository: getIt<NearestPharmacyRepository>(),
      ));

  // nearest pharmacy repository
  getIt.registerLazySingleton<NearestPharmacyRepository>(
      () => NearestPharmacyRepositoryImpl(
            dataSource: NearestPharmacyDataSourceImpl(
              dio: getIt<Dio>(),
            ),
          ));

  // dio
  getIt.registerLazySingleton<Dio>(() => Dio());
}
