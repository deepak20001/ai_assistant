// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_assistant/utils/common_colors.dart';
import 'package:ai_assistant/utils/common_path.dart';
import 'package:ai_assistant/utils/common_widgets.dart/common_textformfield.dart';
import 'package:ai_assistant/views/home/home_state.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_assistant/utils/common_const.dart';
import 'package:ai_assistant/utils/common_widgets.dart/common_text.dart';
import 'package:ai_assistant/views/home/home_cubit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nil/nil.dart';

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
            actions: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<HomeCubit>().updateAudioEnableValFunc(!state.isAudioEnabled!);
                    },
                    icon: Image.asset(
                      state.isAudioEnabled!
                          ? '${CommonPath.iconPath}enable_audio.png'
                          : '${CommonPath.iconPath}disable_audio.png',
                      height: size.width * numD045,
                      color: CommonColors.whiteColor,
                    ),
                  );
                },
              ),
            ],
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
                        child: _chatListWidget(size, cubitData),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * numD035,
                          vertical: size.width * numD03,
                        ),
                        child: Row(
                          children: [
                            Expanded(
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
                                      /*  const Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey,
                                      ),
                                      const Icon(
                                        Icons.attach_file,
                                        color: Colors.grey,
                                      ), */
                                      IconButton(
                                        onPressed: () {
                                          if (cubitData
                                              .textController.text.isNotEmpty) {
                                            cubitData.sendMessage(
                                              ChatModel(
                                                isMe: true,
                                                userName: 'user',
                                                text: cubitData
                                                    .textController.text,
                                                dateTime: DateTime.now(),
                                              ),
                                              true,
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
                            SizedBox(width: size.width * numD02),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                if (state.isListening!) {
                                  debugPrint('stop listening');
                                  cubitData.stopListening();
                                } else {
                                  debugPrint('start listening');
                                  cubitData.startListening();
                                }
                              },
                              child: AvatarGlow(
                                animate: state.isListening!,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: state.isListening!
                                      ? const Icon(Icons.mic_off)
                                      : const Icon(Icons.mic),
                                ),
                              ),
                            ),
                          ],
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
  Widget _chatListWidget(Size size, HomeCubit cubitData) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: size.width * numD03),
                  shrinkWrap: true,
                  itemCount: cubitData.state.messagesList!.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    var item = cubitData.state.messagesList![index];

                    if (item.isMe) {
                      return _myMessageCardWidget(
                        message: item.text.toString(),
                        date: item.dateTime.toString(),
                        size: size,
                      );
                    } else {
                      return _senderMessageCardWidget(
                        message: item.text.toString(),
                        date: item.dateTime.toString(),
                        size: size,
                        cubitData: cubitData,
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
  Widget _myMessageCardWidget(
      {required final String message,
      required final String date,
      required final Size size}) {
    return message.isNotEmpty
        ? Align(
            alignment: Alignment.centerRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width * numD85,
              ),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.black,
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * numD03,
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
                              title:
                                  DateFormat.jm().format(DateTime.parse(date)),
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
          )
        : nil;
  }

  /// Sender message card widget
  Widget _senderMessageCardWidget({
    required final String message,
    required final String date,
    required final Size size,
    required final HomeCubit cubitData,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * numD90,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * numD035),
              child: Image.asset(
                '${CommonPath.imagePath}app_logo.png',
                height: size.width * numD065,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onLongPress: () {
                  _showMoreOptionsBottomSheet(
                      context, size, cubitData, message);
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * numD03,
                    vertical: size.width * numD015,
                  ),
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
            ),
          ],
        ),
      ),
    );
  }

  /// show more options bottom sheet
  void _showMoreOptionsBottomSheet(
      BuildContext context, Size size, HomeCubit cubitData, String message) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width * numD07),
                topRight: Radius.circular(size.width * numD07),
              ), // Optional: for rounded border
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * numD035,
                right: size.width * numD035,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: size.height * numD04),
                  CommonText(
                    title: 'Copy url',
                    fontSize: size.width * numD04,
                  ),
                  SizedBox(height: size.height * numD015),
                  CommonText(
                    title: 'Share message',
                    fontSize: size.width * numD04,
                  ),
                  SizedBox(height: size.height * numD015),
                  InkWell(
                    onTap: () {
                      cubitData.updateAudioEnableValFunc(true);
                      cubitData.speakText(message);
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: CommonText(
                        title: 'Hear audio',
                        fontSize: size.width * numD04,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * numD03),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
