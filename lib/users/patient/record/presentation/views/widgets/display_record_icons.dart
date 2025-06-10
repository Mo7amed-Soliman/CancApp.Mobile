import 'dart:io';

import 'package:canc_app/core/helpers/functions/fuctions_pick_image.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:platform_file/platform_file.dart';

class DisplayRecordIcons extends StatefulWidget {
  final void Function(File? image, PlatformFile? file)? onPick;

  const DisplayRecordIcons({super.key, this.onPick});

  @override
  State<DisplayRecordIcons> createState() => _DisplayRecordIconsState();
}

class _DisplayRecordIconsState extends State<DisplayRecordIcons> {
  File? image;
  PlatformFile? file;

  Future<void> pickImage(int choose) async {
    try {
      // ignore: prefer_typing_uninitialized_variables
      final picked;
      if (choose == 1) {
        picked = await FuctionsPickImage.pickImageGallery();
      } else if (choose == 2) {
        picked = await FuctionsPickImage.pickFile();
      } else {
        picked = await FuctionsPickImage.pickImageCamera();
      }

      if (choose == 2) {
        file = picked;
        widget.onPick?.call(null, file);
      } else {
        image = picked;
        widget.onPick?.call(image, null);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Text(
            'Upload',
            style: AppTextStyle.font20SemiBold(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  pickImage(1);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:const Color.fromARGB(255, 216, 233, 226),
                  ),
                  child: const Icon(
                    color: Color.fromARGB(255, 55, 128, 99),
                    size: 50,
                    IconlyLight.image,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  pickImage(2);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 227, 210, 187),
                  ),
                  child: const Icon(
                    color: Color.fromARGB(255, 219, 173, 112),
                    size: 50,
                    IconlyLight.paper,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  pickImage(3);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:const Color.fromARGB(255, 225, 203, 203),
                  ),
                  child:const Icon(
                      color: Color.fromARGB(255, 160, 65, 65),
                      size: 50,
                      IconlyLight.camera),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
