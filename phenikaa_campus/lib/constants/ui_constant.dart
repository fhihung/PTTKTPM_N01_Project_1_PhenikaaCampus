import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phenikaa_campus/constants/assets_constants.dart';
import 'package:phenikaa_campus/features/tweet/widgets/tweet_list.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.phenikaaLogo,
        height: 40,
        colorFilter:
            const ColorFilter.mode(Pallete.whiteColor, BlendMode.srcIn),
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
<<<<<<< Updated upstream
    TweetList(),
    Text("Search Screen"),
    Text("Notification Screen"),
=======
    const Text("Feed Screen"),
    const Text("Search Screen"),
    const Text("Notification Screen"),
>>>>>>> Stashed changes
  ];
}
