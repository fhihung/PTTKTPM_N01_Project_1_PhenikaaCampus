// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:phenikaa_campus/common/common.dart';
// import 'package:phenikaa_campus/features/home/view/home_view.dart';
// import 'package:phenikaa_campus/theme/theme.dart';

// class CreateTweetScreen extends ConsumerStatefulWidget {
//   static route() => MaterialPageRoute(
//         builder: (context) => const CreateTweetScreen(),
//       );
//   const CreateTweetScreen({super.key});
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _CreateTweetScreenState();
// }

// class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(
//             Icons.close,
//             size: 30,
//           ),
//         ),
//         actions: [
//           RoundedSmallButton(
//             label: "Tweet",
//             onTap: () {},
//             backgroundColor: Pallete.blueColor,
//             textColor: Pallete.whiteColor,
//           )
//         ],
//       ),
      
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(children: [
//           Row(
//             children: [
//                     CircleAvatar(
//                 backgroundImage: NetworkImage(),
//               )
//             ],
//           )
//         ]),
//       )),
//     );
//   }
// }
