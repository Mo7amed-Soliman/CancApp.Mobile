import 'dart:developer';

import 'package:canc_app/core/networking/api_constant.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/networking/end_point.dart';
import 'package:canc_app/core/networking/upload_image_to_api.dart';
import 'package:canc_app/core/shared_feature/edit_profile/data/models/edit_profile_model.dart';

abstract class EditProfileRemoteDataSource {
  Future<void> updateProfile(EditProfileModel profile);
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ApiConsumer apiConsumer;

  EditProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<void> updateProfile(EditProfileModel profile) async {
    log('Sending profile update to: ${profile.name} ${profile.address} ${profile.image?.path}');
    await apiConsumer.put(
      EndPoint.updateProfile,
      isFromData: true,
      data: {
        ApiConstantForm.name: profile.name,
        ApiConstantForm.address: profile.address,
        if (profile.image != null)
          ApiConstantForm.image: await uploadImageToAPI(profile.image!),
      },
    );
  }
}
