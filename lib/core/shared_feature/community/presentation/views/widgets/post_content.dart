import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/constants.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class PostContent extends StatefulWidget {
  const PostContent({
    super.key,
    required this.post,
    required this.isExpanded,
    required this.onExpand,
  });

  final PostModel post;
  final bool isExpanded;
  final VoidCallback onExpand;

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  bool _isTranslated = false;
  bool _isLoading = false;
  String? _translatedText;
  final _translator = GoogleTranslator();
  static final _arabicRegex = RegExp(r'[\u0600-\u06FF]');

  bool get _isCurrentTextArabic => _isArabicText(_displayText);
  TextDirection get _textDirection =>
      _isCurrentTextArabic ? TextDirection.rtl : TextDirection.ltr;

  String get _displayText => _isTranslated
      ? (_translatedText ?? widget.post.contentPost)
      : widget.post.contentPost;

  bool _isArabicText(String text) => _arabicRegex.hasMatch(text);

  Future<void> _translateText() async {
    if (_isTranslated) {
      setState(() {
        _isTranslated = false;
        _translatedText = null;
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      final isSourceArabic = _isArabicText(widget.post.contentPost);
      final translation = await _translator.translate(
        widget.post.contentPost,
        from: isSourceArabic ? 'ar' : 'en',
        to: isSourceArabic ? 'en' : 'ar',
      );

      setState(() {
        _translatedText = translation.text;
        _isTranslated = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // Consider showing an error message to the user
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    return AppTextStyle.font16RegularDarkGray(context).copyWith(
      fontFamily:
          _isCurrentTextArabic ? FontFamily.almarai : FontFamily.poppins,
      height: 1.6,
    );
  }

  Widget _buildSeeMoreButton() {
    return TextButton(
      onPressed: widget.onExpand,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        widget.isExpanded ? S.of(context).seeLess : S.of(context).seeMore,
        style: AppTextStyle.font15Bold(context).copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTranslationButton() {
    return InkWell(
      onTap: _translateText,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isTranslated
                ? S.of(context).showOriginal
                : S.of(context).showTranslation,
            style: AppTextStyle.font15Bold(context).copyWith(
              color: AppColors.grayish,
              fontWeight: FontWeight.w400,
            ),
          ),
          const HorizontalSpacer(8),
          if (_isLoading)
            SizedBox(
              width: context.setMinSize(14),
              height: context.setMinSize(14),
              child: const CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primaryColor,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final textSpan = TextSpan(
            text: _displayText,
            style: _getTextStyle(context),
          );

          final textPainter = TextPainter(
            text: textSpan,
            maxLines: widget.post.imageUrl != null ? 3 : 12,
            textDirection: _textDirection,
          );
          textPainter.layout(maxWidth: constraints.maxWidth);

          final isTextLong = textPainter.didExceedMaxLines;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Directionality(
                textDirection: _textDirection,
                child: AnimatedCrossFade(
                  firstChild: Text(
                    _displayText,
                    style: _getTextStyle(context),
                    maxLines: widget.post.imageUrl != null ? 3 : 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  secondChild: Text(
                    _displayText,
                    style: _getTextStyle(context),
                  ),
                  crossFadeState: widget.isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                  firstCurve: Curves.easeInOut,
                  secondCurve: Curves.easeInOut,
                ),
              ),
              if (isTextLong) _buildSeeMoreButton(),
              const VerticalSpacer(4),
              _buildTranslationButton(),
            ],
          );
        },
      ),
    );
  }
}
