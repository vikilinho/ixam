import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ixam/components/components.dart';

import 'package:ixam/models/constants.dart';
import 'package:ixam/views/validation_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({Key? key}) : super(key: key);

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  // void _upload() {
  //   if (file == null) return;
  //   String base64Image = base64Encode(file.readAsBytesSync());
  //   String fileName = file.path.split("/").last;

  //   // http.post(phpEndPoint, body: {
  //   //   "image": base64Image,
  //   //   "name": fileName,
  //   // }).then((res) {
  //   //   print(res.statusCode);
  //   // }).catchError((err) {
  //   //   print(err);
  //   // });
  // }
  late File mysignature;

  Future<String> sendImage(File file) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ProgressBar(message: "Uploading signature...");
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var candidateID = prefs.getInt('candidateID');
    print(candidateID);
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "CandidateID": candidateID,
      "SignInSignature":
          await MultipartFile.fromFile(file.path, filename: fileName),
    });
    print("I am here now");
    print(fileName);
    Response response = await Dio().delete(
      '$BASE_URL/Accreditation/candidate-signin',
      data: formData,
      options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {'Authorization': 'Bearer $token'}),
    );
    print("Didn't get here");

    Navigator.pop(context);
    if (response.statusCode == 200) {
      _showSnakBarMsg("Signature Saved!");
    } else {
      print("my response ==> ${response.statusCode}");
    }
    return response.statusMessage.toString();
  }

  void _showSnakBarMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green[700],
          content: Text(msg),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'OK',
            onPressed: () => Navigator.pop(context),
          )),
    );
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text("Please sign in the\n white space below",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Signature(
              controller: _controller,
              height: MediaQuery.of(context).size.height * 0.7,
              backgroundColor: Colors.white,
            ),
            //OK AND CLEAR BUTTONS
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
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
                        // final Uint8List? data = await _controller.toPngBytes();
                        final tempDir = await getTemporaryDirectory();
                        mysignature =
                            await new File('${tempDir.path}/signature.png')
                              ..writeAsBytesSync(data!);

                        if (data != null) {
                          await Get.defaultDialog(
                              title: "Your Signature",
                              content: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Image.memory(data),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // ElevatedButton.icon(
                                            //     onPressed: () {
                                            //       Navigator.pop(context);
                                            //     },
                                            //     icon: Icon(Icons.arrow_back),
                                            //     label: Text("Back")),
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.to(NewValidationScreen());
                                                sendImage(mysignature);
                                              },
                                              child: Text("Save"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )));
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
