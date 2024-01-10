import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:statem/containerpage.dart';
import 'package:statem/myprovider.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ItemScrollController abc = ItemScrollController();
  var defaultval = "Teacher";

  @override
  Widget build(BuildContext context) {
    TextEditingController query = TextEditingController();

    return Consumer<pageProvider>(builder: (context, value, child) {
      if (value.list.length > 2) {
        abc.jumpTo(index: 1, alignment: BorderSide.strokeAlignInside + 1.2);
      }
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: value.appBarColor,
            flexibleSpace: ClipRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.transparent),
            )),
            scrolledUnderElevation: 2,
            centerTitle: true,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/asset/dcmqphz-691e6781-8613-4994-9d68-c033ffa6280b.gif",
                  height: 50,
                  width: 50,
                ),
                Text("RoboI", style: GoogleFonts.antic()),
              ],
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              value.list.isEmpty
                  ? Expanded(child: Center(child: ContainerPage()))
                  : Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: ScrollablePositionedList.builder(
                              itemScrollController: abc,
                              reverse: true,
                              itemCount: value.list.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: value.list[index][0] == "Y" ||
                                          value.list[index][0] == "_"
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                          color: value.list[index][0] == "Y" ||
                                                  value.list[index][0] == "_"
                                              ? Colors.cyan
                                              : Color.fromARGB(
                                                  255, 112, 221, 116),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: value.list[index][0] == "_"
                                            ? GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                            child: Image.file(
                                                          File(value.list[index]
                                                              .substring(1)),
                                                        ));
                                                      });
                                                },
                                                child: Image.file(File(value
                                                    .list[index]
                                                    .substring(1))),
                                              )
                                            : SelectableText(
                                                value.list[index].toString(),
                                                style: GoogleFonts.robotoMono(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16)),
                                              ),
                                      ),
                                    ),
                                  ),
                                );
                              }))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera_enhance_rounded),
                      onPressed: () {
                        value.myModal(context);
                      },
                    ),
                    value.image.isNotEmpty
                        ? Container(
                            child: Stack(children: [
                              Image.file(
                                File(value.image),
                                height: 50,
                                width: 50,
                              ),
                              IconButton(
                                icon: Icon(Icons.highlight_remove_outlined),
                                onPressed: () {
                                  value.removeImage();
                                },
                              )
                            ]),
                          )
                        : Text(""),
                    Expanded(
                      child: TextField(
                        controller: query,
                        decoration: const InputDecoration(
                            hintText: "Enter Your Prompt",
                            hintStyle:
                                TextStyle(color: Color.fromARGB(112, 0, 0, 0)),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    value.loading == true
                        ? const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                semanticsLabel: "Loading",
                                color: Colors.white,
                              ),
                            ),
                          )
                        : IconButton(
                            highlightColor: Colors.blue,
                            icon: const Icon(
                              Icons.send,
                            ),
                            onPressed: () {
                              if (query.text.isNotEmpty) {
                                value.userQuery(query.text);
                                value.geminiCall(query.text, context);
                                query.clear();
                              }
                            },
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
