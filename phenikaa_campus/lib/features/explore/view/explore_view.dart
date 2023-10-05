import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phenikaa_campus/common/common.dart';
import 'package:phenikaa_campus/constants/constants.dart';
import 'package:phenikaa_campus/features/explore/widget/search_tile.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

import '../../../constants/text.dart';
import '../../../models/user_models.dart';
import '../controller/explore_controller.dart';
import '../widget/text_form_field_custom.dart';

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  final searchController = TextEditingController();
  bool isShowUsers = false;
  bool isImageVisible = true;

  int searchResultsCount = 0; // Initialize with 0 search results

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
              top: 0,
              right: 0,
              child: Image.asset(AssetsConstants.darkBlur),
            ),
            Positioned(
              top: 130.0,
              child: Container(
                // Centered "Results" container
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Pallete.whiteColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Text(
                      isShowUsers
                          ? '$searchResultsCount Results'
                          : '0 Results', // Display the number of results or "0 Results"
                      style: TextStyle(
                        fontSize: 16,
                        color: Pallete.rhinoDark500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                width: size.width,
                height: 130,
                decoration: BoxDecoration(
                  gradient: Pallete.cardColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            // Layer 2: Column with TextFormFieldCustom
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 100),
                  child: TextFormFieldCustom(
                    onChanged: (value) {
                      setState(() {
                        isShowUsers = true;
                      });
                    },
                    controller: searchController,
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
                    hintText: search,
                    fillColor: Pallete.textformfieldColor,
                  ),
                ),
                // Layer 3: Container with Background Color
              ],
            ),
            Positioned(
              top: 235.0,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: Pallete.rhinoDark700,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            isShowUsers
                ? Container(
                    margin: EdgeInsets.only(top: 230),
                    child: Consumer(
                      builder: (context, ref, child) {
                        // Access the searchUserProvider using ref.watch
                        AsyncValue<List<UserModel>> searchUserAsyncValue = ref
                            .watch(searchUserProvider(searchController.text));

                        // Handle the different states of the provider
                        return searchUserAsyncValue.when(
                          data: (users) {
                            searchResultsCount =
                                users.length; // Update the search results count
                            if (users.isEmpty) {
                              Future.delayed(Duration.zero, () {
                                setState(() {
                                  isShowUsers =
                                      false; // Hide results when no data is available
                                });
                              });
                            }
                            // Render the UI with the data from the provider
                            // You can use data (a List<UserModel>) here
                            return ListView.builder(
                              itemCount: searchResultsCount,
                              itemBuilder: (context, index) {
                                final user = users[index];
                                return SearchTile(userModel: user);
                              },
                            );
                          },
                          loading: () {
                            // Render a loading indicator
                            return const LoadingPage(
                              backgroundColor: Pallete.rhinoDark700,
                            );
                          },
                          error: (error, stackTrace) {
                            // Handle the error
                            return ErrorText(
                              error: error.toString(),
                            );
                          },
                        );
                      },
                    ),
                  )
                : SizedBox(),
            !isShowUsers
                ? Container(
                    margin: EdgeInsets.only(top: 300, left: 28, right: 28),
                    child: Column(
                      children: [
                        Image.asset(AssetsConstants.darkNoContent),
                        Center(
                          child: Text(
                            noSearchFound,
                            style: TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Center(
                            child: Text(
                              searchOtherWords,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Pallete.whiteColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
