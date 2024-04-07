import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_oversee/services/firebase_auth.dart';
import 'home_page.dart';
import 'register_page.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Auth auth = Auth();
  int _selectedIndex = 1;
  dynamic pickedImage;
  bool isImageLoaded = false;
  int prize = 100;
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index) {
        case(0):
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  HomePage()));
          break;
        case(1):
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SettingsPage(),));
          break;
      }
    });
  }

  void getImageFromGallery() async {
    var tempStore = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(tempStore == null) return;
    setState(() {
      pickedImage = io.File(tempStore.path);
      isImageLoaded = true;
    });
  }
  void changeProfile() {
    print('1');
  }
  Widget _submitButton() {
    return InkWell(
      onTap: changeProfile,
      child: Container(
        width: 305,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF6874E8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text('Редактировать профиль', style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }
  Future<void> signOut() async {
    await Auth().signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: signOut,
          icon: Icon(Icons.add),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1)
                            )
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: isImageLoaded ? FileImage(pickedImage) : AssetImage('assets/images/person-4.png') as ImageProvider,
                          )
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.white
                              ),
                              color: Colors.blue

                            ),
                            child: IconButton(
                              iconSize: 20,
                              icon: Icon(Icons.edit),
                              onPressed: getImageFromGallery,
                            ),
                          ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Users').where("uid",isEqualTo: auth.currentUser!.uid).snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.docs[index];
                                var login = data['Name'] + " " + data['Surname'];
                                return Container(
                                  width: 100,
                                  height: 400,
                                  child: Column(
                                    children: [
                                      Text('$login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      SizedBox(height: 20,),
                                      Text('${data['Email']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      SizedBox(height: 20,),
                                      Text('Привнесенный вклад: $prize', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      SizedBox(height: 20,),
                                      Text('г. ${data['City']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      SizedBox(height: 50,),
                                      _submitButton()
                                    ],
                                  ),
                                );
                              },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                  ),
                  SizedBox(height: 30,),

                ],
              ),
            ),
           ]
          ),
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
