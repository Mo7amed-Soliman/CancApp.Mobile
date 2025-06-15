import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../data/models/health_input_model.dart';
import '../../data/services/ai_service.dart';
import 'widgets/health_question_row.dart';

class AiView extends StatefulWidget {
  const AiView({super.key});

  @override
  State<AiView> createState() => _AiViewState();
}

class _AiViewState extends State<AiView> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  int _selectedGender = 1; // 1 for Male, 2 for Female
  final Map<String, int> _responses = {};
  final _aiService = AiService();
  bool _isLoading = false;
  String? _predictionResult;

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  void _handleResponse(String question, int value) {
    setState(() {
      _responses[question] = value;
    });
  }

  void _resetForm() {
    setState(() {
      _ageController.clear();
      _selectedGender = 1;
      _responses.clear();
      _predictionResult = null;
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _predictionResult = null;
    });

    try {
      final input = HealthInputModel(
        age: int.parse(_ageController.text),
        gender: _selectedGender,
        airPollution: _responses['Air Pollution'] ?? 0,
        alcoholUse: _responses['Alcohol use'] ?? 0,
        dustAllergy: _responses['Dust Allergy'] ?? 0,
        occupationalHazards: _responses['Occupational Hazards'] ?? 0,
        geneticRisk: _responses['Genetic Risk'] ?? 0,
        chronicLungDisease: _responses['Chronic Lung Disease'] ?? 0,
        balancedDiet: _responses['Balanced Diet'] ?? 0,
        obesity: _responses['Obesity'] ?? 0,
        smoking: _responses['Smoking'] ?? 0,
        passiveSmoker: _responses['Passive Smoker'] ?? 0,
        chestPain: _responses['Chest Pain'] ?? 0,
        coughingOfBlood: _responses['Coughing of Blood'] ?? 0,
        fatigue: _responses['Fatigue'] ?? 0,
        weightLoss: _responses['Weight Loss'] ?? 0,
        shortnessOfBreath: _responses['Shortness of Breath'] ?? 0,
        wheezing: _responses['Wheezing'] ?? 0,
        swallowingDifficulty: _responses['Swallowing Difficulty'] ?? 0,
        clubbingOfFingerNails: _responses['Clubbing of Finger Nails'] ?? 0,
        frequentCold: _responses['Frequent Cold'] ?? 0,
        dryCough: _responses['Dry Cough'] ?? 0,
        snoring: _responses['Snoring'] ?? 0,
      );

      final result = await _aiService.predictHealth(input);
      setState(() {
        _predictionResult = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                'Lung Cancer Diagnosis',
                style: AppTextStyle.font24SemiBoldDarkGray(context).copyWith(
                  color: AppColors.offWhite,
                  height: 1.86,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.setMinSize(16),
              ),
              child: ListView(
                children: [
                  const VerticalSpacer(16),
                  Text(
                    S.of(context).whatIsPatientAge,
                    style: AppTextStyle.font17Medium(context),
                  ),
                  const VerticalSpacer(8),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: S.of(context).enterAge,
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterAge;
                      }
                      if (int.tryParse(value) == null) {
                        return S.of(context).pleaseEnterValidNumber;
                      }
                      return null;
                    },
                  ),
                  const VerticalSpacer(16),
                  Text(
                    S.of(context).whatIsPatientGender,
                    style: AppTextStyle.font17Medium(context),
                  ),
                  const VerticalSpacer(8),
                  Row(
                    children: [
                      Expanded(
                        child: _ResponseButton(
                          text: S.of(context).male,
                          isSelected: _selectedGender == 1,
                          onPressed: () {
                            setState(() {
                              _selectedGender = 1;
                            });
                          },
                        ),
                      ),
                      const HorizontalSpacer(16),
                      Expanded(
                        child: _ResponseButton(
                          text: S.of(context).female,
                          isSelected: _selectedGender == 2,
                          onPressed: () {
                            setState(() {
                              _selectedGender = 2;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacer(16),
                  ..._buildQuestionRows(),
                  if (_predictionResult != null) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _predictionResult == 'Positive'
                            ? Colors.red.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        S.of(context).prediction(_predictionResult!),
                        style: AppTextStyle.font17Medium(context).copyWith(
                          color: _predictionResult == 'Positive'
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ),
                    const VerticalSpacer(16),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: AppButtonWidget(
                          onPressed: _isLoading ? null : _submitForm,
                          text: _isLoading
                              ? S.of(context).processing
                              : S.of(context).submit,
                        ),
                      ),
                      const HorizontalSpacer(16),
                      Expanded(
                        child: AppButtonWidget(
                          onPressed: _isLoading ? null : _resetForm,
                          text: S.of(context).reset,
                          backgroundColor: Colors.grey[300]!,
                          textStyle: AppTextStyle.font16MediumDarkGray(context)
                              .copyWith(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacer(20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildQuestionRows() {
    final questions = [
      'Air Pollution',
      'Alcohol use',
      'Dust Allergy',
      'Occupational Hazards',
      'Genetic Risk',
      'Chronic Lung Disease',
      'Balanced Diet',
      'Obesity',
      'Smoking',
      'Passive Smoker',
      'Chest Pain',
      'Coughing of Blood',
      'Fatigue',
      'Weight Loss',
      'Shortness of Breath',
      'Wheezing',
      'Swallowing Difficulty',
      'Clubbing of Finger Nails',
      'Frequent Cold',
      'Dry Cough',
      'Snoring',
    ];

    return questions.map((question) {
      return Column(
        children: [
          HealthQuestionRow(
            question: question,
            selectedValue: _responses[question],
            onResponse: (value) => _handleResponse(question, value),
          ),
          const VerticalSpacer(16),
        ],
      );
    }).toList();
  }
}

class _ResponseButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const _ResponseButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? AppColors.primaryColor : Colors.grey[200],
          foregroundColor: isSelected ? AppColors.offWhite : Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(
          text,
          style: AppTextStyle.font16MediumDarkGray(context).copyWith(
            color: isSelected ? AppColors.offWhite : AppColors.grayish,
          ),
        ),
      ),
    );
  }
}
