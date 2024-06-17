import 'package:ai_assistant/utils/common_permissions.dart';
import 'package:ai_assistant/views/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:developer' as devtools show log;
import 'package:flutter_tts/flutter_tts.dart' as tts;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeCubit extends Cubit<HomeState> {
  final gemini = Gemini.instance;
  final TextEditingController textController = TextEditingController();
  tts.FlutterTts flutterTts = tts.FlutterTts();
  stt.SpeechToText flutterStt = stt.SpeechToText();
  bool speechEnabled = false;

  HomeCubit()
      : super(
          HomeState(
            messagesList: [
              ChatModel(
                isMe: false,
                userName: 'ai',
                text: 'Hello there! How can i assist you today?',
                dateTime: DateTime.now(),
              ),
            ],
            contentList: [],
            isLoading: false,
            isListening: false,
            isAudioEnabled: true,
          ),
        ) {
    configureTts();
    speakText(state.messagesList!.first.text);
    initSpeech();
  }

  /// func to toggle audio enable, disable functionality
  void updateAudioEnableValFunc(bool val) {
    emit(state.copyWith(isAudioEnabled: val));
    if (!state.isAudioEnabled!) {
      stopSpeaking();
    }
  }

  /// This has to happen only once per app
  void initSpeech() async {
    audioPermission();
    speechEnabled = await flutterStt.initialize();
  }

  /// Each time to start a speech recognition session
  void startListening() async {
    debugPrint('I am here:::::');
    state.messagesList = [
      ChatModel(
          isMe: true, userName: 'user', text: '', dateTime: DateTime.now()),
      ...state.messagesList!
    ];
    emit(state.copyWith(isListening: true, messagesList: state.messagesList));
    await flutterStt.listen(
      onResult: onSpeechResult,
      listenOptions: stt.SpeechListenOptions(enableHapticFeedback: true),
    );
  }

  void stopListening() async {
    await flutterStt.stop();
    emit(state.copyWith(isListening: false));
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    devtools.log('Recorded speech::::${result.recognizedWords}');
    state.messagesList!.first.text = result.recognizedWords;
    emit(state.copyWith(messagesList: state.messagesList));
    if (!flutterStt.isListening) {
      emit(state.copyWith(isListening: false));
      sendMessage(state.messagesList!.first, false);
    }
  }

  // configure tts
  Future<void> configureTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
  }

  /// speak text
  void speakText(String text) async {
    await flutterTts.speak(text);
  }

  // stop speaking
  void stopSpeaking() async {
    await flutterTts.stop();
  }

  // send message
  void sendMessage(ChatModel message, bool addUserMsg) {
    if (addUserMsg) {
      state.messagesList = [message, ...state.messagesList!];
    }
    emit(state.copyWith(
      messagesList: state.messagesList,
      isLoading: true,
    ));

    final Content tempContent = Content(
      parts: [
        Parts(
          text: message.text,
        )
      ],
      role: 'user',
    );
    state.contentList!.add(tempContent);

    gemini.chat(state.contentList!).then((value) {
      try {
        final Content aiResponseContent = Content(
          parts: [
            Parts(
              text: value?.output,
            )
          ],
          role: 'model',
        );
        state.contentList!.add(aiResponseContent);
        state.messagesList = [
          ChatModel(
            isMe: false,
            userName: 'gemini',
            text: value?.output ?? "",
            dateTime: DateTime.now(),
          ),
          ...state.messagesList!
        ];

        emit(state.copyWith(
          messagesList: state.messagesList,
          contentList: state.contentList,
          isLoading: false,
        ));

        /// only if the audio is enabled then let the speech to text work
        if (state.isAudioEnabled!) {
          speakText(state.messagesList!.first.text);
        }
        return devtools.log(value?.output ?? 'without output');
      } catch (e) {
        devtools.log('Error:${e.toString()}');
      }
    }).catchError((e) => devtools.log('chat', error: e));
  }
}

///
class ChatModel {
  final bool isMe;
  final String userName;
  String text;
  final DateTime dateTime;

  ChatModel({
    required this.isMe,
    required this.userName,
    required this.text,
    required this.dateTime,
  });
}
