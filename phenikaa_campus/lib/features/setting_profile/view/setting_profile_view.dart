import 'package:boxy/padding.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:phenikaa_campus/common/loading_page.dart';
import 'package:phenikaa_campus/constants/assets_constants.dart';
import 'package:phenikaa_campus/features/auth/controller/auth_controller.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

class SettingProfileView extends ConsumerStatefulWidget {
  const SettingProfileView({super.key});

  @override
  ConsumerState<SettingProfileView> createState() => _SettingProfileViewState();
}

class _SettingProfileViewState extends ConsumerState<SettingProfileView> {
  static final actionMaps = [
    (Icons.people, 'Edit Profile'),
    (Icons.notifications, 'Notifications'),
    (Icons.lock, 'Privacy'),
    (Icons.help, 'Help'),
    (Icons.logout, 'Logout'),
  ];
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider);
    const posi1 = 100.0;
    return switch (currentUser) {
      AsyncData(value: final currentUser?) ||
      AsyncLoading(value: final currentUser?) =>
        Scaffold(
          body: Stack(
            children: [
              Positioned.fill(child: Image.asset(AssetsConstants.darkBlur)),
              Positioned.fill(
                child: SafeArea(
                  top: false,
                  minimum: EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: Pallete.cardColor,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: const SizedBox(
                            height: 300, width: double.maxFinite),
                      ),
                      Expanded(
                        child: OverflowPadding(
                          padding: const EdgeInsets.only(top: -30, bottom: -30),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Pallete.rhinoDark700,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: OverflowPadding(
                                    padding: const EdgeInsets.only(
                                      top: -posi1,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const ShapeDecoration(
                                        color: Pallete.rhinoDark800,
                                        shape: CircleBorder(),
                                      ),
                                      constraints: BoxConstraints.tight(
                                          const Size.square(160)),
                                      child: Stack(
                                        fit: StackFit.loose,
                                        children: [
                                          CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  currentUser.profilePic),
                                              radius: 80),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const ShapeDecoration(
                                                color: Pallete.rhinoDark800,
                                                shape: CircleBorder(),
                                              ),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Pallete.yellow800,
                                                radius: 25,
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.camera_alt,
                                                    color: Pallete.rhinoDark800,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                PaddedRow(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ' ${currentUser.name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text:
                                                    '${currentUser.followers.length} ',
                                                children: const [
                                                  TextSpan(
                                                    text: 'followers',
                                                    style: TextStyle(
                                                      color: Pallete.whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                        Row(
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text:
                                                    '${currentUser.following.length} ',
                                                children: const [
                                                  TextSpan(
                                                    text: 'following',
                                                    style: TextStyle(
                                                      color: Pallete.whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(30),
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: actionMaps.length,
                                    itemBuilder: (context, index) {
                                      final (icon, title) = actionMaps[index];
                                      return ListTile(
                                        leading: Icon(icon),
                                        title: Text(title),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      _ => const Loader()
    };
  }
}
