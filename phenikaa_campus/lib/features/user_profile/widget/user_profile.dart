import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:phenikaa_campus/common/common.dart';
import 'package:phenikaa_campus/common/loading_page.dart';
import 'package:phenikaa_campus/features/auth/controller/auth_controller.dart';
import 'package:phenikaa_campus/features/tweet/widgets/tweet_card.dart';
import 'package:phenikaa_campus/features/user_profile/%20controller/user_profile_controller.dart';
import 'package:phenikaa_campus/features/user_profile/widget/follow_count.dart';
import 'package:phenikaa_campus/theme/pallete.dart';
import '../ controller/color_controller.dart';
import '../../../models/user_models.dart';

class UserProfile extends ConsumerWidget {
  final UserModel user;

  UserProfile({
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    var heightStatusBar = MediaQuery.of(context).viewPadding.top;
    var size = MediaQuery.of(context).size;
    final expandedHeight = 300.0;
    final collapsedHeight = 70.0;
    double containerHeight;

    if (Platform.isAndroid) {
      containerHeight = expandedHeight - collapsedHeight - heightStatusBar;
    } else {
      containerHeight = expandedHeight - collapsedHeight;
    }
    final tweetLengthProvider = Provider<int>((ref) {
      final tweets = ref.watch(getUserTweetsProvider(user.uid));
      return tweets.maybeWhen(
        data: (tweets) => tweets.length,
        orElse: () => 0, // Default to 0 if data is not available yet
      );
    });
    ScrollController _scrollController = ScrollController();

    // Define a Provider for ColorNotifier
    final colorNotifierProvider =
        StateNotifierProvider<ColorNotifier, Color>((ref) {
      return ColorNotifier();
    });

    _scrollController.addListener(() {
      double threshold = expandedHeight - collapsedHeight - kToolbarHeight;

      if (_scrollController.offset > threshold) {
        ref
            .read(colorNotifierProvider.notifier)
            .changeColor(Palette.yellow500); // Change to your desired color
      } else {
        ref
            .read(colorNotifierProvider.notifier)
            .changeColor(Palette.rhinoDark800);
      }
    });
    return currentUser == null
        ? const Loader()
        : CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                leading: Consumer(
                  builder: (context, ref, _) {
                    final titleColor = ref.watch(colorNotifierProvider);
                    return IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: titleColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                expandedHeight: expandedHeight,
                collapsedHeight: collapsedHeight,
                floating: true,
                pinned: true,
                snap: false,
                title: Consumer(
                  builder: (context, ref, _) {
                    final titleColor = ref.watch(colorNotifierProvider);
                    return Text(
                      user.name,
                      style: TextStyle(fontSize: 20, color: titleColor),
                    );
                  },
                ),
                backgroundColor: Palette.rhinoDark700,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: size.width * 0.08),
                  // centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: user.bannerPic.isEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                  gradient: Palette.cardColor,
                                ))
                              : Image.network(
                                  user.bannerPic,
                                  fit: BoxFit.fitWidth,
                                ),
                          height: containerHeight,
                        ),
                      ),
                      Positioned(
                        bottom: collapsedHeight,
                        left: size.width * 0.08,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: ShapeDecoration(
                            color: Palette.rhinoDark600,
                            shape: CircleBorder(),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 50,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: collapsedHeight + 55,
                        left: size.width * 0.39,
                        child: Text(
                          user.name,
                          style: TextStyle(
                            color: Palette.rhinoDark600,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: collapsedHeight + 10,
                        right: size.width * 0.06,
                        child: Row(
                          children: [
                            FollowCount(
                                count: user.following.length,
                                text: 'Following'),
                            const SizedBox(width: 18),
                            FollowCount(
                                count: user.followers.length,
                                text: 'Followers'),
                          ],
                        ),
                      ),
                      Positioned(
                        // left: size.width * 0.08,
                        bottom: collapsedHeight - 60,
                        child: Row(
                          children: [
                            Gap(size.width * 0.1),
                            RoundedSmallButton(
                                text: 'Message',
                                backgroundColor: Palette.rhinoDark600,
                                onTap: () {}),
                            Gap(size.width * 0.06),
                            RoundedSmallButton(
                                text: currentUser.uid == user.uid
                                    ? 'Edit Profile'
                                    : 'Follow',
                                backgroundColor: Palette.rhinoDark600,
                                onTap: () {}),
                            SizedBox(width: 18),
                            RoundedSmallButton(
                                text: '...',
                                backgroundColor: Palette.rhinoDark600,
                                onTap: () {})
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              for (int i = 0; i < 10; i++)
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    color: i % 2 == 0
                        ? Palette.rhinoDark700
                        : Palette.rhinoDark700,
                  ),
                )
            ],
          );
  }
}
