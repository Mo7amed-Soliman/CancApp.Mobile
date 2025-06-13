import 'dart:io';

import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manager/community_cubit/community_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/create_post_view_content.dart';

class CreatePostView extends StatefulWidget {
  final PostModel? post;

  const CreatePostView({
    super.key,
    this.post,
  });

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  File? _pickedImage;
  String? _imageUrl;
  final TextEditingController _postController = TextEditingController();
  bool _isPosting = false;
  bool _isPostValid = false;

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _postController.text = widget.post!.content;
      _imageUrl = widget.post!.imageUrl;
    }
  }

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

  Future<void> _submitPost() async {
    if (!_isPostValid) return;

    setState(() {
      _isPosting = true;
    });

    final userId = UserCacheHelper.getUser()?.id ?? '';
    final content = _postController.text.trim();
    final image = _pickedImage != null ? XFile(_pickedImage!.path) : null;

    if (widget.post != null) {
      // Update existing post
      context.read<CommunityCubit>().updatePost(
            id: widget.post!.id.toString(),
            content: content,
            userId: userId,
            image: image,
          );
    } else {
      // Create new post
      context.read<CommunityCubit>().addPost(
            content: content,
            userId: userId,
            image: image,
          );
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CreatePostViewContent(
      post: widget.post,
      postController: _postController,
      pickedImage: _pickedImage,
      imageUrl: _imageUrl,
      isPosting: _isPosting,
      onPickImage: _pickImage,
      onRemoveImage: _removeImage,
      onSubmitPost: _submitPost,
      isPostValid: _isPostValid,
      onChangeText: (text) {
        if (text.trim().isNotEmpty && text.trim().length > 1) {
          setState(() {
            _isPostValid = true;
          });
        } else {
          setState(() {
            _isPostValid = false;
          });
        }
      },
    );
  }
}
