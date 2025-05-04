import 'dart:io';

import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/shared_feature/community/manager/post_cubit.dart';
import 'package:canc_app/core/shared_feature/community/manager/post_state.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _controller = TextEditingController();
  String? _imagePath;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  void _submitPost() {
    if (_controller.text.trim().isEmpty) return;

    context.read<PostCubit>().createPost(
          _controller.text.trim(),
          'current_user_id', // Replace with actual user ID
          image: _imagePath,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostCubit, PostState>(
      listener: (context, state) {
        if (state is PostCreated) {
          Navigator.pop(context);
        } else if (state is PostError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Post',
            style: AppTextStyle.font19MediumDarkGray(context),
          ),
          backgroundColor: AppColors.offWhite,
          actions: [
            BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: state is PostLoading ? null : _submitPost,
                  child: Text(
                    'Post',
                    style: AppTextStyle.font15Medium(context).copyWith(
                      color: state is PostLoading
                          ? AppColors.darkGray.withOpacity(0.5)
                          : AppColors.primaryColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'What\'s on your mind?',
                  border: InputBorder.none,
                  hintStyle: AppTextStyle.font15Medium(context).copyWith(
                    color: AppColors.darkGray.withOpacity(0.5),
                  ),
                ),
                style: AppTextStyle.font15Medium(context),
                maxLines: null,
              ),
              const SizedBox(height: 16),
              if (_imagePath != null)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(_imagePath!),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        onPressed: () => setState(() => _imagePath = null),
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(
                      Icons.image,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    'Add Photo',
                    style: AppTextStyle.font15Medium(context).copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
