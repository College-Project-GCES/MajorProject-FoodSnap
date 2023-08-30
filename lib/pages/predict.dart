
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PredictPage extends StatefulWidget {
  const PredictPage({Key? key}) : super(key: key);

  @override
  State<PredictPage> createState() => _PredictPage();
}

class _PredictPage extends State<PredictPage> {
  
 bool _loading = true;
File? _imageFile;
List? _output;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0x004242),
    body: Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Text('Geeky Bawa',
          style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 5,),
          Text('Cats and Dogs Detector App',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 30,
            ),
          ),
          SizedBox(height: 50,),
          Center(
            child: _loading
                ? Container(
                    width: 350,
                    child: Column(
                      children: [
                        Image.asset('assets/cat_dog_icon.png'),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                : Container(
              child: Column(children: [
                Container(
                  height: 250,
                  child: Image.file(_image),
                ),
                SizedBox(height: 20,),
                _output != null ? Text('${_output[0]['label']}',
               style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),) : Container(),
                SizedBox(height: 10,)
              ],),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
        child: Container(
        width: MediaQuery.of(context).size.width - 250,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Capture a Photo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width - 250,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Select a Photo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}}