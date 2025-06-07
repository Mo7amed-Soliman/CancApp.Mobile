import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class CommentInputField extends StatefulWidget {
  const CommentInputField({
    super.key,
    this.replyTo,
    required this.postId,
    this.onCommentAdded,
  });

  final String? replyTo;
  final int postId;
  final VoidCallback? onCommentAdded;

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _commentController = TextEditingController();
  bool _canSubmit = false;
  bool _isSubmitting = false;
  final CommunityRepository _repository = getIt<CommunityRepository>();

  @override
  void initState() {
    super.initState();
    _commentController.addListener(_updateSubmitState);
  }

  @override
  void dispose() {
    _commentController.removeListener(_updateSubmitState);
    _commentController.dispose();
    super.dispose();
  }

  void _updateSubmitState() {
    final canSubmit = _commentController.text.trim().isNotEmpty;
    if (canSubmit != _canSubmit) {
      setState(() {
        _canSubmit = canSubmit;
      });
    }
  }

  Future<void> _submitComment() async {
    if (!_canSubmit || _isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final result = await _repository.addComment(
        postId: widget.postId,
        userId: UserCacheHelper.getUser()?.id ?? '',
        content: _commentController.text.trim(),
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
            _commentController.clear();
            widget.onCommentAdded?.call();
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
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(16),
        vertical: context.setHeight(8),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                hintStyle: AppTextStyle.font14RegularDarkGray(context),
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ),
          IconButton(
            onPressed: _isSubmitting ? null : _submitComment,
            icon: _isSubmitting
                ? SizedBox(
                    width: context.setMinSize(20),
                    height: context.setMinSize(20),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(
                    Icons.send,
                    color: AppColors.primaryColor,
                  ),
          ),
        ],
      ),
    );
  }
}
