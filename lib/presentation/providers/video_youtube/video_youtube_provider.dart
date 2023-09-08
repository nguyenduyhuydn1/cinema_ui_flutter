import 'package:cinema_ui_flutter/domain/entities/video.dart';
import 'package:cinema_ui_flutter/presentation/providers/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videosYoutubeProvider =
    StateNotifierProvider<VideoYoutubeNotifier, List<Video>>((ref) {
  final fetchVideosYoutube =
      ref.watch(moviesRepositoryImpl).getYoutubeVideosById;

  return VideoYoutubeNotifier(fetchVideosYoutube: fetchVideosYoutube);
});

class VideoYoutubeNotifier extends StateNotifier<List<Video>> {
  final Future<List<Video>> Function(int movieId) fetchVideosYoutube;
  VideoYoutubeNotifier({required this.fetchVideosYoutube}) : super([]);

  Future<void> getVideoYoutubeByMovieId(int movieId) async {
    final videos = await fetchVideosYoutube(movieId);
    state = [...videos];
  }
}
