import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:plack/controller/speechController.dart';

import '../activity_indicator/activity_indicator.dart';

class LanguageTranslatorView extends StatefulWidget {
  @override
  _LanguageTranslatorViewState createState() => _LanguageTranslatorViewState();
}

class _LanguageTranslatorViewState extends State<LanguageTranslatorView> {
  List<IdentifiedLanguage> _identifiedLanguages = <IdentifiedLanguage>[];
  final _languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
  var _identifiedLanguage = '';
  String? _translatedText;
  final _controller = TextEditingController();
  final _modelManager = OnDeviceTranslatorModelManager();
  var _sourceLanguage = TranslateLanguage.english;
  var _targetLanguage = TranslateLanguage.chinese;
  late final _onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: _sourceLanguage, targetLanguage: _targetLanguage);
  speechController speech=Get.find();
  @override
  void dispose() {
    _languageIdentifier.close();
    _onDeviceTranslator.close();
    speech.flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _downloadTargetModel();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Plack文本翻译'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(height: 30),
              Center(
                  child: Text('请输入文本 (原语言: ${_identifiedLanguage})')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      )),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(border: InputBorder.none),
                    maxLines: null,
                  ),
                ),
              ),
              Center(
                  child: Text(
                      '翻译后 (现语言:中文)')),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                        )),
                    child: Text(_translatedText ?? '')),
              ),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: (){_downloadSourceModel();_identifyLanguage();_translateText();speech.flutterTts.speak(_translatedText??"");}, child: Text('开始翻译'))
              ]),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: (){_isSourceModelDownloaded();_isTargetModelDownloaded();},
                      child: Text('点击检查网络连接')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _downloadSourceModel() async {
    Toast().show(
        'Downloading model (${_sourceLanguage.name})...',
        _modelManager
            .downloadModel(_sourceLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _downloadTargetModel() async {
    Toast().show(
        'Downloading model (${_targetLanguage.name})...',
        _modelManager
            .downloadModel(_targetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteSourceModel() async {
    Toast().show(
        'Deleting model (${_sourceLanguage.name})...',
        _modelManager
            .deleteModel(_sourceLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteTargetModel() async {
    Toast().show(
        'Deleting model (${_targetLanguage.name})...',
        _modelManager
            .deleteModel(_targetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _isSourceModelDownloaded() async {
    Toast().show(
        'Checking if model (${_sourceLanguage.name}) is downloaded...',
        _modelManager
            .isModelDownloaded(_sourceLanguage.bcpCode)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _isTargetModelDownloaded() async {
    Toast().show(
        'Checking if model (${_targetLanguage.name}) is downloaded...',
        _modelManager
            .isModelDownloaded(_targetLanguage.bcpCode)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _translateText() async {
    FocusScope.of(context).unfocus();
    final result = await _onDeviceTranslator.translateText(_controller.text);
    setState(() {
      _translatedText = result;
    });
  }
  Future<void> _identifyLanguage() async {
    if (_controller.text == '') return;
    String language;
    try {
      language = await _languageIdentifier.identifyLanguage(_controller.text);
    } on PlatformException catch (pe) {
      if (pe.code == _languageIdentifier.undeterminedLanguageCode) {
        language = 'error: no language identified!';
      }
      language = 'error: ${pe.code}: ${pe.message}';
    } catch (e) {
      language = 'error: ${e.toString()}';
    }
    setState(() {
      _identifiedLanguage = language;
      _sourceLanguage=BCP47Code.fromRawValue(language)!;
    });
  }
  Future<void> _identifyPossibleLanguages() async {
    if (_controller.text == '') return;
    String error;
    try {
      final possibleLanguages =
      await _languageIdentifier.identifyPossibleLanguages(_controller.text);
      setState(() {
        _identifiedLanguages = possibleLanguages;
      });
      return;
    } on PlatformException catch (pe) {
      if (pe.code == _languageIdentifier.undeterminedLanguageCode) {
        error = 'error: no languages identified!';
      }
      error = 'error: ${pe.code}: ${pe.message}';
    } catch (e) {
      error = 'error: ${e.toString()}';
    }
    setState(() {
      _identifiedLanguages = [];
      _identifiedLanguage = error;
    });
  }
}
