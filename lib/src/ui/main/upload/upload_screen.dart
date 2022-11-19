import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
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

class _UploadScreenState extends State<UploadScreen>
    with SingleTickerProviderStateMixin {
  final captionController = TextEditingController();
  final scrollController = ScrollController();
  final focus = FocusNode();
  late VideoPlayerController videoController;
  late AnimationController animationController;
  bool loading = false;
  bool photoIsChosen = true;
  bool isPlaying = false;
  String filePath = '';

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network('dataSource');
    videoController.initialize();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

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
        controller: scrollController,
        children: [
          GestureDetector(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: Text(
                    'Would you like to pick image or video?',
                    style: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 16 * h,
                      color: AppColor.dark,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () async {
                        pickImage(true);
                        photoIsChosen = true;
                        setState(() {});
                      },
                      child: const Text(
                        'Image',
                      ),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () async {
                        Navigator.pop(context);
                        photoIsChosen = false;
                        await pickImage(false);
                        videoController =
                            VideoPlayerController.file(File(file!.path));
                        print(file!.path);
                        videoController.setLooping(true);
                        videoController.initialize().then((value) {
                          setState(() {});
                        });
                      },
                      child: const Text(
                        'Video',
                      ),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              );
              setState(() {});
            },
            child: Container(
              // width: MediaQuery.of(context).size.width,
              // height: filePath == '' ? 200 * h : 450 * h,
              margin:
                  EdgeInsets.symmetric(horizontal: 16 * w, vertical: 16 * h),
              padding:
                  EdgeInsets.symmetric(horizontal: 16 * w, vertical: 16 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColor.dark.withOpacity(0.2)),
              ),
              child: file == null
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
                  : photoIsChosen
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(image!.path),
                            height: 200 * h,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                  isPlaying
                                      ? videoController.pause()
                                      : videoController.play();
                                });
                              },
                              child: SizedBox(
                                height: videoController.value.size.height,
                                width: videoController.value.size.width,
                                child: VideoPlayer(videoController),
                              ),
                            ),
                            VideoProgressIndicator(
                              videoController,
                              allowScrubbing: true,
                            ),
                          ],
                        ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16 * w),
            child: TextField(
              focusNode: focus,
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24 * h,
              ),
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              controller: captionController,
              style: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16 * h,
                color: AppColor.dark,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIconConstraints: const BoxConstraints(minWidth: 56),
                label: const Text('Caption'),
                prefixIcon: const Icon(
                  Icons.textsms_outlined,
                ),
                floatingLabelStyle: TextStyle(color: AppColor.blue),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.blue, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.dark.withOpacity(0.2),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16 * h,
          ),
          GestureDetector(
            onTap: () async {
              if (file == null || captionController.text.isEmpty) {
                BottomWidget.modalBottom(
                  file == null ? 'Choose photo' : 'Write caption',
                  'msg',
                  h,
                  w,
                  context,
                );
              } else if (file != null && captionController.text.isNotEmpty) {
                loading = true;
                setState(() {});
                String url = await storageFirebase.upload("lenta", file!);
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
                file = null;
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
          SizedBox(
            height: 24 * h,
          ),
        ],
      ),
    );
  }

  XFile? image;
  XFile? video;
  XFile? file;

  Future pickImage(bool isImage) async {
    try {
      final file = isImage
          ? await ImagePicker().pickImage(source: ImageSource.gallery)
          : await ImagePicker().pickVideo(source: ImageSource.gallery);
      // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (file == null) {
        print('errroorororororr');
        return;
      }
      setState(() {
        this.file = file;
        filePath = this.file!.path;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick  $e');
    }
  }
}
