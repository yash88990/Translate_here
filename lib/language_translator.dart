import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslatorPage extends StatefulWidget {
  const LanguageTranslatorPage({super.key});

  @override
  State<LanguageTranslatorPage> createState() => _LanguageTranslatorPageState();
}

class _LanguageTranslatorPageState extends State<LanguageTranslatorPage> {
  final List<String> languages = ['Hindi', 'English', 'Marathi' , 'Japenese' , 'French'];
  final Map<String, String> languageCodes = {
  'Hindi': 'hi',    
  'English': 'en',  
  'Marathi': 'mr',
  'Japenese': 'ja',
  'French' : 'fr',  
};

  String originLanguage = "From";
  String destinationLanguage = "To";
  String output = "";
  final TextEditingController languageController = TextEditingController();
  final translator = GoogleTranslator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Translator'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Dropdowns for selecting languages
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Origin language dropdown
                  DropdownButton<String>(
                    hint: Text(
                      originLanguage,
                      style: const TextStyle(color: Colors.black),
                    ),
                    dropdownColor: Colors.greenAccent,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  // Destination language dropdown
                  DropdownButton<String>(
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: Colors.black),
                    ),
                    dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Input text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: languageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter text to translate',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Translate button
              ElevatedButton(
                onPressed: () async {
                  if (originLanguage != "From" &&
                      
                      destinationLanguage != "To" &&
                      languageController.text.isNotEmpty) {
                    try {
                      final translation = await translator.translate(
                        languageController.text,
                        
                        from: languageCodes[originLanguage]!,
                        to: languageCodes[destinationLanguage]!,
                        
                      );
                      setState(() {
                        output = translation.text;
                      });
                    } catch (e) {
                      setState(() {
                        output = "Error: Unable to translate text.";
                      });
                    }
                  } else {
                    setState(() {
                      output = "Please select valid languages and enter text.";
                    });
                  }
                },
                child: const Text('Translate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              // Output text
              Text(
                output,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
