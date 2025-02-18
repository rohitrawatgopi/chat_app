import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePIckerController extends GetxController {
  final ImagePicker picker = ImagePicker();

  Future<String> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      return image.path;
    } else {
      return "";
    }
  }
}
