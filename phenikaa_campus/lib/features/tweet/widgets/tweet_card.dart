import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:phenikaa_campus/features/user_profile/view/user_profile_view.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../constants/assets_constants.dart';
import '../../../core/enums/tweet_type_enum.dart';
import '../../../models/tweet_model.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/tweet_controller.dart';
import 'carousel_image.dart';
import 'hashtag_text.dart';
import 'tweet_icon_button.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  final changeOnTap;
  const TweetCard({
    super.key,
    this.changeOnTap,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Hàm route $tweet \n\n\ =======> $changeOnTap");

    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return currentUser == null
        ? const SizedBox()
        : ref.watch(userDetailsProvider(tweet.uid)).when(
              data: (user) {
                return GestureDetector(
                  onTap: changeOnTap,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  UserProfileView.route(user),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.profilePic),
                                radius: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (tweet.retweetedBy.isNotEmpty)
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AssetsConstants.retweetIcon,
                                        // ignore: deprecated_member_use
                                        color: Palette.greyColor,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${tweet.retweetedBy} retweeted',
                                        style: const TextStyle(
                                          color: Palette.greyColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: user.isTwitterBlue ? 1 : 5,
                                      ),
                                      child: Text(
                                        user.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    if (user.isTwitterBlue)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: SvgPicture.asset(
                                          AssetsConstants.verifiedIcon,
                                        ),
                                      ),
                                    Text(
                                      '@${user.name} ${timeago.format(
                                        tweet.tweetedAt,
                                        locale: "en_short",
                                      )}',
                                      style: const TextStyle(
                                        color: Palette.greyColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                if (tweet.repliedTo.isNotEmpty)
                                  ref
                                      .watch(
                                          getTweetByIdProvider(tweet.repliedTo))
                                      .when(
                                        data: (repliedToTweet) {
                                          final replyingToUser = ref
                                              .watch(
                                                userDetailsProvider(
                                                  repliedToTweet.uid,
                                                ),
                                              )
                                              .value;
                                          return RichText(
                                            text: TextSpan(
                                              text: 'Replying to',
                                              style: const TextStyle(
                                                color: Palette.greyColor,
                                                fontSize: 16,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      ' @${replyingToUser?.name}',
                                                  style: const TextStyle(
                                                    color: Palette.blueColor,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        error: (error, st) => ErrorText(
                                          error: error.toString(),
                                        ),
                                        loading: () => const SizedBox(),
                                      ),
                                HashtagText(text: tweet.text),
                                if (tweet.tweetType == TweetType.image)
                                  CarouselImage(imageLinks: tweet.imageLinks),
                                if (tweet.link.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: AnyLinkPreview(
                                        displayDirection:
                                            UIDirection.uiDirectionHorizontal,
                                        link: '${tweet.link[0]}',
                                      ),
                                    ),
                                  ),
                                ],
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TweetIconButton(
                                        pathName: AssetsConstants.viewsIcon,
                                        text: (tweet.commentIds.length +
                                                tweet.reshareCount +
                                                tweet.likes.length)
                                            .toString(),
                                        onTap: () {},
                                      ),
                                      TweetIconButton(
                                        pathName: AssetsConstants.commentIcon,
                                        text:
                                            tweet.commentIds.length.toString(),
                                        onTap: () {},
                                      ),
                                      TweetIconButton(
                                        pathName: AssetsConstants.retweetIcon,
                                        text: tweet.reshareCount.toString(),
                                        onTap: () {
                                          ref
                                              .read(tweetControllerProvider
                                                  .notifier)
                                              .reshareTweet(
                                                tweet,
                                                currentUser,
                                                context,
                                              );
                                        },
                                      ),
                                      LikeButton(
                                        size: 25,
                                        onTap: (isLiked) async {
                                          ref
                                              .read(tweetControllerProvider
                                                  .notifier)
                                              .likeTweet(
                                                tweet,
                                                currentUser,
                                              );
                                          return !isLiked;
                                        },
                                        isLiked: tweet.likes
                                            .contains(currentUser.uid),
                                        likeBuilder: (isLiked) {
                                          return isLiked
                                              ? SvgPicture.asset(
                                                  AssetsConstants
                                                      .likeFilledIcon,
                                                  color: Palette.redColor,
                                                )
                                              : SvgPicture.asset(
                                                  AssetsConstants
                                                      .likeOutlinedIcon,
                                                  color: Palette.greyColor,
                                                );
                                        },
                                        likeCount: tweet.likes.length,
                                        countBuilder:
                                            (likeCount, isLiked, text) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0),
                                            child: Text(
                                              text,
                                              style: TextStyle(
                                                color: isLiked
                                                    ? Palette.redColor
                                                    : Palette.whiteColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          size: 25,
                                          color: Palette.greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Palette.greyColor),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loader(),
            );
  }
}
