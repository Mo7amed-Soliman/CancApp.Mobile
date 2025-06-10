import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class AddNoteSection extends StatefulWidget {
  const AddNoteSection({
    super.key,
    this.onChanges,
    this.initialNote,
  });
  final void Function(String?)? onChanges;
  final String? initialNote;

  @override
  State<AddNoteSection> createState() => _AddNoteSectionState();
}

class _AddNoteSectionState extends State<AddNoteSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60,
      // height: 280,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
            child: Text(
              'Add notes',
              style: AppTextStyle.font14RegularDarkGray(context).copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: TextFormField(
              controller: _controller,
              validator: (data) {
                if (data == null || data.isEmpty) {
                  return 'Field is required';
                }
                return null;
              },
              onChanged: widget.onChanges,
              maxLines: 7,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add Note',
                hintStyle: AppTextStyle.font14RegularDarkGray(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
