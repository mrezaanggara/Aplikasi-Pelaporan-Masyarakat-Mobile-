import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class SIAPweb extends StatefulWidget {
   @override
   State<SIAPweb> createState() => _SIAPwebState();
 }
 
 class _SIAPwebState extends State<SIAPweb> {
   WebViewController controller;
   @override
   Widget build(BuildContext context) {
     return WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()){
              controller.goBack();
              //stay on app
              return false;
          } else {
            return true;
          }         
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('SIAP Wonodadi'),
            centerTitle: true,
          ),
          body: WebView(
            initialUrl: 'https://siap.wonodadi.id/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
            gestureRecognizers: Set()
              ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer()
              )),
          ),
        )
     );
   }
 }