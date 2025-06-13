import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class CommentInputField extends StatefulWidget {
  const CommentInputField({
    super.key,
    required this.postId,
    required this.onCommentAdded,
  });

  final int postId;
  final void Function(String content) onCommentAdded;

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _commentController = TextEditingController();
  bool _canSubmit = false;
  bool _isSubmitting = false;

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
      final content = _commentController.text.trim();
      widget.onCommentAdded(content);
      _commentController.clear();
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
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: false,
              controller: _commentController,
              focusNode: FocusNode(),
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                hintStyle: AppTextStyle.font14RegularDarkGray(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.lightGray,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.setWidth(16),
                  vertical: context.setHeight(8),
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.newline,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              Icons.send,
              color: _canSubmit ? AppColors.primaryColor : AppColors.grayish,
            ),
            onPressed: _canSubmit ? _submitComment : null,
          ),
        ],
      ),
    );
  }
}
