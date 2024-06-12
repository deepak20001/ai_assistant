// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_assistant/utils/common_path.dart';
import 'package:ai_assistant/utils/common_widgets.dart/common_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_assistant/utils/common_const.dart';
import 'package:ai_assistant/utils/common_widgets.dart/common_text.dart';
import 'package:ai_assistant/views/home/home_cubit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueGrey.shade900,
            title: CommonText(
              title: 'Chat with Gemini',
              fontSize: size.width * numD055,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              var cubitData = context.read<HomeCubit>();

              return Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: .5,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * numD30),
                      child: Lottie.asset(
                        '${CommonPath.animationPath}loader2.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: chatListWidget(size, cubitData),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * numD035,
                          vertical: size.width * numD03,
                        ),
                        child: CommonTextFormField(
                          size: size,
                          controller: cubitData.textController,
                          hintText: 'Ask your question here...',
                          maxLines: 1,
                          suffixIcon: SizedBox(
                            width: size.width * numD25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                ),
                                const Icon(
                                  Icons.attach_file,
                                  color: Colors.grey,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (cubitData
                                        .textController.text.isNotEmpty) {
                                      cubitData.sendMessage(
                                        ChatModel(
                                          isMe: true,
                                          userName: 'user',
                                          text: cubitData.textController.text,
                                          dateTime: DateTime.now(),
                                        ),
                                      );
                                      cubitData.textController.clear();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Chat list Widget
  Widget chatListWidget(Size size, HomeCubit cubitData) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: cubitData.state.messagesList!.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    var item = cubitData.state.messagesList![index];

                    if (item.isMe) {
                      return myMessageCardWidget(
                        message: item.text.toString(),
                        date: item.dateTime.toString(),
                        size: size,
                      );
                    } else {
                      return senderMessageCardWidget(
                        message: item.text.toString(),
                        date: item.dateTime.toString(),
                        size: size,
                      );
                    }
                  }),
            ),
            if (state.isLoading!)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * numD035),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Lottie.asset(
                      '${CommonPath.animationPath}loader2.json',
                      height: size.width * numD1,
                    ),
                    SizedBox(width: size.width * numD01),
                    CommonText(
                      title: 'Loading...',
                      fontSize: size.width * numD03,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  /// My message card Widget
  Widget myMessageCardWidget(
      {required final String message,
      required final String date,
      required final Size size}) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * numD90,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.black,
          margin: EdgeInsets.symmetric(
            horizontal: size.width * numD033,
            vertical: size.width * numD015,
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * numD04,
                  right: size.width * numD05,
                  top: size.width * numD01,
                  bottom: size.width * numD05,
                ),
                child: CommonText(
                  title: message,
                  fontSize: size.width * numD038,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: size.width * numD01,
                right: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * numD03),
                  child: Row(
                    children: [
                      CommonText(
                        title: DateFormat.jm().format(DateTime.parse(date)),
                        fontSize: size.width * numD025,
                        color: Colors.white60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Sender message card widget
  Widget senderMessageCardWidget(
      {required final String message,
      required final String date,
      required final Size size}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * numD90,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.grey.shade200,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: CommonText(
                  title: message,
                  fontSize: size.width * numD038,
                  color: Colors.black,
                ),
              ),
              Positioned(
                bottom: size.width * numD01,
                right: size.width * numD025,
                child: CommonText(
                  title: DateFormat.jm().format(DateTime.parse(date)),
                  fontSize: size.width * numD025,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
