import 'package:bot_toast/bot_toast.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/animated_slide_request_item.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/card_access_request_item.dart';
import 'package:canc_app/core/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';

class AccessRequestsViewBody extends StatefulWidget {
  const AccessRequestsViewBody({super.key});

  @override
  State<AccessRequestsViewBody> createState() => _AccessRequestsViewBodyState();
}

class _AccessRequestsViewBodyState extends State<AccessRequestsViewBody>
    with TickerProviderStateMixin {
  // remove this after testing
  final List<AccessRequestItem> _items = [
    const AccessRequestItem(
      id: '1',
      image: 'assets/images/dummy_image/img1.png',
      name: 'Dr.Omar Ahmed',
      message: 'has sent you a request to access your records',
    ),
    const AccessRequestItem(
      id: '2',
      image: 'assets/images/dummy_image/img2.png',
      name: 'Dr.Sarah Johnson',
      message: 'has sent you a request to access your records',
    ),
    const AccessRequestItem(
      id: '3',
      image: 'assets/images/dummy_image/img3.png',
      name: 'Dr.Michael Brown',
      message: 'has sent you a request to access your records',
    ),
    const AccessRequestItem(
      id: '4',
      image: 'assets/images/dummy_image/img4.png',
      name: 'Dr.Lisa Chen',
      message: 'has sent you a request to access your records',
    ),
    const AccessRequestItem(
      id: '5',
      image: 'assets/images/dummy_image/img5.png',
      name: 'Dr.Aye Soliman',
      message: 'has sent you a request to access your records',
    ),
    const AccessRequestItem(
      id: '6',
      image: 'assets/images/dummy_image/img6.png',
      name: 'Dr.Emily Davis',
      message: 'has sent you a request to access your records',
    ),
  ];

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
    if (index < 0 || index >= _items.length) return;

    // Store the item before removal
    final item = _items[index];

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
      _items.removeAt(index);
    });
  }

  void _showSnackBar(bool isAllowed) {
    BotToast.showText(
      text: isAllowed
          ? S.of(context).accessRequestAllowed
          : S.of(context).accessRequestDenied,
      duration: const Duration(seconds: 2),
      textStyle: TextStyle(
        color: Colors.white,
        fontFamily: AppTextStyle.fontFamily,
      ),
    );
  }

  Widget _buildAnimatedItem(
    AccessRequestItem item,
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
    if (_items.isEmpty) {
      return EmptyList(
        title: S.of(context).noPendingRequests,
      );
    }

    return AnimatedList(
      key: _listKey,
      physics: const BouncingScrollPhysics(),
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        if (index >= _items.length) {
          return const SizedBox.shrink();
        }

        return AnimatedSlideRequestItem(
          animation: animation,
          child: CardAccessRequestItem(
            item: _items[index],
            onAllow: () => _removeItem(index, true),
            onDeny: () => _removeItem(index, false),
          ),
        );
      },
    );
  }
}
