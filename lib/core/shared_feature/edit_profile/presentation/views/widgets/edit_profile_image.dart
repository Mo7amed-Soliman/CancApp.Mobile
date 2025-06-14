import 'dart:io';

import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/widgets/image_source_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/edit_profile_cubit.dart';
import '../../manager/edit_profile_state.dart';

class EditProfileImage extends StatefulWidget {
  const EditProfileImage({super.key});

  @override
  State<EditProfileImage> createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  File? image;

  void _showImageSourceSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return ImageSourcePicker(
          onImageSourceSelected: (source) {
            context.read<EditProfileCubit>().pickImage(source: source);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          bottom: -70,
          left: 0,
          right: 0,
          child: Center(
            child: Stack(
              children: [
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    if (state is EditProfileImageChanged) {
                      image = File(state.image.path);
                    } else if (state is EditProfileInitial &&
                        state.image != null) {
                      image = File(state.image!.path);
                    }

                    return GestureDetector(
                      onTap: () => _showImageSourceSelector(context),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 63,
                          backgroundImage: image != null
                              ? FileImage(image!)
                              : NetworkImage(
                                  UserCacheHelper.getUser()?.image ?? '',
                                ) as ImageProvider,
                        ),
                      ),
                    );
                  },
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.camera_alt, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
