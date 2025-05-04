import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CommentInputField extends StatefulWidget {
  final String postId;
  final Function(String, String) onCommentAdded;

  const CommentInputField({
    super.key,
    required this.postId,
    required this.onCommentAdded,
  });

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    if (_controller.text.trim().isEmpty || _isLoading) return;

    setState(() => _isLoading = true);
    try {
      await widget.onCommentAdded(
        _controller.text.trim(),
        'current_user_id', // Replace with actual user ID
      );
      _controller.clear();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                border: InputBorder.none,
                hintStyle: AppTextStyle.font15Medium(context).copyWith(
                  color: AppColors.darkGray.withOpacity(0.5),
                ),
              ),
              style: AppTextStyle.font15Medium(context),
              maxLines: null,
              onSubmitted: (_) => _submitComment(),
            ),
          ),
          const SizedBox(width: 8),
          _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primaryColor,
                  ),
                )
              : IconButton(
                  onPressed: _submitComment,
                  icon: const Icon(
                    IconlyLight.send,
                    color: AppColors.primaryColor,
                  ),
                ),
        ],
      ),
    );
  }
}
