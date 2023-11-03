// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/features/setting_profile/widget/setting_profile.dart';

import '../../../models/user_models.dart';

class SettingProfileView extends ConsumerWidget {
  static route(UserModel userModel) => MaterialPageRoute(
        builder: (context) => SettingProfileView(
          userModel: userModel,
        ),
      );
  final UserModel userModel;
  SettingProfileView({
    required this.userModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: SettingProfile(user: userModel));
  }
}
