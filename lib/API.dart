import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class Api {
  static const baseUrl = "http://192.168.201.7/api/";
  static addProduct(Map pdata) async {
    var url = Uri.parse("${baseUrl}add_product");
    try {
      final res = await http.post(url, body: pdata);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("faild to upload data");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
