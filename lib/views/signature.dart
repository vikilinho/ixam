import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({Key? key}) : super(key: key);

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  late File file;

  void _upload() {
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    // http.post(phpEndPoint, body: {
    //   "image": base64Image,
    //   "name": fileName,
    // }).then((res) {
    //   print(res.statusCode);
    // }).catchError((err) {
    //   print(err);
    // });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            //SIGNATURE CANVAS
            Center(child: Text("Sign in below")),

            Signature(
              controller: _controller,
              height: MediaQuery.of(context).size.height * 0.9,
              backgroundColor: Colors.grey,
            ),
            //OK AND CLEAR BUTTONS
            Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //SHOW EXPORTED IMAGE IN NEW ROUTE
                  IconButton(
                    icon: const Icon(Icons.check),
                    color: Colors.green,
                    onPressed: () async {
                      if (_controller.isNotEmpty) {
                        final Uint8List? data = await _controller.toPngBytes();
                        final String? base64Image = base64Encode(data!);
                        if (data != null) {
                          // await Navigator.of(context).push(
                          //   MaterialPageRoute<void>(
                          //     builder: (BuildContext context) {
                          //       return Scaffold(
                          //         appBar: AppBar(),
                          //         body: Center(
                          //           child: Container(
                          //             color: Colors.grey[300],
                          //             child: Image.memory(data),
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // );

                        }
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.undo),
                    color: Colors.green,
                    onPressed: () {
                      setState(() => _controller.undo());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.redo),
                    color: Colors.green,
                    onPressed: () {
                      setState(() => _controller.redo());
                    },
                  ),
                  //CLEAR CANVAS
                  IconButton(
                    icon: const Icon(Icons.clear),
                    color: Colors.green,
                    onPressed: () {
                      setState(() => _controller.clear());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
