// ignore_for_file: prefer_typing_uninitialized_variables, avoid_init_to_null, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../bloc/image/image_cubit.dart';

class STButton extends StatefulWidget {
  final String text;
  final void Function()? onClick;
  final Color? borderColor;
  final double? width;
  final double? height;
  final Color? textColor;

  final double? fontSize;
  final IconData? icon;
  final Color? backgroundColor;
  final bool showLoading;
  final bool isBold;
  final bool isTextButton;
  final bool isEnable;
  final double horizontalMargin;
  var state;

  STButton({
    required this.text,
    this.onClick = null,
    this.borderColor,
    this.width = double.infinity,
    this.height = 56,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.icon,
    this.backgroundColor = Colors.black,
    this.showLoading = false,
    this.isBold = false,
    this.isTextButton = false,
    this.isEnable = false,
    this.horizontalMargin = 0,
    this.state,
    super.key,
  });

  @override
  State<STButton> createState() => _STButtonState();
}

class _STButtonState extends State<STButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.icon == null ? widget.height : 64,
      child: widget.icon == null
          ? normalButton()
          : widget.isTextButton
              ? textButton()
              : normalButton(),
    );
  }

  Widget normalButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: widget.onClick,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(17, 10, 17, 10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: widget.borderColor != null
                ? BorderSide(
                    color: widget.borderColor!,
                    width: .5,
                  )
                : const BorderSide(
                    color: Colors.transparent,
                  ),
          ),
          backgroundColor: widget.backgroundColor,
        ),
        child: widget.state is LoadingState?
            ? const SpinKitThreeBounce(
                color: Colors.white,
                size: 20.0,
              )
            : Text(
                widget.text,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                      fontWeight:
                          widget.isBold ? FontWeight.bold : FontWeight.normal,
                    ),
              ),
      ),
    );
  }

  Widget textButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: widget.onClick,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: const Color(0xFF313131),
              ),
        ),
      ),
    );
  }
}
