import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.201.7/api/update_product.php';

  static Future<String> updateProduct({
    required String productId,
    required String name,
    required String description,
    required String price,
    required String categoryId,
    File? image,
  }) async {
    final url = Uri.parse(_baseUrl);
    final request = http.MultipartRequest('POST', url);

    // Add text fields
    request.fields['product_id'] = productId;
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['price'] = price;
    request.fields['category_id'] = categoryId;

    // Add image file if selected
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
        ),
      );
    }

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        throw 'Failed to update product';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
