// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'dart:io';
import 'dart:convert';
import 'package:fastner_detector/presentation/screens/screw_select_screen.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/configs/routes.dart';
import '../widgets/popup_widget.dart';
import '../../bloc/image/image_cubit.dart';
import '../widgets/base widgets/st_button.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    Key? key,
    required this.b64,
  }) : super(key: key);

  final List<String> b64;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageFileList = [];
  List<String> base64Images = [];

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

  poppu(data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomPopup(data: data);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<ImageCubit, ImageState>(
            listener: (context, state) {
              if (state is SecondImageSuccess) {
                state.data['fastner_name'] == "washer"
                    ? poppu(state.data)
                    :
                    // state.data != null ? poppu(state.data) : null;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScrewSelectScreen(
                            headTypes: state.data['head_types']
                                .map((item) => item[0])
                                .toList(),
                            threadTypes: state.data["thread_types"],
                            meterials: state.data["meterials"],
                            screwLength: state.data["screw_length"],
                            threadLength: state.data["thread_length"],
                            threadDiam: state.data["thread_diam"],
                          ),
                        ),
                      );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const Gap(10),
                  alertWidget(),
                  pickedImagewidgetFromMainScreen(),
                  _imageFileList.isEmpty
                      ? imagePickerWidget()
                      : pickedImagewidget(),
                  normalButtonWidget(),
                  const Gap(10),
                  resetButtonWidget(),
                  const Gap(10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Note : Please be patient while loading. It may take some time to detect accurately.",
                      style: TextStyle(
                          color: Color(0xFF313131), fontSize: 15, height: 1.7),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget alertWidget() {
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        if (state is SecondImageInitial) {
          return state.widget;
        } else if (state is EmptyImage) {
          return state.widget;
        } else if (state is InvalidImage) {
          return state.widget;
        } else if (state is ErrorState) {
          return state.widget;
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.yellow.shade100),
          child: const Text(
            "Loading...",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black38,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
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

  Widget pickedImagewidgetFromMainScreen() {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.memory(
          fit: BoxFit.cover,
          base64Decode(
            widget.b64.last,
          ),
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
              // context.read<ImageCubit>().requester(_imageFileList.first.path);
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
      backgroundColor: Colors.transparent,
      onClick: () {
        setState(() {
          base64Images.clear();
          _imageFileList.clear();
        });
        context.read<ImageCubit>().reset();

        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      },
    );
  }
}
