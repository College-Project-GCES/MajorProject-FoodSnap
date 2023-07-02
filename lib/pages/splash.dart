import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkUserAuth().then((value) {
      if (value != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/welcome', (route) => false);
      }
    });
  }

  Future _checkUserAuth() async {
    return await _storage.read(key: "CABAVENUE_USERDATA_PASSENGER");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.white,
          ),
          const Text('splash screen',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ],
      )),
    );
  }
}
