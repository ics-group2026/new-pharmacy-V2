import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';

class PickPhotoWidget extends StatefulWidget {
  const PickPhotoWidget({super.key, required this.onChanged});

  final ValueChanged<File?> onChanged;
  @override
  State<PickPhotoWidget> createState() => _PickPhotoWidgetState();
}

class _PickPhotoWidgetState extends State<PickPhotoWidget> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  Future<void> _pickImage(BuildContext context) async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: Text('Gallery'.tr()),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text('Camera'.tr()),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        );
      },
    );

    if (source != null) {
      final XFile? file = await _picker.pickImage(source: source);
      if (file != null) {
        setState(() {
          _imagePath = file.path;
        });
        widget.onChanged(File(file.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () => _pickImage(context),
          child: CircleAvatar(
            radius: 60.r,
            backgroundImage: _imagePath != null
                ? FileImage(File(_imagePath!))
                : null,
            child: _imagePath == null ? const Icon(Icons.add_photo_alternate) : null,
          ),
        ),
        if (_imagePath != null)
          Positioned(
            top: 4.h,
            right: 4.w,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _imagePath = null;
                });
                widget.onChanged(null);
              },
              child: Container(
                padding: EdgeInsets.all(4.sp),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, size: 16.sp, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
