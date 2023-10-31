import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phenikaa_campus/constants/constants.dart';
import 'package:phenikaa_campus/features/explore/widget/text_form_field_custom.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

class NewPostsList extends ConsumerStatefulWidget {
  const NewPostsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewPostsListState();
}

class _NewPostsListState extends ConsumerState<NewPostsList> {
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
              top: 10,
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
            Positioned(
              top: 130,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: Pallete.rhinoDark700,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.12),
                  child: TextFormFieldCustom(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: SearchController(),
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
                    hintText: "How are you today?",
                    fillColor: Pallete.textformfieldColor,
                  ),
                ),
              ],
            ),

            // Quang is coding
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      "How are you today?",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                ListView()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
