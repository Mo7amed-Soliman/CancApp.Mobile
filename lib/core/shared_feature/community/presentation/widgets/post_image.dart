import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  const PostImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.setHeight(360),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
