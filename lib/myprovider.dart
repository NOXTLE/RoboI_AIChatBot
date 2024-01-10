import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:statem/apikey.dart';

class pageProvider extends ChangeNotifier {
  List list = [];
  bool loading = false;
  String imagePath = "";
  String image = "";
//function to call gemini

  Future<String> geminiCall(String query, context) async {
    loading = true;

    var gemini = GoogleGemini(apiKey: apikey);
    if (imagePath.isEmpty) {
      var res;
      try {
        res = await gemini.generateFromText(
            "Your name is RoboI You are Developed by Aditya. always try to answer in under 50 words if it is story or poem take as many lines as you want.answer the following prompt and never mention about word count word limit or anything else just answer to the prompt in simple words and use emoji  but dont use emoji while  writing applicatoin letter etc, .also behave very friendly. the prompt is $query  ");
      } catch (e) {
        loading = false;
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "An Error Occured . Check The Internet or Restart the app"
                          .toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ));
        appBarColor = Color.fromARGB(255, 176, 39, 39).withAlpha(200);
        loading = false;
        notifyListeners();
      }
      loading = false;
      appBarColor = Color.fromARGB(255, 114, 213, 129).withAlpha(200);
      list.insert(0, "Gemini :  ${res.text}");
      print(res.text);
      notifyListeners();
    } else {
      appBarColor = Color.fromARGB(255, 90, 229, 111).withAlpha(200);

      var res;
      try {
        res = await gemini.generateFromTextAndImages(
            query: query, image: File(imagePath));
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "An Error Occured . Check The Internet or Restart the app"
                          .toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ));
        appBarColor = Color.fromARGB(255, 176, 39, 39).withAlpha(200);
        notifyListeners();
        loading = false;
      }

      loading = false;
      appBarColor = Color.fromARGB(255, 90, 229, 111).withAlpha(200);

      list.insert(0, "Gemini:  ${res.text}");
      imagePath = "";
      notifyListeners();
    }
    return "ok";
  }
  //function to add user text

  var appBarColor = Color.fromARGB(255, 39, 85, 176).withAlpha(200);
  void userQuery(String query) {
    if (imagePath.isEmpty) {
      list.insert(0, "You:  $query");
      appBarColor = Color.fromARGB(255, 39, 85, 176).withAlpha(200);

      notifyListeners();
    } else {
      appBarColor = Color.fromARGB(255, 39, 85, 176).withAlpha(200);

      list.insert(0, "_" + imagePath);

      list.insert(0, "You : " + query);
      image = "";

      notifyListeners();
    }
  }

  List<DropdownMenuItem> act = [
    DropdownMenuItem(child: Text("Teacher")),
    DropdownMenuItem(child: Text("Businessman")),
    DropdownMenuItem(child: Text("Artist"))
  ];

  void removeImage() {
    imagePath = "";
    image = "";
    notifyListeners();
  }

  void myModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 150,
                child: Column(
                  children: [
                    Text("Select An Image",
                        style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 24))),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  var img = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  state(() {
                                    imagePath = img!.path;
                                    image = img.path;
                                  });
                                  print(imagePath);
                                  notifyListeners();
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera)),
                            const Text(
                              "Camera",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  var img = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  imagePath = img!.path;
                                  state(() => imagePath = img.path);
                                  state(() => image = img.path);
                                  notifyListeners();
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.photo)),
                            const Text("Gallery",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    )
                  ],
                ));
          });
        });
  }
}
