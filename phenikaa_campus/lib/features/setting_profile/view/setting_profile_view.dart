import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/common/loading_page.dart';
import 'package:phenikaa_campus/constants/assets_constants.dart';
import 'package:phenikaa_campus/features/auth/controller/auth_controller.dart';
import 'package:phenikaa_campus/features/setting_profile/widget/setting_profile.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

import '../../../models/user_models.dart';

class SettingProfileView extends ConsumerStatefulWidget {
  const SettingProfileView({Key? key});

  @override
  ConsumerState<SettingProfileView> createState() => _SettingProfileViewState();
}

class _SettingProfileViewState extends ConsumerState<SettingProfileView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final posi1 = 100.0;
    final posi2 = 200.0;
    if (currentUser == null) {
      return Loader(); // Display loading indicator or handle error
    }
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(AssetsConstants.darkBlur),
            ),
            Positioned(
              top: posi1,
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
              top: posi2,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: Pallete.rhinoDark700,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            Positioned(
              top: posi2 - 40,
              left: (size.width - 165) / 2,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: ShapeDecoration(
                  color: Pallete.rhinoDark800,
                  shape: CircleBorder(),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(currentUser.profilePic),
                  radius: 80,
                ),
              ),
            ),
            Positioned(
              top: posi2 + 60,
              left: (size.width) / 2 +
                  30, // Adjust the left position to center the button
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: ShapeDecoration(
                  color: Pallete.rhinoDark800,
                  shape: CircleBorder(),
                ),
                child: CircleAvatar(
                  backgroundColor: Pallete.yellow800,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt,
                      color: Pallete.rhinoDark800,
                    ),
                  ),
                  radius: 25,
                ),
              ),
            ),
            Positioned.fill(
              top: posi2 + posi1 + 60,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Text(
                    ' ${currentUser.name}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
            ),
          ],
          // child: Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("User Name: ${currentUser.name}"),
          //       Text("Email: ${currentUser.email}"),
          //       // Add more user profile information as needed
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
