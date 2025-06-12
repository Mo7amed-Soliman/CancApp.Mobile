import 'dart:io';

import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  File? _pickedImage;
  final TextEditingController _postController = TextEditingController();
  bool _isPosting = false;
  final CommunityRepository _repository = getIt<CommunityRepository>();

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  bool get _isPostValid {
    return _postController.text.trim().isNotEmpty;
  }

  Future<void> _submitPost() async {
    if (!_isPostValid) return;

    setState(() {
      _isPosting = true;
    });

    try {
      final result = await _repository.addPost(
        content: _postController.text.trim(),
        userId: UserCacheHelper.getUser()?.id ?? '',
        image: _pickedImage != null ? XFile(_pickedImage!.path) : null,
      );

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(failure.errorMessage)),
            );
          }
        },
        (_) {
          if (mounted) {
            context.pop();
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPosting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserCacheHelper.getUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        title: Text(
          'Create Post',
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
              onPressed: _isPostValid && !_isPosting ? _submitPost : null,
              style: TextButton.styleFrom(
                backgroundColor: _isPostValid
                    ? AppColors.primaryColor
                    : Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isPosting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Post',
                      style: AppTextStyle.font15Bold(context).copyWith(
                        color: _isPostValid
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
                // CircleAvatar(
                //   radius: 24,
                //   backgroundImage: NetworkImage(
                //     user?.image ?? '',
                //   ),
                // ),
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
                      controller: _postController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Anything on your mind ?\nLet it out here.',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 18),
                      onChanged: (_) => setState(() {}),
                    ),
                    if (_pickedImage != null) ...[
                      const SizedBox(height: 16),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_pickedImage!),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: _removeImage,
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
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
                const SizedBox(width: 10),
                _iconButton(
                  icon: IconlyLight.camera,
                  backgroundColor: Colors.red.shade50,
                  iconColor: Colors.red,
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
          ],
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
