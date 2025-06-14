import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/doctor/chat/presentation/views/widgets/chat_list_shimmer.dart';
import 'package:canc_app/users/patient/chat/presentation/manager/get_available_users_cubit/get_available_users_cubit.dart';
import 'package:canc_app/users/patient/chat/presentation/manager/get_available_users_cubit/get_available_users_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/available_users_list.dart';
import 'widgets/category_list.dart';

class AvailableToChatView extends StatelessWidget {
  const AvailableToChatView({super.key, this.item});
  final int? item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetAvailableUsersCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: S.of(context).chatCategories,
        ),
        body: Column(
          children: [
            const VerticalSpacer(16),
            Expanded(
              child: CategoryListAndUsersList(
                item: item,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryListAndUsersList extends StatefulWidget {
  const CategoryListAndUsersList({
    super.key,
    required this.item,
  });
  final int? item;

  @override
  State<CategoryListAndUsersList> createState() =>
      _CategoryListAndUsersListState();
}

class _CategoryListAndUsersListState extends State<CategoryListAndUsersList> {
  int? _selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = widget.item;
  }

  void _onCategorySelected(int index) {
    _selectedCategoryIndex = index;
    context.read<GetAvailableUsersCubit>().getUsers(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAvailableUsersCubit, GetAvailableUsersState>(
      builder: (context, state) {
        if (state is GetAvailableUsersLoading) {
          return Column(
            children: [
              CategoryList(
                item: widget.item,
                onCategorySelected: _onCategorySelected,
              ),
              const VerticalSpacer(16),
              const ChatListShimmer(),
            ],
          );
        }
        if (state is GetAvailableUsersError) {
          return Center(child: Text(state.errorMessage));
        }
        return Column(
          children: [
            CategoryList(
              item: _selectedCategoryIndex,
              onCategorySelected: _onCategorySelected,
            ),
            const VerticalSpacer(16),
            if (_selectedCategoryIndex != null)
              Expanded(
                child: AvailableUsersList(
                  categoryIndex: _selectedCategoryIndex!,
                ),
              ),
          ],
        );
      },
    );
  }
}
