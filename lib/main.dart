import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

 

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = "https://raw.githubusercontent.com/johanissac/samplejson/master/db.json";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String>getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );
  
    

    setState(() {
      var converDataToJson = jsonDecode(response.body);
      data = converDataToJson['results'];
      print(data[1]);
    });
    return "Success";
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: Center(
        
        child:ListView.builder(
          itemCount: data==null ?0: data.length,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (BuildContext ctxt, int index) {
            return Card(
              child: ListTile(
                title: Text(
                  data[index]['homeworld'],
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: data[index]['homeworld'] == null
                        ? Image(
                            image: AssetImage('images/no_image_available.png'),
                          )
                        : Image.network(data[index]['homeworld']),
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                onTap: () => {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute(index,data)),
                  )
                },
              ),
      );}
        ),
      ),
    
       
    );
  }
}

class SecondRoute extends StatelessWidget{
  List data;
  int title;
  var index;
  String description;
  
  

  SecondRoute(this.title, this.data){
    index = title.toString();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        margin : new EdgeInsets.all(70.0),
        child: new Column(
          children : <Widget>[
            new Text(this.index),
            new Text(data[title]['homeworld']),
            
          ]
        )
      )
    );
  }
}

