import 'package:canc_app/users/patient/record/data/models/recotd_model.dart';
import 'package:canc_app/users/patient/record/presentation/views/widgets/record_detail_item.dart';
import 'package:flutter/material.dart';

class RecordTypeBody extends StatelessWidget {
  const RecordTypeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemCount: lists.length,
      itemBuilder: (context, index) {
        return RecordDetailItem(record: lists[index]);
      },
    );
  }
}
