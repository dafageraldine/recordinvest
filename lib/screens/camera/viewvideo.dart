import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ViewVideoScreen extends StatefulWidget {
  final String path;
  const ViewVideoScreen(this.path, {Key? key}) : super(key: key);

  @override
  ViewVideoScreenState createState() => ViewVideoScreenState();
}

class ViewVideoScreenState extends State<ViewVideoScreen> {
  late VideoPlayerController videoController;
  late ChewieController chewieController;
  late Future<void> future;

  Future<void> initVideoPlayer() async {
    await videoController.initialize();
    setState(() {
      chewieController = ChewieController(
        allowedScreenSleep: false,
        allowFullScreen: true,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp, DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
        aspectRatio: videoController.value.aspectRatio,
        videoPlayerController: videoController,
        autoInitialize: true,
        autoPlay: true,
        showControls: true,
        allowPlaybackSpeedChanging: false,
        showOptions: false,
        deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
        materialProgressColors: ChewieProgressColors(backgroundColor: Colors.grey.shade100, bufferedColor: Colors.grey.shade300, playedColor: Colors.teal.shade600, handleColor: Colors.white),
      );
    });
    videoController.addListener(() {
      if (videoController.value.position == videoController.value.duration) {
        // Timer(const Duration(milliseconds: 400), () => {Get.back()});
      }
    });
  }

  @override
  initState() {
    super.initState();
    videoController = VideoPlayerController.file(File(widget.path));
    future = initVideoPlayer();
  }

  @override
  void dispose() {
    videoController.dispose();
    chewieController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                return Center(
                  child: videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: Chewie(controller: chewieController),
                        )
                      : const SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
