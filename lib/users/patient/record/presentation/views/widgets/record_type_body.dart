import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/widgets/in_empty_list.dart';
import 'package:canc_app/users/patient/record/data/models/record_type.dart';
import 'package:canc_app/users/patient/record/data/models/recotd_model.dart';
import 'package:canc_app/users/patient/record/presentation/manager/manage_record/managerecord_cubit.dart';
import 'package:canc_app/users/patient/record/presentation/views/widgets/record_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class RecordTypeBody extends StatefulWidget {
  const RecordTypeBody({super.key, required this.recordType});
  final RecordType recordType;

  @override
  State<RecordTypeBody> createState() => _RecordTypeBodyState();
}

class _RecordTypeBodyState extends State<RecordTypeBody> {
  @override
  void initState() {
    BlocProvider.of<ManagerecordCubit>(context)
        .initstate(widget.recordType.labelEn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerecordCubit, ManagerecordState>(
      builder: (context, state) {
        String type = widget.recordType.labelEn;
        List<RecordModel> list;
        if (type == 'Scan') {
          list = BlocProvider.of<ManagerecordCubit>(context).list1;
        } else if (type == 'Lab Result') {
          list = BlocProvider.of<ManagerecordCubit>(context).list2;
        } else if (type == 'Prescription') {
          list = BlocProvider.of<ManagerecordCubit>(context).list3;
        } else {
          list = BlocProvider.of<ManagerecordCubit>(context).list4;
        }

        if (state is SuccessRecordList) {
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemCount: list.length,
            itemBuilder: (context, index) {
              return RecordDetailItem(record: list[index], type: type);
            },
          );
        } else {
          return InEmptyList(
            title: 'empty list',
            onPressed: () {
              GoRouter.of(context).push(Routes.newRecordDetail,
                  extra: [null, widget.recordType.labelEn]);
            },
            icon: IconlyBold.plus,
          );
        }
      },
    );
  }
}
