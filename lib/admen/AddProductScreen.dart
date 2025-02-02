import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image picked successfully!')),
        );
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  Future<void> addProduct() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image.')),
      );
      return;
    }

    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        categoryIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields.')),
      );
      return;
    }

    // Validate price and category ID
    final price = double.tryParse(priceController.text);
    final categoryId = int.tryParse(categoryIdController.text);
    if (price == null || categoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid price and category ID.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final uri = Uri.parse('http://192.168.201.7/api/add_product.php');
    final request = http.MultipartRequest('POST', uri);

    // Add text fields
    request.fields['name'] = nameController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['price'] = priceController.text;
    request.fields['category_id'] = categoryIdController.text;

    // Add image file
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      _image!.path,
    ));

    try {
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print("Response: $responseData"); // Debugging: Print the raw response

      final data = json.decode(responseData);

      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully!')),
        );
        // Clear form after successful submission
        nameController.clear();
        descriptionController.clear();
        priceController.clear();
        categoryIdController.clear();
        setState(() {
          _image = null;
        });

        // Return true to indicate success
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: ${data['message']}')),
        );
      }
    } catch (e) {
      print("Error adding product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildFormField(TextEditingController controller, String labelText,
      {TextInputType? keyboardType, IconData? icon}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      enabled: !_isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildFormField(nameController, 'Name',
                          icon: Icons.title),
                      SizedBox(height: 16),
                      _buildFormField(descriptionController, 'Description',
                          icon: Icons.description),
                      SizedBox(height: 16),
                      _buildFormField(priceController, 'Price',
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          icon: Icons.attach_money),
                      SizedBox(height: 16),
                      _buildFormField(categoryIdController, 'Category ID',
                          keyboardType: TextInputType.number,
                          icon: Icons.category),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _image == null
                          ? Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _image!,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _pickImage,
                        icon: Icon(Icons.camera_alt),
                        label: Text('Pick Image'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _isLoading ? null : addProduct,
                      child: Text(
                        'Add Product',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
