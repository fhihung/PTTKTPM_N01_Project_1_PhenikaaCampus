// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/theme.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String hintText;
  final Color fillColor;
  final SvgPicture prefixIcon;

  const TextFormFieldCustom({
    Key? key,
    required this.hintText,
    required this.fillColor,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 16, 16, 20),
          prefixIcon: prefixIcon,
          hintText: hintText,
          fillColor: fillColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: fillColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: fillColor,
            ),
          ),
        ),
      ),
    );
  }
}
