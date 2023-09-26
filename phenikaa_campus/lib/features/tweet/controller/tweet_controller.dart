import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:phenikaa_campus/apis/tweet_api.dart';
import 'package:phenikaa_campus/core/enums/tweet_type_enum.dart';
import 'package:phenikaa_campus/core/utils.dart';
import 'package:phenikaa_campus/features/auth/controller/auth_controller.dart';
import 'package:phenikaa_campus/models/tweet_model.dart';

final tweetControllerProvider = StateNotifierProvider<TweetController, bool>(
  (ref) {
    return TweetController(
      ref: ref,
      tweetAPI: ref.watch(tweetAPIProvider),
    );
  },
);

class TweetController extends StateNotifier<bool> {
  final TweetAPI _tweetAPI;
  final Ref _ref;
  TweetController({required Ref ref, required TweetAPI tweetAPI})
      : _ref = ref,
        _tweetAPI = tweetAPI,
        super(false);

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, "Please enter text");
      return;
    }
    if (images.isNotEmpty) {
      _shareImageTweet(images: images, text: text, context: context);
    } else {
      _shareTextTweet(text: text, context: context);
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {}
  void _shareTextTweet({
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    final link = _getLinksFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value;
    Tweet tweet = Tweet(
        text: text,
        hashtags: hashtags,
        link: link,
        imageLinks: const [],
        uid: user!.uid,
        tweetType: TweetType.text,
        tweetedAt: DateTime.now(),
        likes: const [],
        commentIds: const [],
        id: "",
        reshareCount: 0,
        retweetedBy: "",
        repliedTo: "");
    final res = await _tweetAPI.shareTweet(tweet);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  List<String> _getLinksFromText(String text) {
    RegExp regex = RegExp(r'(http://|https://|www\.)\S+');
    Iterable<Match> matches = regex.allMatches(text);

    List<String> links = [];

    for (Match match in matches) {
      links.add(match.group(0)!);
    }

    return links;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    RegExp regex = RegExp(r'(#)\S+');
    Iterable<Match> matches = regex.allMatches(text);

    for (Match match in matches) {
      hashtags.add(match.group(0)!);
    }

    return hashtags;
  }
}
