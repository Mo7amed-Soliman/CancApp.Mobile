import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class CommentInputField extends StatefulWidget {
  const CommentInputField({
    super.key,
    this.replyTo,
    required this.postId,
  });

  final String? replyTo;
  final String postId;

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _commentController = TextEditingController();
  bool _canSubmit = false;

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

  void _submitComment() {
    if (_canSubmit) {
      // TODO: Implement comment submission logic
      // This would add a new comment to the comments list
      _commentController.clear();
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
              style: AppTextStyle.font14RegularDarkGray(context),
              decoration: InputDecoration(
                hintText: widget.replyTo != null
                    ? 'Reply to ${widget.replyTo}...'
                    : 'add comment',
                hintStyle: AppTextStyle.font14RegularDarkGray(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.lightGray,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.setWidth(16),
                  vertical: context.setHeight(8),
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          SizedBox(width: context.setWidth(8)),
          IconButton(
            onPressed: _canSubmit ? _submitComment : null,
            icon: Icon(
              Icons.send_rounded,
              color: _canSubmit ? AppColors.primaryColor : AppColors.mediumGray,
              size: context.setMinSize(24),
            ),
          ),
        ],
      ),
    );
  }
}
