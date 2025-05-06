import 'dart:io';

import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/networking/api_consumer.dart';
import 'package:canc_app/core/shared_feature/community/data/data_sources/community_data_source.dart';
import 'package:canc_app/core/shared_feature/community/manager/post_cubit.dart';
import 'package:canc_app/core/shared_feature/community/manager/post_state.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post_content_field.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post_image_picker.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post_image_preview.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository_impl.dart';
import 'package:canc_app/core/shared_feature/community/data/data_sources/community_remote_data_source.dart';

class CreatePostView extends StatefulWidget {
  final PostModel? post; // If null, create; if not, edit

  const CreatePostView({Key? key, this.post}) : super(key: key);

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  late TextEditingController _contentController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(
      text: widget.post?.content ?? '',
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
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

  void _submit() {
    final content = _contentController.text.trim();
    if (content.isEmpty) return;

    if (widget.post == null) {
      context.read<PostCubit>().createPost(
            content,
            _imagePath ?? '',
          );
    } else {
      context.read<PostCubit>().updatePost(
            widget.post!.id,
            content,
            _imagePath ?? '',
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.post != null;
    return BlocProvider(
      create: (context) => PostCubit(
        repository: CommunityRepositoryImpl(
          dataSource: CommunityRemoteDataSource(
            apiConsumer: getIt<ApiConsumer>(),
          ),
        ),
      ),
      child: Builder(builder: (context) {
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
              title: Text(isEdit ? 'Edit Post' : 'Create Post'),
              backgroundColor: AppColors.offWhite,
              actions: [
                TextButton(
                  onPressed: _submit,
                  child: Text(
                    isEdit ? 'Save' : 'Post',
                    style: AppTextStyle.font15Medium(context).copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  PostContentField(controller: _contentController),
                  const SizedBox(height: 16),
                  if (_imagePath != null)
                    PostImagePreview(
                      imagePath: _imagePath!,
                      onRemove: () => setState(() => _imagePath = null),
                    ),
                  const Spacer(),
                  PostImagePicker(onPickImage: _pickImage),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
