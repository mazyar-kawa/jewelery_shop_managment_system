import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = TextEditingController();
  SpeechToText _speech = SpeechToText();
  bool _isListiner = false;
  String _search = "";

  @override
  void initState() {
    _speech = SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: TextField(
                  controller: search,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).primaryColorLight),
                    filled: true,
                    fillColor: Theme.of(context).secondaryHeaderColor,
                    hintText: '${AppLocalizations.of(context)!.search}...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).shadowColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).shadowColor, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
              ),
              AvatarGlow(
                animate: _isListiner,
                endRadius: 40,
                glowColor: Theme.of(context).primaryColorLight,
                repeat: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                duration: Duration(milliseconds: 2000),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColorLight),
                  child: IconButton(
                    onPressed: listning,
                    icon: Icon(_isListiner ? Icons.mic : Icons.mic_none),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void listning() async {
    if (!_isListiner) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListiner = true);
        _speech.listen(
            onResult: (result) => setState(() {
                  _search = result.recognizedWords;
                  search.text = _search;
                  if (result.finalResult) {
                    setState(() => _isListiner = false);
                    _speech.stop();
                  }
                }));
      }
    }
  }
}
