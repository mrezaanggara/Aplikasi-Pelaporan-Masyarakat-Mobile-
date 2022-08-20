import 'dart:ui';

import 'package:flutter/material.dart';
import 'sosial/sosial_create.dart';
import 'infrastruktur/infrastruktur_create.dart';
import 'bahaya/bahaya_create.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Laporan'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 120.0),
          Row(            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: <Widget>[
                  Ink(
                    decoration: ShapeDecoration(
                    color: Colors.greenAccent[700],
                    shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.people_alt_rounded, color: Colors.white),
                      iconSize: 150,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SosialForm()
                          )
                        );
                      },
                    ),
                  ),
                  Text('Sosial', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                ],
              ),
              Column(
                children: <Widget>[
                  Ink(
                    decoration: ShapeDecoration(
                    color: Colors.orange[400],
                    shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.house_rounded, color: Colors.white,),
                      iconSize: 150,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => InfrastrukturForm()
                          )
                        );
                      },
                    ),
                  ),
                  Text('Infrastruktur', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Ink(
            decoration: ShapeDecoration(
            color: Colors.redAccent[700],
            shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.warning_rounded,color: Colors.white,),
              iconSize: 150,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BahayaForm()
                  )
                );
              },
            ),
          ),
          Text('Bahaya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
        ],
      ),
    );
  }
}