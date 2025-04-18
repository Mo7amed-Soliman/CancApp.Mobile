import 'package:canc_app/core/helpers/class/week_helper.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_details_model.dart';

import '../../../data/models/frequency_enum.dart';

class FrequencySelector extends StatefulWidget {
  final Frequency? selectedFrequency;
  final FrequencyDetailsModel? frequencyDetails;
  final Function(Frequency) onFrequencySelected;
  final Function(FrequencyDetailsModel) onFrequencyDetailsChanged;

  const FrequencySelector({
    super.key,
    required this.selectedFrequency,
    required this.frequencyDetails,
    required this.onFrequencySelected,
    required this.onFrequencyDetailsChanged,
  });

  @override
  State<FrequencySelector> createState() => _FrequencySelectorState();
}

class _FrequencySelectorState extends State<FrequencySelector>
    with SingleTickerProviderStateMixin {
  final List<bool> _selectedDays = List.generate(7, (index) => false);
  int _daysInterval = 2;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (widget.frequencyDetails != null) {
      if (widget.frequencyDetails!.daysOfWeek != null) {
        for (int day in widget.frequencyDetails!.daysOfWeek!) {
          _selectedDays[day] = true;
        }
      }
      if (widget.frequencyDetails!.daysInterval != null) {
        _daysInterval = widget.frequencyDetails!.daysInterval!;
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showDaysOfWeekDialog() {
    _animationController.forward(from: 0.0);
    List<bool> tempSelectedDays = List.from(_selectedDays);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ScaleTransition(
        scale: _scaleAnimation,
        child: _DaysOfWeekDialog(
          selectedDays: tempSelectedDays,
          onDaySelected: (index, selected) {
            setState(() {
              _selectedDays[index] = selected;
            });
            final selectedDays = <int>[];
            for (int j = 0; j < 7; j++) {
              if (_selectedDays[j]) {
                selectedDays.add(j + 1);
              }
            }
            widget.onFrequencyDetailsChanged(
              FrequencyDetailsModel(daysOfWeek: selectedDays),
            );
          },
          onClose: () {
            _animationController.reverse().then((_) {
              Navigator.pop(context);
            });
          },
        ),
      ),
    );
  }

  void _showDaysIntervalDialog() {
    _animationController.forward(from: 0.0);
    int tempDaysInterval = _daysInterval;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ScaleTransition(
        scale: _scaleAnimation,
        child: _DaysIntervalDialog(
          daysInterval: tempDaysInterval,
          onIntervalChanged: (value) {
            setState(() {
              _daysInterval = value;
            });
            widget.onFrequencyDetailsChanged(
              FrequencyDetailsModel(daysInterval: value),
            );
          },
          onClose: () {
            _animationController.reverse().then((_) {
              Navigator.pop(context);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FrequencyDropdown(
          selectedFrequency: widget.selectedFrequency,
          onFrequencySelected: widget.onFrequencySelected,
        ),
        _AnimatedFrequencyContent(
          selectedFrequency: widget.selectedFrequency,
          daysInterval: _daysInterval,
          selectedDays: _selectedDays,
          onDaysIntervalTap: _showDaysIntervalDialog,
          onDaysOfWeekTap: _showDaysOfWeekDialog,
        ),
      ],
    );
  }
}

class _FrequencyDropdown extends StatelessWidget {
  final Frequency? selectedFrequency;
  final Function(Frequency) onFrequencySelected;

  const _FrequencyDropdown({
    required this.selectedFrequency,
    required this.onFrequencySelected,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<Frequency>(
      initialValue: selectedFrequency,
      builder: (FormFieldState<Frequency> state) {
        return InputDecorator(
          decoration: InputDecoration(
            errorText: state.errorText,
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.setWidth(16),
              vertical: context.setMinSize(6),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.paleTealTransparent,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.paleTealTransparent,
                width: 2,
              ),
            ),
          ),
          isEmpty: state.value == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Frequency>(
              value: state.value,
              dropdownColor: AppColors.offWhite,
              isExpanded: true,
              borderRadius: BorderRadius.circular(12),
              onChanged: (newValue) {
                state.didChange(newValue);
                onFrequencySelected(newValue!);
              },
              items: Frequency.values.map((frequency) {
                return DropdownMenuItem<Frequency>(
                  value: frequency,
                  child: Text(
                    frequency.displayName(context),
                    style: AppTextStyle.font14RegularDarkGray(context),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedFrequencyContent extends StatelessWidget {
  final Frequency? selectedFrequency;
  final int daysInterval;
  final List<bool> selectedDays;
  final VoidCallback onDaysIntervalTap;
  final VoidCallback onDaysOfWeekTap;

  const _AnimatedFrequencyContent({
    required this.selectedFrequency,
    required this.daysInterval,
    required this.selectedDays,
    required this.onDaysIntervalTap,
    required this.onDaysOfWeekTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -0.5),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: selectedFrequency == null
          ? const SizedBox.shrink()
          : Column(
              key: ValueKey<Frequency?>(selectedFrequency),
              children: [
                const SizedBox(height: 16),
                if (selectedFrequency == Frequency.everyXDays)
                  _AnimatedSelector(
                    child: _DaysIntervalSelector(
                      daysInterval: daysInterval,
                      onTap: onDaysIntervalTap,
                    ),
                  ),
                if (selectedFrequency == Frequency.daysOfWeek)
                  _AnimatedSelector(
                    child: _DaysOfWeekSelector(
                      selectedDays: selectedDays,
                      onTap: onDaysOfWeekTap,
                    ),
                  ),
              ],
            ),
    );
  }
}

class _AnimatedSelector extends StatelessWidget {
  final Widget child;

  const _AnimatedSelector({required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _DaysIntervalSelector extends StatelessWidget {
  final int daysInterval;
  final VoidCallback onTap;

  const _DaysIntervalSelector({
    required this.daysInterval,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.8, end: 1.0),
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${S.of(context).every} $daysInterval ${S.of(context).days}',
                style: AppTextStyle.font14RegularDarkGray(context),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}

class _DaysOfWeekSelector extends StatelessWidget {
  final List<bool> selectedDays;
  final VoidCallback onTap;

  const _DaysOfWeekSelector({
    required this.selectedDays,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedDayNames = <String>[];
    selectedDayNames.addAll(WeekHelper.getSelectedDayNames(selectedDays));

    // for (int i = 0; i < 7; i++) {
    //   if (selectedDays[i]) {
    //     selectedDayNames.add(WeekHelper.getDayName(i));
    //   }
    // }

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.8, end: 1.0),
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(
              color: AppColors.paleTealTransparent,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDayNames.isEmpty
                    ? S.of(context).selectDaysOfWeek
                    : selectedDayNames.join(', '),
                style: AppTextStyle.font14RegularDarkGray(context),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}

class _DaysIntervalDialog extends StatefulWidget {
  final int daysInterval;
  final Function(int) onIntervalChanged;
  final VoidCallback onClose;

  const _DaysIntervalDialog({
    required this.daysInterval,
    required this.onIntervalChanged,
    required this.onClose,
  });

  @override
  State<_DaysIntervalDialog> createState() => _DaysIntervalDialogState();
}

class _DaysIntervalDialogState extends State<_DaysIntervalDialog> {
  late int _tempDaysInterval;

  @override
  void initState() {
    super.initState();
    _tempDaysInterval = widget.daysInterval;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).everyXDays,
        style: AppTextStyle.font18SemiBoldDarkGray(context),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 200),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) => Transform.scale(
              scale: value,
              child: child,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (_tempDaysInterval > 2) {
                      setState(() {
                        _tempDaysInterval--;
                      });
                      widget.onIntervalChanged(_tempDaysInterval);
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_tempDaysInterval',
                    style: AppTextStyle.font20SemiBold(context),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_tempDaysInterval < 30) {
                      setState(() {
                        _tempDaysInterval++;
                      });
                      widget.onIntervalChanged(_tempDaysInterval);
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _DialogCloseButton(onClose: widget.onClose),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class _DaysOfWeekDialog extends StatefulWidget {
  final List<bool> selectedDays;
  final Function(int, bool) onDaySelected;
  final VoidCallback onClose;

  const _DaysOfWeekDialog({
    required this.selectedDays,
    required this.onDaySelected,
    required this.onClose,
  });

  @override
  State<_DaysOfWeekDialog> createState() => _DaysOfWeekDialogState();
}

class _DaysOfWeekDialogState extends State<_DaysOfWeekDialog> {
  late List<bool> _tempSelectedDays;

  @override
  void initState() {
    super.initState();
    _tempSelectedDays = List.from(widget.selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).dayOfTheWeek,
        style: AppTextStyle.font18SemiBoldDarkGray(context),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < 7; i++)
            TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 200 + (i * 50)),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) => Transform.scale(
                scale: value,
                child: child,
              ),
              child: CheckboxListTile(
                value: _tempSelectedDays[i],
                onChanged: (selected) {
                  setState(() {
                    _tempSelectedDays[i] = selected ?? false;
                  });
                  widget.onDaySelected(i, selected ?? false);
                },
                title: Text(
                  WeekHelper.getDayName(i + 1),
                  style: AppTextStyle.font16RegularBlack(context),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          const Divider(),
          _DialogCloseButton(onClose: widget.onClose),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class _DialogCloseButton extends StatelessWidget {
  final VoidCallback onClose;

  const _DialogCloseButton({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClose,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          S.of(context).close,
          style: AppTextStyle.font16SemiBoldWhite(context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
