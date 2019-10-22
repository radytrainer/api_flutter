
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(Pixabay());

class Pixabay extends StatefulWidget {
  @override
  _PixabayState createState() => _PixabayState();
}

class _PixabayState extends State<Pixabay> {
  Map picture;
  List imgList;
  Future getPicture() async {
    http.Response response = await http.get('https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=night+person&image_type=photo&pretty=true');
    picture = json.decode(response.body);
    setState(() {
      imgList = picture['hits']; 
    });
    //debugPrint(imgList.toString());
  }
  @override
  void initState() {
    super.initState();
    getPicture();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pixabay"),
        ),
        body: ListView.builder(
          itemCount: imgList != null ? imgList.length : 0,
          itemBuilder: (context, i) {
            final img = imgList[i];
            return Card(

              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(img['largeImageURL']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(img['userImageURL']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${img['user']}"),
                        ),
                        IconButton(icon: Icon(Icons.thumb_up,color: Colors.blue,),),
                        IconButton(icon: Icon(Icons.share,color: Colors.red,),),
                      ],
                    )
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
