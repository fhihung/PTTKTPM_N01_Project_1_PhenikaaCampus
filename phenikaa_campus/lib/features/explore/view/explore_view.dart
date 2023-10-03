import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phenikaa_campus/constants/constants.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

import '../../../constants/text.dart';
import '../widget/text_form_field_custom.dart';

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // Layer 1: Background Image
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(AssetsConstants.darkBlur),
            ),
            Positioned(
              top: 130.0,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                width: size.width,
                height: 120,
                decoration: BoxDecoration(
                  gradient: Pallete.cardColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            // Layer 2: Column with TextFormFieldCustom
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 100),
                  child: TextFormFieldCustom(
                    prefixIcon: SvgPicture.asset(
                      AssetsConstants.searchIcon,
                      height: 5,
                      width: 5,
                      fit: BoxFit.scaleDown,
                      colorFilter: const ColorFilter.mode(
                        Pallete.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    hintText: search,
                    fillColor: Pallete.textformfieldColor,
                  ),
                ),

                // Layer 3: Container with Background Color
              ],
            ),
            Positioned(
              top: 210.0,
              child: Container(
                width: size.width,
                height: size.height - 200.0,
                decoration: BoxDecoration(
                  color: Pallete.backgroundColor,
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
