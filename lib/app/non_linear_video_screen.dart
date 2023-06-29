import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_linear_video/app/bloc/video_load_bloc.dart';
import 'package:non_linear_video/app/widgets/analysing_indicator.dart';
import 'package:non_linear_video/app/widgets/emotions_dialog.dart';
import 'package:non_linear_video/app/widgets/error_message_widget.dart';
import 'package:non_linear_video/utils/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class NonLinearVideoScreen extends StatelessWidget {
  const NonLinearVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoLoadBloc>(
        create: (context) => VideoLoadBloc(),
        child: const NonLinearVideoWidget());
  }
}

class NonLinearVideoWidget extends StatefulWidget {
  const NonLinearVideoWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NonLinearVideoWidgetState();
  }
}

class _NonLinearVideoWidgetState extends State<NonLinearVideoWidget> {
  // Video player is required as it is the backbone behind chewie.
  late VideoPlayerController _videoPlayerController;

  // Chewie is used to play the video along with the playback capabilities.
  ChewieController? _chewieController;

  // _emotionalSelected defines the emotion selected on the current session. Default emotion
  // means playing the initial video of explaining the human emotions.
  String _emotionSelected = 'Default';
  bool analyzing = false;

  @override
  void initState() {
    super.initState();
    initializePlayer(Constants.emotionsVideo[_emotionSelected]);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
  
  // Initializes the videoUrl to be played on the screen and also creates
  // a Chewie Controller that will be required to render the video on the screen.
  // Also updates the State of the screen depending upon if video gets successfully rendered
  // by the chewie or an error gets occured.
  Future<void> initializePlayer(String videoUrl) async {
    try {
      _videoPlayerController = VideoPlayerController.network(videoUrl);
      await _videoPlayerController.initialize();

      _createChewieController();
      setState(() {});
      // ignore: use_build_context_synchronously
      BlocProvider.of<VideoLoadBloc>(context).add(VideoLoadedEvent());
    } on Exception catch (e) {
      BlocProvider.of<VideoLoadBloc>(context).add(const VideoLoadFailedEvent(
          errorMessage: 'Some error occured.\n Try again.'));
    }
  }

  // This function creates the Chewie Controller defining all the capabilities
  // that the video is going to have.
  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      allowFullScreen: false,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: selectEmotion,
            iconData: Icons.emoji_emotions_outlined,
            title: 'Select Emotion',
          ),
          OptionItem(
            onTap: () {
              Navigator.pop(context);
              reload(Constants.pleaseWait, 'Default');
            },
            iconData: Icons.refresh_outlined,
            title: 'Reset',
          ),
        ];
      },
      hideControlsTimer: const Duration(seconds: 1),
    );
  }

  int currPlayIndex = 0;

  // Opens up a dialog with all the emotions that a user can choose from
  // and based on the emotion selected, it will tailor out a new video for the user.
  Future<void> selectEmotion() async {
    await showDialog(
      context: context,
      builder: (ctx) => EmotionsDialog(
        selectedEmotion: _emotionSelected,
        onTap: (emotion) async {
          await reload(Constants.analzingEmotions, emotion);
        },
      ),
    ).then((value) {
      Navigator.pop(context);
    });
  }

  // Helps in reloading the video based on the emotion selected
  Future<void> reload(String loadingMessage, String emotion) async {
    _emotionSelected = emotion;
    BlocProvider.of<VideoLoadBloc>(context)
        .add(VideoLoadingEvent(loadingMessage: loadingMessage));
    await _videoPlayerController.pause();
    await initializePlayer(Constants.emotionsVideo[emotion]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: BlocBuilder<VideoLoadBloc, VideoLoadState>(
              builder: (context, state) {
            if (state is VideoLoadingState) {
              return AnalysingIndicator(loadingMessage: state.loadingMessage);
            } else if (state is VideoLoadFailedState) {
              return ErrorMessageWidget(
                error: state.error ?? 'Some Error Occured!',
                onRetry: () async {
                  await reload('Please wait', _emotionSelected);
                },
              );
            }
            return _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(
                    controller: _chewieController!,
                  )
                : const AnalysingIndicator(
                    loadingMessage: Constants.pleaseWait);
          }),
        ),
      ),
    );
  }
}
