import 'package:bot_toast/bot_toast.dart';
import 'package:canc_app/core/helpers/functions/bot_toast.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/users/patient/home/data/models/access_request_model';
import 'package:canc_app/users/patient/home/presentation/manager/access_request_cubit/access_request_cubit.dart';
import 'package:canc_app/users/patient/home/presentation/manager/access_request_cubit/access_request_state.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/animated_slide_request_item.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/card_access_request_item.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessRequestsViewBody extends StatefulWidget {
  const AccessRequestsViewBody({super.key, required this.items});
  final List<AccessRequestModel> items;

  @override
  State<AccessRequestsViewBody> createState() => _AccessRequestsViewBodyState();
}

class _AccessRequestsViewBodyState extends State<AccessRequestsViewBody>
    with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _removeItem(int index, bool isAllowed) async {
    final String itemId = widget.items[index].id;
    await context.read<AccessRequestCubit>().handleAccessRequest(
          requestId: itemId,
          approve: isAllowed,
        );

    if (index < 0 || index >= widget.items.length) return;

    // Store the item before removal
    final item = widget.items[index];

    // Show snackbar first
    _showSnackBar(isAllowed);

    // Then animate the removal
    if (_listKey.currentState != null) {
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildAnimatedItem(item, animation),
        duration: const Duration(milliseconds: 300),
      );
    }

    // Remove from the data source after animation starts
    setState(() {
      widget.items.removeAt(index);
    });
  }

  void _showSnackBar(bool isAllowed) {
    BotToast.showText(
      text: isAllowed
          ? S.of(context).accessRequestAllowed
          : S.of(context).accessRequestDenied,
      duration: const Duration(seconds: 2),
      textStyle: AppTextStyle.font16RegularDarkGray(context),
    );
  }

  Widget _buildAnimatedItem(
    AccessRequestModel item,
    Animation<double> animation,
  ) {
    return AnimatedSlideRequestItem(
      animation: animation,
      child: CardAccessRequestItem(
        item: item,
        onAllow: () {},
        onDeny: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return InEmptyList(
        title: S.of(context).noPendingRequests,
      );
    }

    return BlocConsumer<AccessRequestCubit, AccessRequestState>(
        listener: (context, state) {
      if (state.isLoading) {
        // showLoading();
      }
      if (state.error != null) {
        botTextToast(state.error.toString());
      }
    }, builder: (context, state) {
      return AnimatedList(
        key: _listKey,
        physics: const BouncingScrollPhysics(),
        initialItemCount: widget.items.length,
        itemBuilder: (context, index, animation) {
          return AnimatedSlideRequestItem(
            animation: animation,
            child: CardAccessRequestItem(
              item: widget.items[index],
              onAllow: () async => await _removeItem(index, true),
              onDeny: () async => await _removeItem(index, false),
            ),
          );
        },
      );
    });
  }
}
