import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class postController{
  List  postList =[];

  Future<void> getPost()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode ==200){
      final postData = jsonDecode(response.body);
      postList = postData;
    }else{
      throw Exception("Envalid server");
    }

  }
}