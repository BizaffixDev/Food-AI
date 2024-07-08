import 'package:foodai_mobile/data/data_sources/discover_data_source.dart';
import 'package:foodai_mobile/data/models/cuisine_preferences_response_model.dart';
import 'package:foodai_mobile/data/models/cusines_response_model.dart';
import 'package:foodai_mobile/data/models/like_dislike_respponse_model.dart';

abstract class DiscoverRepository {

  Future<List<CuisinesData>> getCuisinesList();

  Future<List<Preference>> getCuisinesPreferenceList({required String cuisineId});

  Future<LikeDislikeResponseModel> likeDislikeResponse({
    required int userId,
    required int questionId,
    required bool userResponse,
  });


}

class DiscoverRepositoryImpl extends DiscoverRepository {
  final DiscoverDataSource discoverDataSource;

  DiscoverRepositoryImpl(this.discoverDataSource);

  @override
  Future<List<CuisinesData>> getCuisinesList() {
    return discoverDataSource.getCuisinesList();
  }

  @override
  Future<List<Preference>> getCuisinesPreferenceList({required String cuisineId}) {
    return discoverDataSource.getCuisinesPreferenceList(cuisineId: cuisineId);
  }

  @override
  Future<LikeDislikeResponseModel> likeDislikeResponse({required int userId, required int questionId, required bool userResponse}) {
    return discoverDataSource.likeDislikeResponse(userId: userId, questionId: questionId, userResponse: userResponse);
  }


}
