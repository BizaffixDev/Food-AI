import 'package:foodai_mobile/data/data_sources/home_data_source.dart';
import 'package:foodai_mobile/data/models/like_dislike_respponse_model.dart';
import 'package:foodai_mobile/data/models/preferences_response_model.dart';

abstract class HomeRepository {

  Future<List<PreferencesData>> getPreferencesData();

  Future<LikeDislikeResponseModel> likeDislikeResponse({
    required int userId,
    required int questionId,
    required bool userResponse,
  });

}


class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl(this.homeDataSource,);

  @override
  Future<List<PreferencesData>> getPreferencesData() {
    return homeDataSource.getPreferencesData();
  }

  @override
  Future<LikeDislikeResponseModel> likeDislikeResponse({required int userId, required int questionId, required bool userResponse}) {
    return homeDataSource.likeDislikeResponse(userId: userId, questionId: questionId, userResponse: userResponse);
  }
}