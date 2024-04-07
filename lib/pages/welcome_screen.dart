import 'package:flutter/material.dart';
import 'package:road_oversee/pages/home_page.dart';

class HelloScreen extends StatefulWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MaterialApp(
          home: HomePage(),
        )));
      },
      child: Container(
        width: 250,
        height: 61,
        decoration: BoxDecoration(
          color: Color(0xFF6874E8),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text('Далее', style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(74, 200, 73, 130),
                    child: Column(
                      children: [
                        Text('Road Oversee', style: TextStyle(fontSize: 40),),
                        SizedBox(height: 20,),
                        Center(child: Text('Добро пожаловать!', style: TextStyle(fontSize: 24),)),
                        SizedBox(height: 20,),
                        _submitButton(),
                      ],
                    ),
              ),
              ),
               Expanded(flex: 2,child: Positioned(bottom: -1,child: Image.asset("assets/images/surface.png")))
            ],
          )
    );
  }
}
