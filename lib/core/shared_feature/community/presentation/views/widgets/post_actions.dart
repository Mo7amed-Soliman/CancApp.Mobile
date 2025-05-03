import 'package:audioplayers/audioplayers.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PostActions extends StatefulWidget {
  const PostActions({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  int currentLikes = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    currentLikes = widget.post.likes;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playLikeSound() async {
    await _audioPlayer.play(
      AssetSource(AppAssets.likeSound),
      volume: 0.1,
    );
  }

  Future<void> _handleLike() async {
    final wasLiked = isLiked;
    setState(() {
      isLiked = !isLiked;
      currentLikes = isLiked ? currentLikes + 1 : currentLikes - 1;
    });

    if (!wasLiked) {
      _controller.forward().then((_) => _controller.reverse());
      await _playLikeSound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(60),
        vertical: context.setHeight(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: _handleLike,
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: isLiked
                          ? Icon(
                              Icons.favorite,
                              color: AppColors.red,
                              size: context.setMinSize(29),
                            )
                          : SvgPicture.asset(
                              AppAssets.heartIcon,
                              height: context.setMinSize(29),
                            ),
                    );
                  },
                ),
              ),
              const HorizontalSpacer(6),
              Text(
                currentLikes.toString(),
                style: AppTextStyle.font16RegularDarkGray(context),
              ),
            ],
          ),
          const HorizontalSpacer(24),
          Row(
            children: [
              InkWell(
                onTap: () {
                  context.push(Routes.commentView, extra: widget.post);
                },
                child: SvgPicture.asset(
                  AppAssets.commitIcon,
                  height: context.setMinSize(31),
                ),
              ),
              const HorizontalSpacer(6),
              Text(
                widget.post.comments.toString(),
                style: AppTextStyle.font16RegularDarkGray(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
