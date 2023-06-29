part of 'video_load_bloc.dart';

abstract class VideoLoadEvent {
  const VideoLoadEvent();
}

class VideoLoadingEvent extends VideoLoadEvent {
  final String loadingMessage;
  const VideoLoadingEvent({required this.loadingMessage});
}

class VideoLoadedEvent extends VideoLoadEvent {}

class VideoLoadFailedEvent extends VideoLoadEvent {
  final String errorMessage;
  const VideoLoadFailedEvent({required this.errorMessage});
}
