import 'dart:io';

import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../../manager/community_cubit.dart';

class CreatePostViewContent extends StatelessWidget {
  final PostModel? post;
  final TextEditingController postController;
  final File? pickedImage;
  final bool isPosting;
  final Function(ImageSource) onPickImage;
  final VoidCallback onRemoveImage;
  final VoidCallback onSubmitPost;
  final bool isPostValid;
  final Function(String) onChangeText;
  final String? imageUrl;

  const CreatePostViewContent({
    super.key,
    required this.post,
    required this.postController,
    required this.pickedImage,
    required this.isPosting,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.onSubmitPost,
    required this.isPostValid,
    required this.onChangeText,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final user = UserCacheHelper.getUser();
    final isEditMode = post != null;

    return BlocListener<CommunityCubit, CommunityState>(
      listener: (context, state) {
        if (state is CommunityPostAdded) {
          Navigator.pop(context);
        } else if (state is CommunityPostUpdated) {
          Navigator.pop(context, post);
        } else if (state is CommunityPostsError) {
          botTextToast(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.offWhite,
          title: Text(
            isEditMode ? 'Edit Post' : 'Create Post',
            style: AppTextStyle.font19MediumDarkGray(context).copyWith(
              color: AppColors.darkGray,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              isArabic() ? IconlyLight.arrow_right_2 : IconlyLight.arrow_left_2,
              color: AppColors.darkGray,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextButton(
                onPressed: isPostValid && !isPosting ? onSubmitPost : null,
                style: TextButton.styleFrom(
                  backgroundColor: isPostValid
                      ? AppColors.primaryColor
                      : Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isPosting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        isEditMode ? 'Update' : 'Post',
                        style: AppTextStyle.font15Bold(context).copyWith(
                          color: isPostValid
                              ? AppColors.offWhite
                              : Colors.grey.shade400,
                        ),
                      ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // TODO: change to user image
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user?.name ?? '',
                    style: AppTextStyle.font17Medium(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: postController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Anything on your mind ?\nLet it out here.',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 18),
                        onChanged: onChangeText,
                      ),
                      if (pickedImage != null || imageUrl != null) ...[
                        const SizedBox(height: 16),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: pickedImage != null
                                  ? Image.file(pickedImage!)
                                  : Image.network(imageUrl!),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: onRemoveImage,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _iconButton(
                    icon: IconlyLight.image,
                    backgroundColor: Colors.green.shade50,
                    iconColor: Colors.green,
                    onPressed: () => onPickImage(ImageSource.gallery),
                  ),
                  const SizedBox(width: 10),
                  _iconButton(
                    icon: IconlyLight.camera,
                    backgroundColor: Colors.red.shade50,
                    iconColor: Colors.red,
                    onPressed: () => onPickImage(ImageSource.camera),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Icon(
          icon,
          color: iconColor,
          size: 28,
        ),
      ),
    );
  }
}
