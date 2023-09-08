import 'package:cinema_ui_flutter/domain/entities/video.dart';
import 'package:cinema_ui_flutter/infrastructure/models/video/video_responsive.dart';

class VideoMapper {
  static Video videoDbToEntity(VideoDb videoDb) => Video(
        id: videoDb.id,
        name: videoDb.name,
        youtubeKey: videoDb.key,
        publishedAt: videoDb.publishedAt,
      );
}
