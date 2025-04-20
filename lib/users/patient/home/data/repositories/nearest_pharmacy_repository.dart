import 'package:canc_app/users/patient/home/data/data_sources/nearest_pharmacy_data_source.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:dartz/dartz.dart';

abstract class NearestPharmacyRepository {
  Future<Either<Exception, List<Pharmacy>>> getNearestPharmacies();
}

class NearestPharmacyRepositoryImpl implements NearestPharmacyRepository {
  final NearestPharmacyDataSource dataSource;

  NearestPharmacyRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Exception, List<Pharmacy>>> getNearestPharmacies() async {
    try {
      final pharmacies = await dataSource.getNearestPharmacies();
      return Right(pharmacies);
    } catch (e) {
      return Left(Exception('Failed to fetch pharmacies: $e'));
    }
  }
}
