import 'package:flutter_bloc/flutter_bloc.dart';

part 'video_load_event.dart';
part 'video_load_state.dart';

class VideoLoadBloc extends Bloc<VideoLoadEvent, VideoLoadState> {
  VideoLoadBloc() : super(VideoLoadInitState()) {
    on<VideoLoadingEvent>(_onVideoLoadingEvent);
    on<VideoLoadedEvent>(_onVideoLoadedEvent);
    on<VideoLoadFailedEvent>(_onVideoLoadFailedEvent);
  }

  void _onVideoLoadingEvent(
      VideoLoadingEvent event, Emitter<VideoLoadState> emit) async {
    emit(VideoLoadingState(loadingMessage: event.loadingMessage));
  }

  // VideoLoadedState gets triggered if video gets successfully rendered by the chewie.
  void _onVideoLoadedEvent(
      VideoLoadedEvent event, Emitter<VideoLoadState> emit) async {
    emit(const VideoLoadedState());
  }

  // VideoLoadFailedState gets triggered if doesn't get rendered due to some reason.
  // On the UI front, it gives the option to retry playing the video again.
  void _onVideoLoadFailedEvent(
      VideoLoadFailedEvent event, Emitter<VideoLoadState> emit) async {
    emit(VideoLoadFailedState(error: event.errorMessage));
  }
}
