// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/image_repsitory.dart';
import '../../core/utils/helpers/app_preferences.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit(this.imageRepository) : super(ImageInitial());

  final ImageRepository imageRepository;

  Future<void> requester(List<String> imageB64) async {
    if (imageB64.isEmpty) {
      return;
    }

    emit(LoadingState());
    var id = Random().nextInt(100);
    var existId = AppPreferences.getInt("id");
    if (existId == null) {
      AppPreferences.setInt("id", id);
    }
    FormData formData = FormData.fromMap({
      'request_id': AppPreferences.getInt("id"),
      'image': [imageB64[0]],
    });
    try {
      final response = await imageRepository.requester(formData);
      final responseStatusCode = response.statusCode;
      var data = response.data;
      print(response);
      if (responseStatusCode == 200 && data["status"] == "step1") {
        emit(SecondImageInitial(data["fastner_name"]));
        return;
      } else if (responseStatusCode == 200 && data["status"] == "step2") {
        emit(SecondImageSuccess(data));
        return;
      } else if (responseStatusCode == 200 && data["status"] == "empty") {
        emit(ResponseStatusEmpty(data["fastner_name"]));

        return;
      } else if (responseStatusCode == 200 && data["status"] == "empty") {
        emit(ResponseStatusEmpty(data["fastner_name"]));

        return;
      } else {
        emit(ErrorState());
        await Future.delayed(const Duration(seconds: 1));
        AppPreferences.clear();
        emit(ImageInitial());
      }
    } catch (e) {
      emit(ErrorState());
    }
  }

  reset() async {
    var existId = AppPreferences.getInt("id");

    FormData formData = FormData.fromMap({
      'request_id': existId,
    });

    await imageRepository.reset(formData);
    emit(ImageInitial());
  }
}
