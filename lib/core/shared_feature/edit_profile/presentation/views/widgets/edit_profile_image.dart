import 'dart:io';

import 'package:canc_app/core/widgets/image_source_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/edit_profile_cubit.dart';
import '../../manager/edit_profile_state.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage({super.key});

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
                    File? image;
                    if (state is EditProfileImageChanged) {
                      image = state.image;
                    } else if (state is EditProfileInitial &&
                        state.image != null) {
                      image = state.image;
                    }

                    return GestureDetector(
                      onTap: () => _showImageSourceSelector(context),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 63,
                          backgroundImage: image != null
                              ? FileImage(image)
                              : const AssetImage(
                                  'assets/images/dummy_image/img4.png',
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
