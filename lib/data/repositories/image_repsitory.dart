import '../../data/providers/image_provider.dart';

class ImageRepository {
  final ImageDataProvider imageProvider;

  ImageRepository(this.imageProvider);
  Future<dynamic> requester(formData) async {
    try {
      final response = await imageProvider.requester(formData);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw "Something went wrong, please try again";
      }
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  Future<dynamic> reset(formData) async {
    try {
      final response = await imageProvider.reset(formData);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw "Something went wrong, please try again";
      }
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }
}
