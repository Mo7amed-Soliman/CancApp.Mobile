import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/doctor/chat/presentation/views/widgets/chat_list_shimmer.dart';
import 'package:canc_app/users/patient/chat/presentation/manager/get_available_users_cubit/get_available_users_cubit.dart';
import 'package:canc_app/users/patient/chat/presentation/manager/get_available_users_cubit/get_available_users_state.dart';
import 'package:canc_app/users/patient/chat/presentation/views/widgets/chats_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableUsersList extends StatelessWidget {
  final int categoryIndex;

  const AvailableUsersList({
    super.key,
    required this.categoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<GetAvailableUsersCubit>()..getUsers(categoryIndex),
      child: BlocBuilder<GetAvailableUsersCubit, GetAvailableUsersState>(
        builder: (context, state) {
          if (state is GetAvailableUsersInitial) {
            context.read<GetAvailableUsersCubit>().getUsers(categoryIndex);
            return const SizedBox();
          }
          if (state is GetAvailableUsersLoading) {
            return const ChatListShimmer();
          }
          if (state is GetAvailableUsersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage,
                    style: AppTextStyle.font16RegularDarkGray(context),
                    textAlign: TextAlign.center,
                  ),
                  const VerticalSpacer(16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<GetAvailableUsersCubit>()
                          .getUsers(categoryIndex);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is GetAvailableUsersSuccess) {
            if (state.users.isEmpty) {
              return InEmptyList(
                title: S.of(context).noUsersFound,
              );
            }
            return ChatsList(users: state.users);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
