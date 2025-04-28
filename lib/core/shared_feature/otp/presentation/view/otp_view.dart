import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/models/otp_model.dart';
import 'package:canc_app/core/shared_feature/otp/data/repositories/otp_repository.dart';
import 'package:canc_app/core/shared_feature/otp/presentation/manger/otp_cubit.dart';
import 'package:canc_app/core/shared_feature/otp/presentation/view/widgets/otp_view_body.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class OTPView extends StatelessWidget {
  const OTPView({
    super.key,
    required this.otpModel,
  });

  final OtpModel otpModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(
        otpRepository: getIt<OtpRepository>(),
        otpModel: otpModel,
      ),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: OtpViewBody(otpModel: otpModel),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: AppColors.darkGray,
      backgroundColor: AppColors.offWhite,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(
          isArabic() ? IconlyLight.arrow_right_2 : IconlyLight.arrow_left_2,
          color: AppColors.darkGray,
        ),
      ),
    );
  }
}
