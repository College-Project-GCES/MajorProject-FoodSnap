import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http:// 192.168.3.104:8000/predictresult'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String name;
   final int percentage;

  const Album({
    required this.name,
    required this.percentage,

  });

 
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      percentage: json['percentage'],
     
    );
  
  }
}

class _MyAppState extends State<_MyAppState> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'album_model.dart'; // Import the Album class

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<Album> albums = []; // List to hold album data

  Future<void> fetchAlbums() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (response.statusCode == 200) {
      final List<dynamic> albumData = json.decode(response.body);
      setState(() {
        albums = albumData.map((albumJson) => Album.fromJson(albumJson)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(albums[index].title),
            subtitle: Text('User ID: ${albums[index].userId}, Album ID: ${albums[index].id}'),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AlbumPage(),
  ));
}

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}