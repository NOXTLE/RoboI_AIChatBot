import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        List<String> quote = [
          "Welcome to RoboI . RoboI is a Generative AI , it can understand images and can do multiple tasks like -'Writing a Story, Making Jokes , Finding Meanings of images etc.'",
          "Use Camera Button to Add Image from Gallary or Camera , but remember not to use more than one images as only one picture can be send to RoboI",
          "Use Different types of prompts for interaction with RoboI . It is Very Friendly and Consice ",
        ];
        var delay = 100;
        delay = delay + 100;
        return Transform.translate(
          offset: Offset(0, 100),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FadeInDown(
              delay: Duration(milliseconds: delay + 100),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow[200],
                ),
                height: MediaQuery.of(context).size.height / 6,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "lib/asset/3662817.png",
                        height: 100,
                        width: MediaQuery.of(context).size.width / 8,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(quote[index],
                            softWrap: true,
                            style: GoogleFonts.robotoMono(
                                textStyle: const TextStyle(fontSize: 16))),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
