import 'dart:developer';

import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/models/user_model.dart';
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
    final response = await apiConsumer.put(
      EndPoint.updateProfile,
      isFromData: true,
      data: {
        ApiConstantForm.name: profile.name,
        ApiConstantForm.address: profile.address,
        if (profile.image != null)
          ApiConstantForm.imageFile: await uploadImageToAPI(profile.image!),
      },
    );

    final user = UserCacheHelper.getUser();
    log('${user?.name} ${user?.address}');
    final userModel = UserModel(
      id: user?.id ?? '',
      name: profile.name ?? user?.name ?? '',
      address: profile.address ?? user?.address ?? '',
      image: response['image'] ?? user?.image ?? '',
      email: user?.email ?? '',
      userName: user?.userName ?? '',
      userType: user?.userType ?? '',
    );

    await UserCacheHelper.updateUser(userModel);
  }
}
