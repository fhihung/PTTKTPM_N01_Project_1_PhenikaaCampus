import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/common/loading_page.dart';
import 'package:phenikaa_campus/features/auth/controller/auth_controller.dart';
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
    final collapsedHeight = 60.0;
    double containerHeight;

    if (Platform.isAndroid) {
      containerHeight = expandedHeight - collapsedHeight - heightStatusBar;
    } else {
      containerHeight = expandedHeight - collapsedHeight;
    }

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
            .changeColor(Pallete.yellow500); // Change to your desired color
      } else {
        ref
            .read(colorNotifierProvider.notifier)
            .changeColor(Pallete.rhinoDark800);
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
                snap: true,
                title: Consumer(
                  builder: (context, ref, _) {
                    final titleColor = ref.watch(colorNotifierProvider);
                    return Text(
                      user.name,
                      style: TextStyle(fontSize: 20, color: titleColor),
                    );
                  },
                ),
                backgroundColor: Pallete.rhinoDark700,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: size.width * 0.08),
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,
                  background: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: user.bannerPic.isEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                  gradient: Pallete.cardColor,
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
                            color: Pallete.rhinoDark600,
                            shape: CircleBorder(),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 50,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: collapsedHeight - 40,
                        left: size.width * 0.08,
                        child: Text(
                          user.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Positioned(
                        bottom: collapsedHeight + 50,
                        left: size.width * 0.77,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Pallete.rhinoDark600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: Text('Follow'),
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
                        ? Pallete.rhinoDark700
                        : Pallete.rhinoDark700,
                  ),
                )
            ],
          );
  }
}
