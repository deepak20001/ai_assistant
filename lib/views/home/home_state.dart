import 'package:ai_assistant/views/home/home_cubit.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class HomeState {
  List<ChatModel>? messagesList;
  List<Content>? contentList;
  bool? isLoading;
  bool? isListening;
  bool? isAudioEnabled;

  HomeState({
    this.messagesList,
    this.contentList,
    this.isLoading,
    this.isListening,
    this.isAudioEnabled,
  });

  HomeState copyWith({
    List<ChatModel>? messagesList,
    List<Content>? contentList,
    bool? isLoading,
    bool? isListening,
    bool? isAudioEnabled,
  }) {
    return HomeState(
      messagesList: messagesList ?? this.messagesList,
      contentList: contentList ?? this.contentList,
      isLoading: isLoading ?? this.isLoading,
      isListening: isListening ?? this.isListening,
      isAudioEnabled: isAudioEnabled ?? this.isAudioEnabled,
    );
  }
}
