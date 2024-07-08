
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


import '../models/notification_response_model.dart';
import '../network/end_points.dart';
import '../network/rest_api_client.dart';



abstract class NotificationDataSource {

  Future<NotificationData> getNotifications(
      {required int userId, });

}

class NotificationDataSourceImpl extends NotificationDataSource {
  NotificationDataSourceImpl() : _restClient = GetIt.instance<ApiService>();

  final ApiService _restClient;



  @override
  Future<NotificationData> getNotifications({required int userId,}) async{
    final result =
    await _restClient.get(Endpoints.notification + '?userId=$userId', queryParameters: {

    });

    debugPrint('This is the result $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = NotificationResponseModel.fromJson(result.data);
    debugPrint('This is the response ${response}');
    return response.data;
  }


}
