import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini API',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(66, 133, 244, 0.5)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Gemini API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Gemini API
  GenerateContentResponse? response;
  final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "AIzaSyAGlCgfC6omu-q36t5RJDpj4wJ-m2PKsj8",
      generationConfig: GenerationConfig(
        temperature: 0.5,
      ));

  final myController = TextEditingController();
  String prompt = "";

  void _tryGeminiAI() {
    prompt = myController.text;
    // setState() async olduğu için error veriyor, sorun değil.
    setState(() async {
      final content = [Content.text(prompt)];
      response = await model.generateContent(content);
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.question_answer_rounded),
                    title: TextField(
                      controller: myController,
                    ),
                    subtitle: Text(response?.text ?? ""),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tryGeminiAI,
        tooltip: 'Generate',
        child: const Icon(Icons.question_mark_rounded),
        backgroundColor: Color.fromRGBO(66, 133, 244, 1),
        foregroundColor: Colors.white,
      ),
    );
  }
}
