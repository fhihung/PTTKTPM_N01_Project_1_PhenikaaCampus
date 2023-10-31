import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/constants/constants.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

class NewThemeList extends ConsumerStatefulWidget {
  const NewThemeList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewThemeListState();
}

class _NewThemeListState extends ConsumerState<NewThemeList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // Layer 1: Background Image
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(AssetsConstants.darkBlur),
            ),
            Positioned(
              top: 130.0,
              child: Container(
                margin: EdgeInsets.symmetric(
                    // horizontal: 10.0,
                    ),
                width: size.width,
                height: size.height * 0.8,
                decoration: BoxDecoration(
                  gradient: Pallete.cardColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            Positioned.fill(
                top: size.height * 0.068,
                child: const Align(
                    alignment: Alignment.topCenter, child: Text('Search'))),
            // Layer 2: Column with TextFormFieldCustom
            ListView(),
            Positioned(
              top: 235.0,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: Pallete.rhinoDark700,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
