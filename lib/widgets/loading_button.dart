import 'package:flutter/material.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_fonts.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.primary,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Container(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(AppColor.primaryTextColor),
              )),
        ),
      ),
    );
  }
}
