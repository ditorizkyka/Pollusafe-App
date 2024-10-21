import 'package:flutter/material.dart';
import 'package:pollusafe_app/src/constant/constant.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: ColorApp.divider,
      height: 1,
    );
  }
}
