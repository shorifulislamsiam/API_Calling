import "dart:convert";
import "package:checkandtest/apicalling/Model/Productmodel.dart";
import "package:checkandtest/apicalling/urls.dart";
import"package:http/http.dart" as http;

class productController{
  ProductsModel?productsModel;
  List<Data> products=[];
  Future<void> fetchProduct()async{
    try{
      final response=await http.get(Uri.parse(urls.readProduct));
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        ProductsModel model = ProductsModel.fromJson(data);
        products =model.data??[];//"data"
        print("hello${response.body}");
      }else{
        print("server error: ${response.statusCode}");
      };
    }
    catch(e){
      print("Error: $e");
    }
    }

    Future<void> createProducts(String name,String img,int qty,int unitPrice,int totalPrice)async{
    try{
      final response =await http.post(Uri.parse(urls.createProduct),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(
              {
                "ProductName": name,
                "ProductCode": DateTime.now().microsecondsSinceEpoch,
                "Img": img,
                "Qty": qty,
                "UnitPrice": unitPrice,
                "TotalPrice": totalPrice
              }
          )
      );
      print(response);
      if(response.statusCode == 200){
        fetchProduct();

      }else{
        print("Server error: ${response.statusCode}");
      }
    }catch(e){
      print("Error: $e");
    }
    }
    //For Update Product
  Future<void> updateProducts(String id,String name,String img,int qty,int unitPrice,int totalPrice)async{
    try{
      final response =await http.post(Uri.parse(urls.updateProduct(id)),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(
              {
                "ProductName": name,
                "ProductCode": DateTime.now().microsecondsSinceEpoch,
                "Img": img,
                "Qty": qty,
                "UnitPrice": unitPrice,
                "TotalPrice": totalPrice
              }
          )
      );
      print(response);
      if(response.statusCode == 200){
        fetchProduct();

      }else{
        print("Server error: ${response.statusCode}");
      }
    }catch(e){
      print("Error: $e");
    }
  }

  Future<bool> deleteProduct(String id)async{
    final response= await http.get(Uri.parse(urls.deleteProduct(id)));
    print(response.statusCode);
    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
  }


}
