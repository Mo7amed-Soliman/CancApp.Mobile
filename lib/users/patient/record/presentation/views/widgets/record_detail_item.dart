import 'package:canc_app/core/routing/routes.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/edit_delete_popup_menu.dart';
import 'package:canc_app/users/patient/record/data/models/recotd_model.dart';
import 'package:canc_app/users/patient/record/presentation/manager/manage_record/managerecord_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecordDetailItem extends StatelessWidget {
  final RecordModel record;
  final String type;
  const RecordDetailItem({super.key, required this.record, required this.type});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.22,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Row(
                children: [
                  record.image != null
                      ? Container(
                          height: height * 0.2,
                          width: width * 0.38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: _isImageFile(record.image)
                                ? DecorationImage(
                                    image: FileImage(record.image!),
                                    fit: BoxFit.fill,
                                  )
                                : null,
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(width: width * 0.05),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      width: width * 0.4,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          record.note ,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.font12MediumDarkGray(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Popup menu (top-right)
          Positioned(
            top: 10,
            right: -12,
            child: EditDeletePopupMenu(
              onEdit: () {
                GoRouter.of(context)
                    .push(Routes.newRecordDetail, extra: [record,type]);
              },
              onDelete: () {
                BlocProvider.of<ManagerecordCubit>(context)
                    .deleteRecord(record.id,type);
              },
            ),
          ),

          // Date (bottom-right)
          Positioned(
            bottom: 8,
            right: 10,
            child: Text(
              record.date,
              style: AppTextStyle.font12MediumDarkGray(context),
            ),
          ),
        ],
      ),
    );
  }
}

bool _isImageFile(dynamic file) {
  if (file == null) return false;

  // ignore: prefer_typing_uninitialized_variables
  final path;

  try {
    path = file.path.toLowerCase();
    return path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.gif') ||
        path.endsWith('.bmp') ||
        path.endsWith('.webp');
  } catch (e) {
    return false;
  }
}
