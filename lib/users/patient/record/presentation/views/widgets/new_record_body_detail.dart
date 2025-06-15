import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/record/data/models/recotd_model.dart';
import 'package:canc_app/users/patient/record/presentation/manager/manage_record/managerecord_cubit.dart';
import 'package:canc_app/users/patient/record/presentation/manager/manage_record_image/manage_upload_image_cubit.dart';
import 'package:canc_app/users/patient/record/presentation/views/widgets/add_date_section.dart';
import 'package:canc_app/users/patient/record/presentation/views/widgets/add_note_section.dart';
import 'package:canc_app/users/patient/record/presentation/views/widgets/display_record_image.dart';
import 'package:canc_app/users/patient/record/presentation/views/widgets/upload_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NewRecordBodyDetail extends StatefulWidget {
  const NewRecordBodyDetail({super.key, required this.record});

  final List<dynamic> record;
  @override
  State<NewRecordBodyDetail> createState() => _NewRecordBodyDetailState();
}

class _NewRecordBodyDetailState extends State<NewRecordBodyDetail> {
  GlobalKey<FormState> formState = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  RecordModel recordModel = RecordModel(image: null, date: '', note: '');

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = DateFormat('dd-MM-yyyy').format(now);
    widget.record[0]?.date = date;
    recordModel.date = date;
    return Form(
      key: formState,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  BlocBuilder<ManageUploadImageCubit, ManageUploadImageState>(
                      builder: (context, state) {
                    if (state is FoundedImage &&
                        (recordModel.image != null
                        // recordModel.file != null)) {
                        )) {
                      return DisplayRecordImage(
                          record: widget.record[0] ?? recordModel);
                    } else if (widget.record[0]?.image != null ||
                        widget.record[0]?.file != null) {
                      return DisplayRecordImage(record: widget.record[0]!);
                    } else {
                      return UploadSection(
                        onPick: (image, file) async {
                          if (image != null) {
                            widget.record[0]?.image = image;
                            recordModel.image = image;
                            // } else {
                            //   widget.record[0]?.file = file;
                            //   recordModel.file = file;
                          }
                          BlocProvider.of<ManageUploadImageCubit>(context)
                              .addGallery(image ?? file);
                        },
                      );
                    }
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  AddNoteSection(
                    onChanges: (data) {
                      widget.record[0]?.note = data!;
                      recordModel.note = data ?? '';
                    },
                    initialNote: widget.record[0]?.note,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const AddDateSection(),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            AppButtonWidget(
              onPressed: () {
                if (formState.currentState!.validate()) {
                  if (widget.record[0] == null) {
                    BlocProvider.of<ManagerecordCubit>(context)
                        .addRecord(recordModel, widget.record[1]);
                  } else {
                    BlocProvider.of<ManagerecordCubit>(context)
                        .updateRecord(widget.record[0]!, widget.record[1]);
                  }

                  BlocProvider.of<ManageUploadImageCubit>(context)
                      .deleteImage();

                  context.pop();
                }
              },
              text: S.of(context).save,
            ),
          ],
        ),
      ),
    );
  }
}
