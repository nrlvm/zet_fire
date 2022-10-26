import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/bloc/lenta_bloc.dart';
import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/storage/storage_firebase.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/center_dialog/bottom_widget.dart';
import 'package:zet_fire/src/colors/app_color.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final captionController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.screen,
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        elevation: 1,
        centerTitle: false,
        title: Text(
          'Upload',
          style: TextStyle(
            fontFamily: AppColor.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28 * h,
            color: AppColor.dark,
          ),
        ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              pickImage();
              setState(() {});
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  EdgeInsets.symmetric(horizontal: 16 * w, vertical: 16 * h),
              padding:
                  EdgeInsets.symmetric(horizontal: 16 * w, vertical: 16 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColor.dark.withOpacity(0.2)),
              ),
              child: image == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/bottom_icon/plus.svg',
                          color: AppColor.dark.withOpacity(0.2),
                          height: 48 * h,
                          width: 48 * h,
                        ),
                        Text(
                          'Tap to Select Image',
                          style: TextStyle(
                            fontFamily: AppColor.fontFamily,
                            fontWeight: FontWeight.w500,
                            fontSize: 24 * h,
                            color: AppColor.dark.withOpacity(0.3),
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(image!.path),
                        height: 450 * h,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          Container(
            height: 56 * h,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
              horizontal: 16 * w,
              vertical: 16 * h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16 * w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColor.dark.withOpacity(0.2)),
            ),
            child: TextField(
              controller: captionController,
              style: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16 * h,
                color: AppColor.dark,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Write caption here',
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (image == null || captionController.text.isEmpty) {
                BottomWidget.modalBottom(
                  image == null ? 'Choose photo' : 'Write caption',
                  'msg',
                  h,
                  w,
                  context,
                );
              } else if (image != null && captionController.text.isNotEmpty) {
                loading = true;
                setState(() {});
                String url = await storageFirebase.upload("lenta", image!);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String phoneMe = prefs.getString('phone_number') ?? '';
                lentaBloc.postPublication(
                  LentaModel(
                    url: url,
                    userPhone: prefs.getString('phone_number') ?? '',
                    time: DateTime.now().millisecondsSinceEpoch,
                    caption: captionController.text,
                  ),
                  phoneMe,
                );
                loading = false;
                image = null;
                captionController.text = '';
                setState(() {});
              }
            },
            child: Container(
              height: 56 * h,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 16 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.blue,
              ),
              child: Center(
                child: loading
                    ? CircularProgressIndicator(
                        color: AppColor.white,
                        strokeWidth: 2,
                      )
                    : Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: AppColor.fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 18 * h,
                          color: AppColor.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  XFile? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        this.image = image;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick img $e');
    }
  }
}
