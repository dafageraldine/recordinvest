import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recordinvest/screens/web_view/webview.dart';
import 'package:recordinvest/screens/web_view/webviewnavigator.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/data.dart';

class InitialPage extends StatefulWidget {
  String urlweb;
  String title;
  InitialPage({super.key, required this.urlweb, required this.title});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final controller = Completer<WebViewController>();
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_rounded)),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          actions: [
            WebViewNavigator(controller: controller, urlweb: widget.urlweb),
          ],
          backgroundColor: theme),
      body: WebViewPage(
        controller: controller,
        urlweb: widget.urlweb,
      ),
    );
  }
}
