import 'dart:convert';

import 'package:flutter_shop/models/products_model.dart';
import 'package:flutter_shop/consts/api_const.dart';
import 'package:http/http.dart' as http;

class APIHandler{

  static Future<List<ProductsModel>> getAllProducts ({required String limit})async{

    var uri = Uri.https(BASE_URL,"api/v1/products" );
    //https://api.escuelajs.co/api/v1/products
    var response = await http.get(uri);
    
    //print("response ${jsonDecode(response.body)}");

    var data = jsonDecode(response.body);
    List tempList = [];

    for(var v in data){
      tempList.add(v);
    }
    return ProductsModel.productsFromSnapshot(tempList);
  }

}