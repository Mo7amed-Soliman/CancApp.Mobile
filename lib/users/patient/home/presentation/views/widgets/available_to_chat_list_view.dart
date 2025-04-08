import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_provider.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/home/data/models/chat_item_model.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/chat_category_item.dart';
import 'package:flutter/material.dart';

class AvailableToChatListView extends StatelessWidget {
  const AvailableToChatListView({super.key});

  /// Creates the list of chat items with localized titles
  List<ChatItemModel> _createChatItems(BuildContext context) {
    return [
      ChatItemModel(
        image: AppAssets.doctorIcon,
        title: S.of(context).doctors,
        color: AppColors.deepBlue,
      ),
      ChatItemModel(
        image: AppAssets.pharmacistIcon,
        title: S.of(context).pharmacists,
        color: AppColors.mintGreen,
      ),
      ChatItemModel(
        image: AppAssets.psychiatristIcon,
        title: S.of(context).psychiatrists,
        color: AppColors.orange,
      ),
      ChatItemModel(
        image: AppAssets.volunteerIcon,
        title: S.of(context).volunteers,
        color: AppColors.red,
      ),
      ChatItemModel(
        image: AppAssets.patientIcon,
        title: S.of(context).patients,
        color: AppColors.purple,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final chatItems = _createChatItems(context);

    return SizeProvider(
      baseSize: const Size(250, 160),
      width: context.setWidth(300),
      height: context.setHeight(160),
      child: Builder(builder: (context) {
        return SizedBox(
          height: context.sizeProvider.height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: chatItems.length,
            separatorBuilder: (context, index) {
              return const HorizontalSpacer(10);
            },
            itemBuilder: (context, index) {
              final item = chatItems[index];
              return ChatCategoryItem(item: item);
            },
          ),
        );
      }),
    );
  }
}
