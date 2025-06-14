import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';

abstract class NearestPharmacyDataSource {
  Future<List<NearestPharmacyModel>> getNearestPharmacies({
    required double latitude,
    required double longitude,
  });
}

class NearestPharmacyDataSourceImpl implements NearestPharmacyDataSource {
  final ApiConsumer apiConsumer;

  NearestPharmacyDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<NearestPharmacyModel>> getNearestPharmacies({
    required double latitude,
    required double longitude,
  }) async {
    final response = await apiConsumer.get(
      EndPoint.getNearestPharmacies,
      data: {
        'latitude': latitude,
        'longitude': longitude,
      },
    );

    return (response as List)
        .map((item) => NearestPharmacyModel.fromJson(item))
        .toList();
  }
}
