import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/users/doctor/chat/presentation/views/widgets/chat_list_shimmer.dart';
import 'package:canc_app/users/patient/chat/presentation/manager/get_available_users_cubit/get_available_users_cubit.dart';
import 'package:canc_app/users/patient/chat/presentation/manager/get_available_users_cubit/get_available_users_state.dart';
import 'package:canc_app/users/patient/chat/presentation/views/widgets/chats_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/chats_header.dart';
import 'widgets/category_list.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetAvailableUsersCubit>()..getUsers(0),
      child: const Column(
        children: [
          ChatsHeader(),
          VerticalSpacer(16),
          BlocBuilderChatsList(),
        ],
      ),
    );
  }
}

class BlocBuilderChatsList extends StatefulWidget {
  const BlocBuilderChatsList({super.key});

  @override
  State<BlocBuilderChatsList> createState() => _BlocBuilderChatsListState();
}

class _BlocBuilderChatsListState extends State<BlocBuilderChatsList> {
  int? _selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = 0;
  }

  void _onCategorySelected(int index) {
    _selectedCategoryIndex = index;
    setState(() {});
    context.read<GetAvailableUsersCubit>().getUsers(index);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<GetAvailableUsersCubit, GetAvailableUsersState>(
        builder: (context, state) {
          if (state is GetAvailableUsersLoading) {
            return Column(
              children: [
                CategoryList(
                  item: _selectedCategoryIndex,
                  onCategorySelected: _onCategorySelected,
                ),
                const Expanded(child: ChatListShimmer()),
              ],
            );
          }
          if (state is GetAvailableUsersError) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is GetAvailableUsersSuccess) {
            return Column(
              children: [
                CategoryList(
                  item: _selectedCategoryIndex,
                  onCategorySelected: _onCategorySelected,
                ),
                const VerticalSpacer(8),
                Expanded(
                  child: ChatsList(users: state.users),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
