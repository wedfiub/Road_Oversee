

import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:road_oversee/pages/settings_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_oversee/widgets/map_screen.dart';
import '../services/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  dynamic pickedImage;
  bool isImageLoaded = false;
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch(index) {
      case(0):
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MaterialApp(home: HomePage())));
        break;
      case(1):
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MaterialApp(home: SettingsPage(),)));
        break;
    }
  }
  void getImageFromGallery() async {
    var tempStore = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(tempStore == null) return;
    setState(() {
      pickedImage = io.File(tempStore.path);
      isImageLoaded = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 200, 10, 30),
        width: double.infinity,
        height: 200,
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: 250,
                height: 61,
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: MapScreen()
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF6874E8),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera),
              label: 'Обнаружение',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль'
          )
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class MoscowLocation extends AppLatLong {
  const MoscowLocation({
    super.lat = 55.7522200,
    super.long = 37.6155600,
  });
}