part of 'video_load_bloc.dart';

abstract class VideoLoadState {
  const VideoLoadState();
}

class VideoLoadInitState extends VideoLoadState {}

class VideoLoadedState extends VideoLoadState {
  const VideoLoadedState();
}

// The Loading state to store the loading message while video is in process of rendering on the screen.
class VideoLoadingState extends VideoLoadState {
  final String loadingMessage;
  const VideoLoadingState({required this.loadingMessage});
}

// The Failed state to store the error message if video fails to render on the screen.
class VideoLoadFailedState extends VideoLoadState {
  final String? error;
  const VideoLoadFailedState({this.error});
}
