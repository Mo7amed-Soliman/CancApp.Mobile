import 'package:canc_app/users/patient/record/data/models/recotd_model.dart';
import 'package:canc_app/users/patient/record/presentation/manager/manage_record_image/manage_upload_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class DisplayRecordImage extends StatelessWidget {
  const DisplayRecordImage({super.key, required this.record});
  final RecordModel record;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          height: 215,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: record.image != null
                ? Image.file(
                    record.image!,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(),
          ),
        ),
        Positioned(
          left: 335,
          top: 8,
          child: GestureDetector(
            onTap: () {
              record.image = null;
              // record.file = null;
              BlocProvider.of<ManageUploadImageCubit>(context).deleteImage();
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                FontAwesomeIcons.xmark,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
