import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import 'vertical_spacer.dart';

class ImageSourcePicker extends StatelessWidget {
  final void Function(ImageSource) onImageSourceSelected;

  const ImageSourcePicker({
    super.key,
    required this.onImageSourceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.setMinSize(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.setMinSize(50),
            height: context.setMinSize(4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const VerticalSpacer(10),
          ListTile(
            leading: Icon(
              IconlyBold.camera,
              size: context.setMinSize(30),
            ),
            title: Text(
              S.of(context).takePhoto,
              style: AppTextStyle.font16MediumDarkGray(context),
            ),
            onTap: () {
              Navigator.pop(context);
              onImageSourceSelected(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(
              IconlyBold.image,
              size: context.setMinSize(30),
            ),
            title: Text(
              S.of(context).chooseFromGallery,
              style: AppTextStyle.font16MediumDarkGray(context),
            ),
            onTap: () {
              Navigator.pop(context);
              onImageSourceSelected(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
