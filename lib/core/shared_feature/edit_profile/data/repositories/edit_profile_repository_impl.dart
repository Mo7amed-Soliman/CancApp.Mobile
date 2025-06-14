import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/core/shared_feature/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:canc_app/core/shared_feature/edit_profile/data/models/edit_profile_model.dart';
import 'package:dartz/dartz.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, void>> updateProfile(EditProfileModel profile);
}

class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSource remoteDataSource;

  EditProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> updateProfile(EditProfileModel profile) async {
    try {
      await remoteDataSource.updateProfile(profile);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
