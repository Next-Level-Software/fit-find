// import 'package:growth/app/constants/app_constants.dart';
// import 'package:growth/app/routes/app_pages.dart';
// import 'package:growth/app/widgets/custom_avatar.dart';
// import 'package:growth/config/theme/light_theme_colors.dart';
// import 'package:growth/utils/token_utils.dart';

// import '../environment/environment.dart';
// import '../widgets/custom_buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// customHomeAppbar({
//   final String? name,
//   final Color? appColor,
//   final bool? isBackBtn,
//   final bool? isNotificationBtn,
//   final Function()? onMenuBtn,
//   final Function()? onProfileBtn,
// }) {
//   var userName = TokenUtil.getUserDataFromToken()?.name;
//   return AppBar(
//     backgroundColor: appColor,
//     automaticallyImplyLeading: isBackBtn ?? true,
//     title: Row(
//       children: [
//         GestureDetector(
//           onTap: onProfileBtn ??
//               () {
//                 (TokenUtil.getUserIsCoach())
//                     ? Get.toNamed(Routes.COACH_PROFILE)
//                     : Get.toNamed(Routes.PROFILE);
//               },
//           child: CustomAvatar(
//             isRounded: false,
//             borderRadius: kBorderRadius * 1.5,
//             text: TokenUtil.getUserDataFromToken()?.name ?? "user",
//             imagePath:
//                 ((TokenUtil.getUserDataFromToken()?.profilePhoto) != null)
//                     ? FILE_BASE_URL +
//                         (TokenUtil.getUserDataFromToken()?.profilePhoto ?? '')
//                     : "",
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: RichText(
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               text: TextSpan(
//                 text: 'Good day, ',
//                 style: Get.textTheme.headlineSmall?.copyWith(
//                     color: Colors.black, fontWeight: FontWeight.normal),
//                 children: <TextSpan>[
//                   TextSpan(
//                       text: userName ??
//                           ((TokenUtil.getUserIsCoach()) ? 'Imane' : "Aboud"),
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         if (isNotificationBtn ?? false)
//           CustomIconButton(
//             iconData: Icons.notifications_outlined,
//             color: Colors.black,
//             backgroundColor: Colors.transparent,
//             badge: 1,
//             onTap: () {
//               Get.toNamed(Routes.NOTIFICATION);
//             },
//             width: 40,
//             height: 40,
//           ),
//         CustomIconButton(
//           iconData: Icons.menu,
//           color: Colors.black,
//           backgroundColor: Colors.transparent,
//           onTap: onMenuBtn,
//           width: 40,
//           height: 40,
//         )
//       ],
//     ),
//   );
// }

// customAppBar(
//     {final Color? appColor,
//     void Function()? onPressed,
//     final String? title,
//     List<Widget>? actions}) {
//   return AppBar(
//     backgroundColor:
//         appColor ?? LightThemeColors.scaffoldBackgroundColorLightGey,
//     leading: IconButton(
//       onPressed: onPressed ??
//           () {
//             Get.back();
//           },
//       icon: Icon(Icons.arrow_back),
//     ),
//     title: Text(
//       title ?? '',
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     ),
//     centerTitle: true,
//     actions: actions ?? [],
//   );
// }
