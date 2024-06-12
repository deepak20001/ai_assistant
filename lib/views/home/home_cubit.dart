import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:developer' as devtools show log;

class HomeCubit extends Cubit<HomeState> {
  final gemini = Gemini.instance;
  final TextEditingController textController = TextEditingController();

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
          ),
        );

  // send message
  void sendMessage(ChatModel message) {
    state.messagesList = [message, ...state.messagesList!];
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
      return devtools.log(value?.output ?? 'without output');
    }).catchError((e) => devtools.log('chat', error: e));
  }
}

/// Home State
class HomeState {
  List<ChatModel>? messagesList;
  List<Content>? contentList;
  bool? isLoading;

  HomeState({
    this.messagesList,
    this.contentList,
    this.isLoading,
  });

  HomeState copyWith({
    List<ChatModel>? messagesList,
    List<Content>? contentList,
    bool? isLoading,
  }) {
    return HomeState(
      messagesList: messagesList ?? this.messagesList,
      contentList: contentList ?? this.contentList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

///
class ChatModel {
  final bool isMe;
  final String userName;
  final String text;
  final DateTime dateTime;

  ChatModel({
    required this.isMe,
    required this.userName,
    required this.text,
    required this.dateTime,
  });
}
