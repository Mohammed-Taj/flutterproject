import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/API/api_service.dart';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final productId = _productIdController.text;
    final name = _nameController.text;
    final description = _descriptionController.text;
    final price = _priceController.text;
    final categoryId = _categoryIdController.text;

    try {
      final response = await ApiService.updateProduct(
        productId: productId,
        name: name,
        description: description,
        price: price,
        categoryId: categoryId,
        image: _image,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _productIdController,
            decoration: InputDecoration(labelText: 'Product ID'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the product ID';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the product name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the product description';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the product price';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _categoryIdController,
            decoration: InputDecoration(labelText: 'Category ID'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the category ID';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          if (_image != null)
            Image.file(
              _image!,
              height: 150,
              fit: BoxFit.cover,
            ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _updateProduct,
            child: Text('Update Product'),
          ),
        ],
      ),
    );
  }
}
