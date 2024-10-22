
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class MyImagePicker{

  static Future<XFile?> _pickImage(bool isCam) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source:isCam?ImageSource.camera:ImageSource.gallery
        ,imageQuality:90);
    return pickedFile;
  }

  static Future<CroppedFile?> _cropImage(XFile imageFile) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
        uiSettings: [
        AndroidUiSettings(
        toolbarTitle: 'Cropper',
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
        IOSUiSettings(title: 'Cropper',
          cropStyle: CropStyle.rectangle,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],),
        ]
    );
    return croppedFile;
  }


  static Future<String> pickImage({required bool isFromCam}) async {
    final XFile? pickedFile = await _pickImage(isFromCam);
    print("pickedFile $pickedFile");
    if(pickedFile == null) {
      return "";
    }
    print("before crop");
    final CroppedFile? croppedFile = await _cropImage(pickedFile);
    print("croppedFile $croppedFile");
    if(croppedFile==null){
      return pickedFile.path;
    }
    return croppedFile.path;
  }

//for multi Image

  static Future<List<XFile>> pickMultiImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage(imageQuality: 90,);
    return images;
  }

  //for video

  static Future<XFile?> _pickVideo(bool isCam) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickVideo(source:isCam?ImageSource.camera:ImageSource.gallery);
    return pickedFile;
  }

  static Future<String> pickVideo({required bool isFromCam}) async {
    final XFile? pickedFile = await _pickVideo(isFromCam);
    if (pickedFile == null) {
      return "";
    }
    return pickedFile.path;
  }
}
