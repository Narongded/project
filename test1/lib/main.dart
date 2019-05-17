import 'dart:io';

import 'package:flutter/material.dart';


import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
File image;
String filename;
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

Future _getImage() async{
  var selectImage= await ImagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
   image=selectImage;
   filename=basename(image.path);
  });
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: image==null?Text("data"): uploadArea(),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Increment',
        child: Icon(Icons.image),
      ),
    );
  }
}
Widget uploadArea(){
  return Column(
    children: <Widget>[
      Image.file(image, width:double.infinity),
      RaisedButton(
        color: Colors.yellow,
        child: Text('upload'),
        onPressed: (){
          uploadImage();
        },
      )
    ],
  );
}
Future<String> uploadImage() async{
  StorageReference ref = FirebaseStorage.instance.ref().child(filename);
  ref.putFile(image);
  return '';
}