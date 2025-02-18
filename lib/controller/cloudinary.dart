import 'package:dio/dio.dart';

Future<String?> uploadImageToCloudinary(String imagePath) async {
  try {
    final String cloudName =
        "dpdjy8slm"; // Replace with your actual Cloudinary cloud name
    final String uploadPreset =
        "USERPRO"; // Replace with your actual upload preset

    final String url =
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagePath),
      "upload_preset": uploadPreset,
    });

    Dio dio = Dio();
    Response response = await dio.post(url, data: formData);

    if (response.statusCode == 200) {
      String imageUrl = response.data["secure_url"];
      print("✅ Upload successful: $imageUrl");
      return imageUrl;
    } else {
      print("❌ Upload failed: ${response.data}");
      return null;
    }
  } catch (e) {
    print("⚠️ Error uploading image: $e");
    return null;
  }
}
