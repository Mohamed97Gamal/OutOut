import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageFromGallery() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}
