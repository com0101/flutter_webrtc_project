import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_project/view/webrtc_logic.dart';

import '../constants/dart/colors.dart';
import '../firebase_options.dart';
import 'item_story_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebRTCLogic webrtcLogic = WebRTCLogic();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  initializeWebRTC() async {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    webrtcLogic.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void initState() {

    initializeWebRTC();
    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        title: Text(widget.title, style: const TextStyle(fontSize: 26, color: Colors.black)),
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.group_add,
              color: greenColor,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  addStoryWidget(size: 50, iconData: Icons.add),
                  Container(
                    height: 100,
                    child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(15, (index) =>
                            storyWidget(size: 50, imgUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80")
                        )
                    ),
                  ),
                ],
              )
            ),
            const Divider(thickness: 1, color: superLightGrey),
            Row(
              children: [
                const SizedBox(width: 16),
                ElevatedButton(
                    onPressed: () async {
                      roomId = await webrtcLogic.createRoom(_remoteRenderer);
                      textEditingController.text = roomId!;
                    },
                    child: const Text('Create room')
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                    onPressed: () {
                      webrtcLogic.joinRoom(textEditingController.text, _remoteRenderer);
                    },
                    child: const Text('Join room')
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    webrtcLogic.hangUp(_localRenderer);
                  },
                  child: const Text('Hand up')
                )
              ],
            ),
            Container(
                height: 100,
                padding: const EdgeInsets.only(left: 16),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(1, (index) =>
                    GestureDetector(
                      onTap: () async {
                          await webrtcLogic.openUserMedia(_localRenderer, _remoteRenderer);
                          setState(() {

                          });
                      },
                      child: chatWidget(size: 70, imgUrl: "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                    )
                  )
                )
            ),
            Container(
                margin: const EdgeInsets.only(top: 16),
                alignment: Alignment.topLeft,
                height: 20,
                padding: const EdgeInsets.only(left: 16),
                child: const Text('Join the Room:')
            ),
            Container(
                alignment: Alignment.topLeft,
                height: 20,
                padding: const EdgeInsets.only(left: 16),
                child: Flexible(
                  child: TextFormField(

                    controller: textEditingController,
                  ),
                )
            ),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                      Expanded(child: RTCVideoView(_localRenderer, mirror: true,)),
                      Expanded(child: RTCVideoView(_remoteRenderer))
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}


