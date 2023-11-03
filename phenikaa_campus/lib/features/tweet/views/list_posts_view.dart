import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phenikaa_campus/constants/constants.dart';
import 'package:phenikaa_campus/features/explore/widget/text_form_field_custom.dart';
import 'package:phenikaa_campus/features/tweet/views/create_tweet_view.dart';
import 'package:phenikaa_campus/features/tweet/widgets/tweet_list.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

class NewPostsList extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const NewPostsList(),
      );
  const NewPostsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewPostsListState();
}

class _NewPostsListState extends ConsumerState<NewPostsList> {
  void onCreateTweet() {
    Navigator.push(context, CreateTweetScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.blackColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // Layer 1: Background Image
            Positioned(
              top: 0,
              child: Container(
                margin: EdgeInsets.symmetric(),
                width: size.width,
                height: size.height * 0.8,
                decoration: BoxDecoration(
                  gradient: Pallete.cardColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            Positioned(
              top: 100,
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
                GestureDetector(
                  onTap: onCreateTweet,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.035, horizontal: 60),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Pallete.rhinoDark700,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.create),
                        Text("How are you today?"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: EdgeInsets.only(
                top: size.height * 0.13,
                left: 10,
                right: 10,
              ),
              child: TweetList(),
            )
          ],
        ),
      ),
    );
  }
}
