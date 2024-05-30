import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter info projects',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  List data = [];

  @override
  void initState(){
    super.initState();
    fetchData();
  }

  fetchData() async {
    const BASE_URL = 'http://localhost:8000/areas/get-areas-all';
    final response = await http.get(Uri.parse(BASE_URL));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    if(response.statusCode == 200){
      setState(() {
        data = json.decode((response.body));
      });
    }else{
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter info project Areas'),
      ),
      body: data.isEmpty ? const Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount:  data.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(data[index]['descripcion']),
            subtitle: Text(data[index]['id_area'].toString()),
          );
        }
      )
    );
  }

}