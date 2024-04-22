import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/configs/routes.dart';
import '../../bloc/image/image_cubit.dart';
import '../../presentation/widgets/base widgets/st_button.dart';

class CustomPopup extends StatelessWidget {
  final Map<String, dynamic> data;

  const CustomPopup({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Fastener Details',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: data["fastner_name"] == "screw"
          ? screwDetails(data)
          : data["fastner_name"] == "washer"
              ? washerDetails(data)
              : const Text("empty"),
      actions: [
        STButton(
          text: "Close",
          textColor: Colors.white,
          state: ErrorState,
          onClick: () {
            context.read<ImageCubit>().reset();
            Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
          },
        ),
      ],
    );
  }

  Widget screwDetails(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Fastener Name: ${data["fastner_name"]}'),
        const Gap(5),
        Text('Screw Length: ${data["screw_length"]}'),
        const Gap(5),
        Text('Thread Length: ${data["thread_length"]}'),
        const Gap(5),
        Text('Thread Diameter: ${data["thread_diam"]}'),
        const Gap(5),
        Text('Head Diameter: ${data["head_diam"]}'),
        const Gap(5),
        Text('Penny type: ${data["penny_type"]}'),
        const Gap(10),
        const Text(
          'Head Types:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(5),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: (data["head_type"] as List).map((head) {
        //     return Text('${head[0]}: ${head[1]}%');
        //   }).toList(),
        // ),
      ],
    );
  }

  Widget washerDetails(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Fastener Name: ${data["fastner_name"]}'),
        const Gap(5),
        Text('Type: ${data["washer_type"]}'),
        const Gap(5),
        Text('Inner: ${data["inner_diam"]}'),
        const Gap(5),
        Text('Outer: ${data["outter_diam"]}'),
        const Gap(5),
        Text('Penny type : ${data["penny_type"]}'),
        const Gap(5),
        Text('Id: ${data["fastner_id"]}'),
        const Gap(10),
      ],
    );
  }
}
