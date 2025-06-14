import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
    this.item,
    this.onCategorySelected,
  });
  final int? item;
  final void Function(int)? onCategorySelected;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.item ?? 0;
  }

  @override
  void didUpdateWidget(CategoryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item != oldWidget.item) {
      setState(() {
        _selectedIndex = widget.item ?? 0;
      });
    }
  }

  List<String> _getCategories(BuildContext context) {
    return [
      S.of(context).doctor,
      S.of(context).pharmacy,
      S.of(context).psychiatrist,
      S.of(context).volunteer,
      S.of(context).patient,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getCategories(context);
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return SizedBox(
      height: context.setMinSize(40),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(14),
        ),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const HorizontalSpacer(8),
        itemBuilder: (context, index) {
          return _CategoryItem(
            title: categories[index],
            isSelected: _selectedIndex == index,
            onTap: () {
              if (_selectedIndex != index) {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onCategorySelected?.call(index);
              }
            },
            isRTL: isRTL,
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.isRTL,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isRTL;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(14),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.1)
              : AppColors.lightGray,
          borderRadius: BorderRadius.circular(context.setMinSize(10)),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.grayish.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.font15Bold(context).copyWith(
              color: isSelected ? AppColors.primaryColor : AppColors.darkGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
