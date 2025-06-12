import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/models/comment_model.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comment_input_field.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comment_shimmer.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/comments_list_view.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:flutter/material.dart';

class CommentView extends StatefulWidget {
  const CommentView({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final CommunityRepository _repository = getIt<CommunityRepository>();
  bool _isLoading = true;
  String? _error;
  List<CommentModel> _comments = [];

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    try {
      final result = await _repository.getCommentsPerPost(
        postId: widget.post.id,
      );

      result.fold(
        (failure) {
          setState(() {
            _error = failure.errorMessage;
            _isLoading = false;
          });
        },
        (comments) async {
          await Future.delayed(const Duration(seconds: 100));
          setState(() {
            _comments = comments;
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.offWhite,
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_isLoading)
              const Expanded(
                child: CommentsShimmerLoading(),
              )
            else if (_error != null)
              Expanded(
                child: Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            else if (_comments.isNotEmpty)
              Expanded(
                child: CommentsListView(
                  post: widget.post,
                  comments: _comments,
                ),
              )
            else ...[
              const Spacer(),
              const Center(
                child: InEmptyList(
                  title: 'No comments yet \n Be the first to comment',
                  image: AppAssets.noComments,
                ),
              ),
              const Spacer(),
            ],
            CommentInputField(
              postId: widget.post.id,
              onCommentAdded: () {
                _loadComments(); // Reload comments after adding a new one
              },
            ),
          ],
        ),
      ),
    );
  }
}
