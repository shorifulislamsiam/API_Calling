import 'package:checkandtest/API_JsonPlaceholder/postcontroller.dart';
import 'package:flutter/material.dart';

class apicall extends StatefulWidget {
  const apicall({super.key});

  @override
  State<apicall> createState() => _apicallState();
}

class _apicallState extends State<apicall> {
  postController _postController = postController();

  Future<void> _fetchPost ()async{
    await _postController.getPost();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API JsonPlaceholder"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: _postController.postList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context,index){
            var _postControll = _postController.postList[index];
              return Card(
                child: Container(
                  //height:400,
                  //width: 200,
                  color: Colors.blue,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${_postControll["id"]}"),
                          Text("${_postControll["title"]}"),
                          Text("${_postControll["body"]}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
        ),
      ),
    );
  }
}
