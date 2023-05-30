import 'package:blabber/theme/pallete.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'blabber💬',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 2),
        ),
        leading: const Icon(Icons.menu),
      ),
      body: Column(
        children: [
          // Blabber Logo
          Stack(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle),
                ),
              ),
              Container(
                height: 118,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/blabber_logo.jpeg'))),
              )
            ],
          ),
          // Chat Bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin:
                const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
            decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: BorderRadius.circular(20)
                    .copyWith(topLeft: Radius.zero, topRight: Radius.zero)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("hey, what task can i do for you?",
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Pallete.mainFontColor,
                    fontSize: 25,
                  )),
            ),
          ),
          // Here are a few features
          Container(
            padding: const EdgeInsets.only(top: 22, left: 22),
            alignment: Alignment.centerLeft,
            child: const Text("here are a few features",
                style: TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Pallete.mainFontColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          // Feature List
        ],
      ),
    );
  }
}
