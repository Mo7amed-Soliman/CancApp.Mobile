import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  final String imageUrl;

  const PostImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.setHeight(360),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: CustomCachedNetworkImage(
        imageUrl: imageUrl,
      ),
    );
  }
}
