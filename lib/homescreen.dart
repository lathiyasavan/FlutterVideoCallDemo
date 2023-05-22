import 'package:flutter/material.dart';
import 'package:saumil/main.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'Second.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'Video_url${id[0]}/${Vedio[10]['Video_Name']}')
      ..initialize().then((_) {
        Duration _co = _controller.value.duration;
        _controller.play();
        setState(() {});
        Future.delayed(
          Duration(seconds: _co.inSeconds),
          () => Get.off(SecondPage()),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: InkWell(
          onTap: () {
            Get.off(() => const SecondPage(),
                transition: Transition.leftToRight);
          },
          child: Container(
            height: Get.height / 12,
            width: Get.width / 2,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(50)),
            child: const Center(
              child: Text(
                "NEXT",
                style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
        elevation: 0,
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(strokeWidth: 3),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
