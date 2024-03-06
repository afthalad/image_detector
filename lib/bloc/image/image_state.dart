// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

part of 'image_cubit.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {
  final Widget widget = Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.yellow.shade100),
    child: const Text(
      "Kindly, Please upload an image to be used for the detection process",
      style: TextStyle(
        fontSize: 15,
        color: Colors.black38,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

final class LoadingState extends ImageState {}

final class ResponseStatusEmpty extends ImageState {
  final String firstImageFasterName;

  ResponseStatusEmpty(this.firstImageFasterName);
}

final class EmptyImage extends ImageState {
  final Widget widget = Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.red.shade100,
    ),
    child: const Text(
      "Please add some images to process of the detection",
      style: TextStyle(
        fontSize: 15,
        color: Colors.black38,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

final class ErrorState extends ImageState {
  final Widget widget = Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.red.shade100,
    ),
    child: const Text(
      "Something went wrong with our end, Please try again",
      style: TextStyle(
        fontSize: 15,
        color: Colors.black38,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

final class FirstImageInitial extends ImageState {}

final class FirstImageSuccess extends ImageState {}

final class SecondImageInitial extends ImageState {
  final String firstImageFasterName;
  final Widget widget;

  SecondImageInitial(this.firstImageFasterName)
      : widget = Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.yellow.shade100),
          child: Text(
            firstImageFasterName == "screw"
                ? "Please capture the head part of the screw for accurate detection."
                : firstImageFasterName == "washer"
                    ? "Please capture the opposite side of washer for accurate detection."
                    : "",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black38,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
}

final class SecondImageSuccess extends ImageState {
  var data;

  SecondImageSuccess(this.data);
}

final class InvalidImage extends ImageState {
  final Widget widget = Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.red.shade100,
    ),
    child: const Text(
      "Invalid image please upload correct images to detect press reset then upload",
      style: TextStyle(
        fontSize: 15,
        color: Colors.black38,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
