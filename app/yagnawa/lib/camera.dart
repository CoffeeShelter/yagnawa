import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();

Future<PickedFile?> chooseImage() async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return pickedFile;
  }
  return null;
}

Future<PickedFile?> getImage() async {
  final pickedFile = await picker.getImage(source: ImageSource.camera);

  if (pickedFile != null) {
    return pickedFile;
  }
  return null;
}
