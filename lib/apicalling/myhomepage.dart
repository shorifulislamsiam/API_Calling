import 'package:checkandtest/apicalling/productcontroller.dart';
import 'package:flutter/material.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  final productController _products =productController();


  void productDialog(
      {String? id,
        String? ProductName,
        String? Img,
        int?Qty,
        int?UnitPrice,
        int? TotalPrice}){
    TextEditingController _productNameController = TextEditingController();
    TextEditingController _productCodeController = TextEditingController();
    TextEditingController _productQtyController = TextEditingController();
    TextEditingController _productImageController = TextEditingController();
    TextEditingController _productUnitPricrController = TextEditingController();
    TextEditingController _productTotalPriceController = TextEditingController();

    _productNameController.text =ProductName?? "";
    _productImageController.text = Img ?? "";
    _productQtyController.text = Qty != null? Qty.toString():"0";

    _productUnitPricrController.text =UnitPrice != null? UnitPrice.toString():"0";
    _productTotalPriceController.text = TotalPrice!=null?TotalPrice.toString():"0";


    showDialog(
        context: context,
        builder: (context ){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlertDialog(
                title: Text(id == null?"Add Dialog":"Update Dialog"),
                content: Column(
                  children: [
                    TextField(
                      controller: _productNameController,
                      decoration: InputDecoration(
                        labelText: "Product Name",
                      ),
                    ),
                    TextField(
                      controller: _productImageController,
                      decoration: InputDecoration(
                        labelText: "Product Image",
                      ),
                    ),
                    TextField(
                      controller: _productQtyController,
                      decoration: InputDecoration(
                        labelText: "Product Quantity",
                      ),
                    ),
                    TextField(
                      controller: _productUnitPricrController,
                      decoration: InputDecoration(
                        labelText: "Product Unit Price",
                      ),
                    ),
                    TextField(
                      controller: _productTotalPriceController,
                      decoration: InputDecoration(
                        labelText: "Product Total Price",
                      ),
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green
                        ),
                          onPressed: ()async{
                           if(id == null){
                             _products.createProducts(
                                 _productNameController.text,
                                 _productImageController.text,
                                 int.parse(_productQtyController.text),
                                 int.parse(_productUnitPricrController.text),
                                 int.parse(_productTotalPriceController.text)
                             );
                           }else {
                             _products.updateProducts(
                                 id,
                                 _productNameController.text,
                                 _productImageController.text,
                                 int.parse(_productQtyController.text),
                                 int.parse(_productUnitPricrController.text),
                                 int.parse(_productTotalPriceController.text)
                             );
                           }
                            await _fetchData();
                            setState(() {

                            });
                            Navigator.pop(context);
                          },
                          child: Text(id == null?"Submit":"Update")),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.red
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("No")),
                    ],
                  )
                ],
              ),
            ],
          );
        }
    );
  }

  Future<void> _fetchData()async{
    await _products.fetchProduct();
    setState(() {

    });
  }

  @override
  void initState(){
    super.initState();
    _fetchData();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Check"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("total: ${_products.products.length.toString()}"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _products.fetchProduct(),
          builder: (context, snapshot){
            if (snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasError){
              return Center(child: Text("Error: ${snapshot.error}"),);
            }else{


          return ListView.builder(
            itemCount: _products.products.length,
              itemBuilder: (context, index){
              var productss=_products.products[index];
              return Card(
                color: Colors.green,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  leading: CircleAvatar(
                    child: FittedBox(
                      fit: BoxFit.fill,
                        child: Image.network("${productss.img}")),//Text("${productss.productName?.substring(0,2)}")),
                  ),
                  title: Text("${productss.productName}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Qty: ${productss.qty}"),
                      Text("Id:${productss.productCode}")
                    ],
                  ),
                  trailing: Container(
                    width: 100,
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("UP:${productss.unitPrice}"),
                          Text("totalprice: ${productss.totalPrice}"),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child:
                                    IconButton(
                                        onPressed: (){
                                          print("Editing product with:");
                                          print("ID: ${productss.sId}");
                                          print("Name: ${productss.productName}");
                                          print("Qty: ${productss.qty}");
                                          print("Image: ${productss.img}");
                                          print("UnitPrice: ${productss.unitPrice}");
                                          print("TotalPrice: ${productss.totalPrice}");
                                          productDialog(
                                            id: productss.sId,
                                            ProductName: productss.productName,
                                            Img: productss.img,
                                            Qty: productss.qty,
                                            UnitPrice: productss.unitPrice,
                                            TotalPrice: productss.totalPrice,
                                          );
                                          print("click it");
                                        },
                                        icon: Icon(Icons.edit,
                                          color: Colors.white,
                                        ),
                                    ),
                                ),
                                Expanded(
                                    child: IconButton(
                                        onPressed: (){
                                          _products.deleteProduct(productss.sId.toString());
                                          setState(() {

                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              }
          );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            productDialog();
          },
        child: Icon(Icons.add),
      ),
    );
  }
}



// ListView.builder(
// itemCount: _products.products.length,
// itemBuilder: (context, index){
// final productss=_products.products[index];
// return Card(
// color: Colors.green,
// elevation: 4,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20),
// ),
// child: ListTile(
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// leading: CircleAvatar(
// child: FittedBox(
// fit: BoxFit.fill,
// child: Text("${productss["ProductName"].substring(0,2)}")),
// ),
// title: Text("${productss["ProductName"]}"),
// subtitle: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text("Qty: ${productss["Qty"]}"),
// Text("Id:${productss["ProductCode"]}")
// ],
// ),
// trailing: Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Text("UP:${productss["UnitPrice"]}"),
// Text("totalprice: ${productss["UnitPrice"]}")
// ],
// ),
// ),
// );
// }
// ),