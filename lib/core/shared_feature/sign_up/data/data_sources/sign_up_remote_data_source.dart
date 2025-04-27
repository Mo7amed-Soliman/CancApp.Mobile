import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/core/networking/upload_image_to_api.dart';
import 'package:canc_app/core/shared_feature/sign_up/data/models/sign_up_model.dart';
import 'package:image_picker/image_picker.dart';

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
        ApiConstantForm.name: signUpModel.name,
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
    /// sign up request
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
}
