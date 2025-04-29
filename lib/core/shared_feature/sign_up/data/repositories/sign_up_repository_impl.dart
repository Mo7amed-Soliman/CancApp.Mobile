import 'dart:developer';

import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/models/complete_pharmacy_registration_model.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/models/sign_up_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import 'sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource _signUpDataSource;

  SignUpRepositoryImpl({
    required SignUpRemoteDataSource signUpDataSource,
  }) : _signUpDataSource = signUpDataSource;

  @override
  Future<Either<Failure, void>> signUp({
    required SignUpModel signUpModel,
  }) async {
    try {
      await _signUpDataSource.signUp(
        signUpModel: signUpModel,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeDoctorSignUp(
      {required XFile idPhoto, required XFile syndicatePhoto}) async {
    try {
      await _signUpDataSource.completeDoctorSignUp(
        idPhoto: idPhoto,
        syndicatePhoto: syndicatePhoto,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completePharmacySignUp(
      {required CompletePharmacyModel pharmacyModel}) async {
    try {
      await _signUpDataSource.completePharmacySignUp(
        pharmacyModel: pharmacyModel,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }
}
