import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class AiView extends StatelessWidget {
  const AiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(
            horizontal: context.setMinSize(16),
          ),
          height: context.screenHeight * 0.1,
          child: Row(
            children: [
              Text(
                S.of(context).aiDiagnosisAssistantLungCancer,
                style: AppTextStyle.font24SemiBoldDarkGray(context).copyWith(
                  color: AppColors.offWhite,
                  height: 1.86,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(16),
            ),
            child: ListView(
              children: [
                const VerticalSpacer(16),
                Text(
                  'What is the patient\'s age?',
                  style: AppTextStyle.font17Medium(context),
                ),
                const VerticalSpacer(8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Age',
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                  ),
                  style: const TextStyle(color: Colors.black54),
                ),
                const VerticalSpacer(16),
                Text(
                  'What is the patient\'s gender?',
                  style: AppTextStyle.font17Medium(context),
                ),
                const VerticalSpacer(8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: Text(
                          'Male',
                          style: AppTextStyle.font16MediumDarkGray(context)
                              .copyWith(
                            color: AppColors.grayish,
                          ),
                        ),
                      ),
                    ),
                    const HorizontalSpacer(16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5F5F5),
                          foregroundColor: AppColors.grayish,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: Text(
                          'Female',
                          style: AppTextStyle.font16MediumDarkGray(context)
                              .copyWith(
                            color: AppColors.grayish,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpacer(16),
                _questionRow('Does the patient smoke?', context),
                const VerticalSpacer(16),
                _questionRow(
                    'Does the patient consume alcohol regularly?', context),
                const VerticalSpacer(16),
                _questionRow(
                    'Does the patient experience chest pain?', context),
                const VerticalSpacer(16),
                _questionRow('Has the patient coughed up blood?', context),
                const VerticalSpacer(16),
                _questionRow(
                    'Does the patient suffer from shortness of breath?',
                    context),
                const VerticalSpacer(16),
                AppButtonWidget(
                  onPressed: () {},
                  text: 'Submit',
                ),
                const VerticalSpacer(20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _questionRow(String question, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        question,
        style: AppTextStyle.font17Medium(context),
      ),
      const VerticalSpacer(8),
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: Text(
                'Yes',
                style: AppTextStyle.font16MediumDarkGray(context).copyWith(
                  color: AppColors.grayish,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: Text(
                'NO',
                style: AppTextStyle.font16MediumDarkGray(context).copyWith(
                  color: AppColors.grayish,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
