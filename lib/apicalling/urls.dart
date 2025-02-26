
class urls{
  static String baseUrl= "http://35.73.30.144:2008/api/v1";
  static String createProduct = "$baseUrl/CreateProduct";
  static String readProduct = "$baseUrl/ReadProduct";
  //static String updateProduct = "${{baseUrl}}/UpdateProduct/65abe919f68794d36c5b7ffa";
  static String updateProduct(String id) => '$baseUrl/UpdateProduct/${id}';
  static String deleteProduct(String id) => "$baseUrl/DeleteProduct/${id}";
}