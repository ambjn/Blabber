import 'package:blabber/core/openAI/openAI_service.dart';
import 'package:blabber/theme/pallete.dart';
import 'package:blabber/widgets/feature_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? generatedContent;
  String? generatedImageUrl;

  final openAIService = OpenAIService();
  final flutterTts = FlutterTts();
  final searchTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
    searchTextEditingController.dispose();
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

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
      ),
      body: SingleChildScrollView(
        child: Column(
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
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 118,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/blabber_logo.jpeg'))),
                )
              ],
            ),
            // Chat Bubble
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin:
                  const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 25),
              decoration: BoxDecoration(
                  border: Border.all(color: Pallete.borderColor),
                  borderRadius: BorderRadius.circular(20).copyWith(
                      bottomLeft: Radius.zero, topRight: Radius.zero)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: generatedImageUrl != null
                    ? Container(
                        decoration: const BoxDecoration(
                            color: Pallete.assistantCircleColor),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(generatedImageUrl!),
                        ),
                      )
                    : Text(
                        generatedContent == null
                            ? "hello there, how may I assist you today?"
                            : generatedContent!,
                        style: TextStyle(
                          fontFamily: 'Cera Pro',
                          color: Pallete.mainFontColor,
                          fontSize: generatedContent == null ? 25 : 18,
                        )),
              ),
            ),
            // Here are a few features
            Container(
              padding: const EdgeInsets.only(top: 22, left: 22),
              alignment: Alignment.centerLeft,
              child: const Text("here are a few features ➡️",
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: Pallete.mainFontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 5),
            // Feature List
            const Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'ChatGPT',
                  descriptionText:
                      'a smart way to stay organized and informed with ChatGPT',
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: 'Dall-E',
                  descriptionText:
                      'Get inspired and stay creative with your personal assistant powered by Dall-E',
                ),
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: 'Smart Voice Assistant',
                  descriptionText:
                      'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                ),
              ],
            ), // Type in here
            Container(
              padding: const EdgeInsets.only(top: 10, left: 22),
              alignment: Alignment.centerLeft,
              child: const Text("type the querie up here ➡️",
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: Pallete.mainFontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Card(
                elevation: 2,
                child: TextField(
                    textAlign: TextAlign.center,
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          final speech = await openAIService.isArtPromptAPI(
                              searchTextEditingController.text
                                  .trim()
                                  .toString());
                          if (speech.contains('https')) {
                            generatedImageUrl = speech;
                            generatedContent = null;
                            setState(() {});
                          } else {
                            generatedImageUrl = null;
                            generatedContent = speech;
                            setState(() {});
                            await systemSpeak(speech);
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                          searchTextEditingController.clear();
                        },
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
