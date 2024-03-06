import 'package:dio/dio.dart';

import '../../core/configs/app_config.dart';
import '../../core/utils/helpers/web_client.dart';

class ImageDataProvider {
  Future<Response<dynamic>> requester(data) async {
    try {
      final response = await WebClient.postFormData(
        AppConfig.predictUrl,
        data: data,
      );

      return response;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  Future<Response<dynamic>> reset(data) async {
    try {
      final response = await WebClient.postFormData(
        AppConfig.reset,
        data: data,
      );

      return response;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }
}
