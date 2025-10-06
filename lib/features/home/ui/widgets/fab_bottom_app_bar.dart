// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../../../core/helpers/extensions/context_extenstions.dart';
// import '../../../../../core/helpers/extensions/string_extensions.dart';
// import '../../../../../core/style/app_colors.dart';

// import '../../../../../core/style/app_font_weight.dart';
// import '../../../../../core/widgets/custom_tap.dart';
// import '../../controller/home_cubit.dart';

// class FABBottomAppBarItem {
//   final String imagePath;
//   final String text;
//   FABBottomAppBarItem({required this.imagePath, required this.text});
// }

// class FABBottomAppBar extends StatefulWidget {
//   final List<FABBottomAppBarItem> items;
//   final ValueChanged<int> onTabSelected;

//   const FABBottomAppBar({
//     super.key,
//     required this.items,
//     required this.onTabSelected,
//   });

//   @override
//   State<StatefulWidget> createState() => FABBottomAppBarState();
// }

// class FABBottomAppBarState extends State<FABBottomAppBar> {
//   late HomeCubit cubit;
//   @override
//   void initState() {
//     super.initState();
   
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> items = List.generate(widget.items.length, (int index) {
//       return _buildTabItem(
//         item: widget.items[index],
//         index: index,
//         onPressed: cubit.changeScreen,
//       );
//     });
//     return Container(
//       decoration: const BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 1,
//           ),
//         ],
//       ),
//       child: BottomAppBar(
//         height: 68.h,
//         shape: const CircularNotchedRectangle(),
//         color: Colors.white,
//         notchMargin: 8.w,
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: items,
//         ),
//       ),
//     );
//   }

//   Widget _buildTabItem({
//     required FABBottomAppBarItem item,
//     required int index,
//     required ValueChanged<int> onPressed,
//   }) {
//     return Expanded(
//       child: Material(
//         type: MaterialType.transparency,
//         child: CustomTap(
//           onTap: () => onPressed(index),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             spacing: 8.h,
//             children: [
//               SvgPicture.asset(
//                 width: 22.w,
//                 height: 22.h,
//                 item.imagePath.svg,
//                 colorFilter: ColorFilter.mode(
//                   cubit.screenIndex == index
//                       ? context.colorScheme.primary
//                       : AppColors.kGray700,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               AnimatedDefaultTextStyle(
//                 style: TextStyle(
//                   color: cubit.screenIndex == index
//                       ? context.colorScheme.primary
//                       : AppColors.kGray700,
//                   fontSize: 14.sp,
//                   fontFamily: 'Zain',
//                   fontWeight: cubit.screenIndex == index
//                       ? AppFontWeight.bold
//                       : AppFontWeight.regular,
//                 ),
//                 duration: const Duration(milliseconds: 300),
//                 child: Text(
//                   item.text,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
