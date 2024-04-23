import 'dart:io';

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/configs/routes.dart';
import '../../bloc/image/image_cubit.dart';
import '../../presentation/widgets/base widgets/st_button.dart';

class ScrewSelectScreen extends StatefulWidget {
  ScrewSelectScreen({
    super.key,
    required this.headTypes,
    required this.threadTypes,
    required this.meterials,
    required this.screwLength,
    required this.threadLength,
    required this.threadDiam,
  });

  List<dynamic> headTypes;

  List<dynamic> threadTypes;
  List<dynamic> meterials;
  double screwLength;
  double threadLength;
  double threadDiam;

  @override
  State<ScrewSelectScreen> createState() => _ScrewSelectScreenState();
}

class _ScrewSelectScreenState extends State<ScrewSelectScreen> {
  String headType = "";
  String threadType = "";
  String material = "";
  int select = 1;
  bool recommandSelected = false;
  showCustomSnackBar() {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: Colors.red.shade600,
      content: const Text(
        'Please select all the required types',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // HEADE SECTION WIDGET
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Head type",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            "Select your head type type (${widget.threadTypes.length})"),
                      ],
                    ),
                    const Gap(10),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.headTypes.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                headType = widget.headTypes[index];
                                recommandSelected = index == 0 ? true : false;
                              });
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: index == 0 && !recommandSelected
                                          ? Colors.green.shade500
                                          : (headType == widget.headTypes[index]
                                              ? Colors.black
                                              : Colors.black12),
                                      width: 2,
                                    ),
                                  ),
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(10),
                                  width: 90,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                          "https://www.olander.com/images/categories/BOLTS.webp"),
                                      Center(
                                        child: Text(
                                          widget.headTypes[index],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (index == 0 && !recommandSelected)
                                  const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                // THREAD SECTION WIDGET
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Thread type",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            "Select your thread type type (${widget.threadTypes.length})"),
                      ],
                    ),
                    const Gap(10),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.threadTypes.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                threadType = widget.threadTypes[index];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: threadType == widget.threadTypes[index]
                                      ? Colors.black
                                      : Colors.black12,
                                  width: 2,
                                ),
                              ),
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(10),
                              width: 90,
                              height: 120,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                      "https://www.olander.com/images/categories/BOLTS.webp"),
                                  Center(
                                    child: Text(
                                      widget.threadTypes[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                // THREAD SECTION WIDGET
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Materials type",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            "Select your material type type (${widget.meterials.length})"),
                      ],
                    ),
                    const Gap(10),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.meterials.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                material = widget.meterials[index];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: material == widget.meterials[index]
                                      ? Colors.black
                                      : Colors.black12,
                                  width: 2,
                                ),
                              ),
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(10),
                              width: 90,
                              height: 120,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                      "https://www.olander.com/images/categories/BOLTS.webp"),
                                  Center(
                                    child: Text(
                                      widget.meterials[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                BlocBuilder<ImageCubit, ImageState>(
                  builder: (context, state) {
                    return STButton(
                      text: "Continue",
                      isBold: true,
                      fontSize: 15,
                      backgroundColor: Colors.black,
                      state: state,
                      onClick: () {
                        if (headType == "" ||
                            threadType == "" ||
                            material == "") {
                          showCustomSnackBar();
                        } else {
                          context
                              .read<ImageCubit>()
                              .step3Requester(
                                headType,
                                threadType,
                                material,
                                widget.screwLength,
                                widget.threadLength,
                                widget.threadDiam,
                              )
                              .whenComplete(
                            () {
                              sleep(const Duration(seconds: 1));
                              context.read<ImageCubit>().reset();
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.homeScreen);
                            },
                          );
                        }
                      },
                    );
                  },
                ),

                const Gap(15),
                resetButtonWidget(),
              ],
            ),
            // child: BlocBuilder<ImageCubit, ImageState>(
            //   builder: (context, state) {
            //     if (state is SecondImageSuccess) {
            //       var stateData = state.data;
            //       var headTypes =
            //           state.data['head_types'].map((item) => item[0]).toList();
            //       var threadTypes = state.data['thread_types'];
            //       var materials = state.data['meterials'];
            //       return Column(
            //         mainAxisSize: MainAxisSize.max,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           // HEADE SECTION WIDGET
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "Head type",
            //                     style: TextStyle(
            //                       color: Colors.black87,
            //                       fontSize: 22,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Text("Select your head type type"),
            //                 ],
            //               ),
            //               const Gap(10),
            //               SizedBox(
            //                 height: 140,
            //                 child: ListView.builder(
            //                   shrinkWrap: true,
            //                   scrollDirection: Axis.horizontal,
            //                   itemCount: headTypes.length,
            //                   itemBuilder: (context, index) {
            //                     return InkWell(
            //                       onTap: () {
            //                         setState(() {
            //                           headType = headTypes[index];
            //                         });
            //                       },
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           border: Border.all(
            //                             color: headType == headTypes[index]
            //                                 ? Colors.black
            //                                 : Colors.black12,
            //                             width: 2,
            //                           ),
            //                         ),
            //                         margin: const EdgeInsets.all(5),
            //                         padding: const EdgeInsets.all(10),
            //                         width: 90,
            //                         height: 120,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Image.network(
            //                                 "https://www.olander.com/images/categories/BOLTS.webp"),
            //                             Center(
            //                               child: Text(
            //                                 headTypes[index],
            //                                 textAlign: TextAlign.center,
            //                                 style: const TextStyle(fontSize: 12),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ],
            //           ),
            //           const Gap(20),
            //           // THREAD SECTION WIDGET
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "Thread type",
            //                     style: TextStyle(
            //                       color: Colors.black87,
            //                       fontSize: 22,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Text("Select your thread type type"),
            //                 ],
            //               ),
            //               const Gap(10),
            //               SizedBox(
            //                 height: 140,
            //                 child: ListView.builder(
            //                   shrinkWrap: true,
            //                   scrollDirection: Axis.horizontal,
            //                   itemCount: headTypes.length,
            //                   itemBuilder: (context, index) {
            //                     return InkWell(
            //                       onTap: () {
            //                         setState(() {
            //                           threadType = threadTypes[index];
            //                         });
            //                       },
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           border: Border.all(
            //                             color: threadType == threadTypes[index]
            //                                 ? Colors.black
            //                                 : Colors.black12,
            //                             width: 2,
            //                           ),
            //                         ),
            //                         margin: const EdgeInsets.all(5),
            //                         padding: const EdgeInsets.all(10),
            //                         width: 90,
            //                         height: 120,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Image.network(
            //                                 "https://www.olander.com/images/categories/BOLTS.webp"),
            //                             Center(
            //                               child: Text(
            //                                 threadTypes[index],
            //                                 textAlign: TextAlign.center,
            //                                 style: const TextStyle(fontSize: 12),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ],
            //           ),
            //           const Gap(20),
            //           // THREAD SECTION WIDGET
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "Materials type",
            //                     style: TextStyle(
            //                       color: Colors.black87,
            //                       fontSize: 22,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Text("Select your material type type"),
            //                 ],
            //               ),
            //               const Gap(10),
            //               SizedBox(
            //                 height: 140,
            //                 child: ListView.builder(
            //                   shrinkWrap: true,
            //                   scrollDirection: Axis.horizontal,
            //                   itemCount: materials.length,
            //                   itemBuilder: (context, index) {
            //                     return InkWell(
            //                       onTap: () {
            //                         setState(() {
            //                           material = materials[index];
            //                         });
            //                       },
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           border: Border.all(
            //                             color: material == materials[index]
            //                                 ? Colors.black
            //                                 : Colors.black12,
            //                             width: 2,
            //                           ),
            //                         ),
            //                         margin: const EdgeInsets.all(5),
            //                         padding: const EdgeInsets.all(10),
            //                         width: 90,
            //                         height: 120,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Image.network(
            //                                 "https://www.olander.com/images/categories/BOLTS.webp"),
            //                             Center(
            //                               child: Text(
            //                                 materials[index],
            //                                 textAlign: TextAlign.center,
            //                                 style: const TextStyle(fontSize: 12),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ],
            //           ),
            //           const Gap(20),
            //           BlocBuilder<ImageCubit, ImageState>(
            //             builder: (context, state) {
            //               return STButton(
            //                 text: "Detect image",
            //                 isBold: true,
            //                 fontSize: 15,
            //                 backgroundColor: Colors.black,
            //                 state: state,
            //                 onClick: () {
            //                   context
            //                       .read<ImageCubit>()
            //                       .step3Requester(
            //                         headType,
            //                         threadType,
            //                         material,
            //                         stateData['screw_length'],
            //                         stateData['thread_length'],
            //                         stateData['thread_diam'],
            //                       )
            //                       .whenComplete(
            //                     () {
            //                       context.read<ImageCubit>().reset();
            //                       Navigator.pushReplacementNamed(
            //                           context, AppRoutes.homeScreen);
            //                     },
            //                   );
            //                 },
            //               );
            //             },
            //           ),

            //           const Gap(15),
            //           resetButtonWidget(),
            //         ],
            //       );
            //     }

            //     return const Column(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           SpinKitCircle(
            //             size: 64,
            //             color: Colors.black87,
            //           ),
            //         ]);
            //   },
            // ),
          ),
        ),
      ),
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
        context.read<ImageCubit>().reset();

        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      },
    );
  }
}
