import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/core/networking/upload_image_to_api.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/models/sign_up_model.dart';
import 'package:image_picker/image_picker.dart';

import '../models/complete_pharmacy_registration_model.dart';

class SignUpRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SignUpRemoteDataSource({
    required ApiConsumer apiConsumer,
  }) : _apiConsumer = apiConsumer;

  Future<void> signUp({
    required SignUpModel signUpModel,
  }) async {
    /// sign up request
    await _apiConsumer.post(
      EndPoint.signUp,
      isFromData: true,
      data: {
        ApiConstantForm.email: signUpModel.email,
        ApiConstantForm.password: signUpModel.password,
        ApiConstantForm.fullName: signUpModel.name,
        ApiConstantForm.address: signUpModel.address,
        ApiConstantForm.image: signUpModel.image,
        ApiConstantForm.userType: signUpModel.userType,
      },
    );
  }

  Future<void> completeDoctorSignUp({
    required XFile idPhoto,
    required XFile syndicatePhoto,
  }) async {
    await _apiConsumer.post(
      EndPoint.completeDoctorSignUp,
      isFromData: true,
      data: {
        ApiConstantForm.email: UserCacheHelper.getUser()?.email,
        ApiConstantForm.medicalSyndicatePhoto:
            await uploadImageToAPI(syndicatePhoto),
        ApiConstantForm.imageId: await uploadImageToAPI(idPhoto),
      },
    );
  }

  Future<void> completePharmacySignUp({
    required CompletePharmacyModel pharmacyModel,
  }) async {
    await _apiConsumer.post(
      EndPoint.completePharmacySignUp,
      isFromData: true,
      data: {
        ApiConstantForm.email: UserCacheHelper.getUser()?.email,
        ApiConstantForm.pharmacyLicensePhoto:
            await uploadImageToAPI(pharmacyModel.pharmacyLicensePhoto),
        ApiConstantForm.imageId: await uploadImageToAPI(pharmacyModel.idPhoto),
        ApiConstantForm.isDeliveryEnabled: pharmacyModel.isDeliveryEnabled,
        ApiConstantForm.numberOfWorkingHours:
            pharmacyModel.numberOfWorkingHours,
        ApiConstantForm.latitude: pharmacyModel.location.latitude,
        ApiConstantForm.longitude: pharmacyModel.location.longitude,
        ApiConstantForm.clouseHour: pharmacyModel.closeHour.toString(),
        ApiConstantForm.openHour: pharmacyModel.openHour.toString(),
      },
    );
  }
}
