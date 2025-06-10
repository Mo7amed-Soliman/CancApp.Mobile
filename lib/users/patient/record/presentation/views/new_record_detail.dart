import 'package:canc_app/core/widgets/custom_app_bar.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/record/presentation/views/widgets/new_record_body_detail.dart';
import 'package:flutter/material.dart';

class NewRecordDetail extends StatelessWidget {
  const NewRecordDetail({super.key, required this.record});
  final List<dynamic> record;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: record[0] == null
            ? S.of(context).newRecord
            : S.of(context).editRecord,
      ),
      body: NewRecordBodyDetail(
        record: record,
      ),
    );
  }
}
