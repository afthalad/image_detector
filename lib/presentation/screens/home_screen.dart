import 'dart:io';
import 'dart:convert';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/image/image_cubit.dart';
import '../widgets/base widgets/st_button.dart';
import '../../presentation/screens/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageFileList = [];
  List<String> base64Images = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      base64Images.clear();
      _imageFileList.clear();
    });
  }

  Future<void> pickImage(isCamera) async {
    if (_imageFileList.isNotEmpty || base64Images.isNotEmpty) {
      _imageFileList.clear();
      base64Images.clear();
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
      );
      if (image == null) return;

      File imageFile = File(image.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String imgBase64 = base64Encode(imageBytes);

      setState(() {
        _imageFileList.add(image);
        base64Images.add(imgBase64);
      });
    } catch (e) {
      kDebugMode;
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                onTap: () {
                  pickImage(true);
                  Navigator.of(context).pop();
                },
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  pickImage(false);
                  Navigator.of(context).pop();
                },
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<ImageCubit, ImageState>(
          listener: (context, state) {
            if (state is SecondImageInitial) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(
                    b64: base64Images,
                  ),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerTextsWidget(),
                const Gap(15),
                firstImageDetectedObjectNameWidget(),
                alertWidget(),
                bodyContentWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyContentWidget() {
    return Column(
      children: [
        _imageFileList.isEmpty ? imagePickerWidget() : pickedImagewidget(),
        normalButtonWidget(),
        const Gap(10),
        resetButtonWidget(),
        const Gap(10),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Note : Please be patient while loading. It may take some time to detect accurately.",
            style:
                TextStyle(color: Color(0xFF313131), fontSize: 15, height: 1.7),
          ),
        )
      ],
    );
  }

  Widget alertWidget() {
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        if (state is ErrorState) {
          return state.widget;
        } else if (state is EmptyImage) {
          return state.widget;
        } else if (state is InvalidImage) {
          return state.widget;
        }
        return uploadImageAlertWidget();
      },
    );
  }

  Widget firstImageDetectedObjectNameWidget() {
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        if (state is ResponseStatusEmpty) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Detedcted object is : ${state.firstImageFasterName}",
              style: const TextStyle(
                color: Color(0xFF313131),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // height: 1.7,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget headerTextsWidget() {
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        if (state is ImageInitial ||
            state is LoadingState ||
            state is ErrorState ||
            state is EmptyImage ||
            state is ResponseStatusEmpty ||
            state is InvalidImage) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Welcome! AI-Powered Vision at Your Fingertips",
                  style: GoogleFonts.caprasimo(fontSize: 30),
                ),
              ),
              const Gap(5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Upload your initial image. Once processed, submit a second image of the same item to retrieve detailed information.",
                  style: TextStyle(
                      color: Color(0xFF313131), fontSize: 15, height: 1.7),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget pickedImagewidget() {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.memory(
          fit: BoxFit.cover,
          base64Decode(
            base64Images[0],
          ),
        ),
      ),
    );
  }

  Widget uploadImageAlertWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.yellow.shade100),
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

  Widget imagePickerWidget() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _showBottomSheet();
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(width: 1.2, color: Colors.black12),
              ),
              child: imagePickerTitleSubtitle(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget imagePickerTitleSubtitle(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_a_photo,
          color: Colors.black12,
          size: 40,
        ),
        Gap(10),
        Align(
          alignment: Alignment.center,
          child: Text(
            textAlign: TextAlign.center,
            "Please insert your image for \nthe detection process ",
            style: TextStyle(
              color: Colors.black26,
            ),
          ),
        ),
      ],
    );
  }

  Widget normalButtonWidget() {
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        return STButton(
          text: "Detect image",
          isBold: true,
          fontSize: 15,
          backgroundColor: Colors.black,
          state: state,
          onClick: () {
            if (_imageFileList.isNotEmpty) {
              context.read<ImageCubit>().requester(base64Images);
            }
          },
        );
      },
    );
  }

  Widget resetButtonWidget() {
    return STButton(
      text: "Reset",
      textColor: Colors.black,
      isBold: true,
      fontSize: 15,
      borderColor: Colors.black,
      state: ErrorState,
      backgroundColor: Colors.white,
      onClick: () {
        setState(() {
          base64Images.clear();
          _imageFileList.clear();
        });

        context.read<ImageCubit>().reset();
      },
    );
  }
}
