import 'package:canc_app/core/networking/api_faliure.dart';
import 'package:canc_app/users/patient/home/data/data_sources/nearest_pharmacy_data_source.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:dartz/dartz.dart';

abstract class NearestPharmacyRepository {
  Future<Either<Failure, List<NearestPharmacyModel>>> getNearestPharmacies({
    required double latitude,
    required double longitude,
  });
}

class NearestPharmacyRepositoryImpl implements NearestPharmacyRepository {
  final NearestPharmacyDataSource dataSource;

  NearestPharmacyRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<NearestPharmacyModel>>> getNearestPharmacies({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final pharmacies = await dataSource.getNearestPharmacies(
        latitude: latitude,
        longitude: longitude,
      );
      return Right(pharmacies);
    } on ServerFailure catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure('An unexpected error occurred'));
    }
  }
}
