import 'package:canc_app/core/helpers/database/user_cache_helper.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/notification_badge.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/home/presentation/manager/access_request_cubit/access_request_cubit.dart';
import 'package:canc_app/users/patient/home/presentation/manager/access_request_cubit/access_request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(16),
      ),
      height: context.screenHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: context.setMinSize(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.setMinSize(30)),
                  child: Image.network(
                    UserCacheHelper.getUser()?.image ?? '',
                    width: context.setMinSize(60),
                    height: context.setMinSize(60),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const HorizontalSpacer(10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).helloWelcome,
                    style: AppTextStyle.font14lightWhite(context),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  const VerticalSpacer(2),
                  Text(
                    UserCacheHelper.getUser()?.name ?? '',
                    style: AppTextStyle.font16SemiBoldWhite(context),
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
          BlocBuilder<AccessRequestCubit, AccessRequestState>(
            builder: (context, state) {
              return NotificationBadge(
                count: state.pendingRequests.length,
                onTap: () async {
                  await context.push(Routes.accessRequestView,
                      extra: state.pendingRequests);
                  if (context.mounted) {
                    context.read<AccessRequestCubit>().loadPendingRequests();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
