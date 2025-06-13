import 'package:canc_app/core/helpers/extension/time_ago_extension.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/shared_feature/community/presentation/manager/comment_cubit/comment_cubit.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post_popup_menu.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool isLiked = false;
  int reactionsCount = 0;
  final TextEditingController _editController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    reactionsCount = widget.comment.reactionsCount;
    _editController.text = widget.comment.content;
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  void _handleLike() {
    setState(() {
      isLiked = !isLiked;
      reactionsCount = isLiked ? reactionsCount + 1 : reactionsCount - 1;
    });

    context.read<CommentCubit>().toggleReaction(
          postId: widget.comment.postId,
          commentId: widget.comment.id,
          isLiked: isLiked,
        );
  }

  void _showEditDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionBuilder: (context, animation1, animation2, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation1,
          curve: Curves.easeInOut,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(context.setWidth(16)),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Edit Comment',
                          style: AppTextStyle.font18SemiBoldDarkGray(context),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const VerticalSpacer(16),
                    TextFormField(
                      controller: _editController,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Edit your comment',
                        hintStyle: AppTextStyle.font14RegularDarkGray(context),
                        filled: true,
                        fillColor: AppColors.lightGray,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(context.setWidth(12)),
                      ),
                      style: AppTextStyle.font14RegularDarkGray(context),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Comment cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const VerticalSpacer(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: AppTextStyle.font14RegularDarkGray(context),
                          ),
                        ),
                        const HorizontalSpacer(8),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<CommentCubit>().editComment(
                                    postId: widget.comment.postId,
                                    commentId: widget.comment.id,
                                    content: _editController.text.trim(),
                                  );
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: context.setWidth(16),
                              vertical: context.setHeight(8),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: AppTextStyle.font16SemiBoldWhite(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state is CommentError) {
          // Revert the UI state on error
          setState(() {
            isLiked = !isLiked;
            reactionsCount = isLiked ? reactionsCount + 1 : reactionsCount - 1;
          });
          botTextToast(state.errorMessage);
        } else if (state is CommentReported) {
          botTextToast('Comment reported successfully');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: context.setMinSize(22),
                backgroundImage: NetworkImage(widget.comment.userImageUrl),
              ),
              const HorizontalSpacer(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                        context.setWidth(12),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.comment.name,
                                style:
                                    AppTextStyle.font15Bold(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              PostPopupMenu(
                                userId: widget.comment.userId,
                                onDelete: () {
                                  context.read<CommentCubit>().deleteComment(
                                        postId: widget.comment.postId,
                                        commentId: widget.comment.id,
                                      );
                                },
                                onEdit: _showEditDialog,
                                onReport: () {
                                  context.read<CommentCubit>().reportComment(
                                        postId: widget.comment.postId,
                                        commentId: widget.comment.id,
                                      );
                                },
                              ),
                            ],
                          ),
                          const VerticalSpacer(5),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.comment.content,
                                  style: AppTextStyle.font14RegularDarkGray(
                                      context),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const VerticalSpacer(5),
                    Padding(
                      padding: EdgeInsets.only(
                        left: context.setWidth(10),
                        right: context.setWidth(10),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _handleLike,
                            child: isLiked
                                ? Icon(
                                    Icons.favorite,
                                    color: AppColors.red,
                                    size: context.setMinSize(20),
                                  )
                                : SvgPicture.asset(
                                    AppAssets.heartIcon,
                                    height: context.setMinSize(20),
                                  ),
                          ),
                          const HorizontalSpacer(5),
                          Text(
                            reactionsCount.toString(),
                            style: AppTextStyle.font14RegularDarkGray(context),
                          ),
                          const Spacer(),
                          Text(
                            widget.comment.time.timeAgo,
                            style: AppTextStyle.font12MediumDarkGray(context),
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpacer(10),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
