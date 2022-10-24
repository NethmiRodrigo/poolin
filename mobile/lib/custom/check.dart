// import 'package:flutter/material.dart';
// import 'package:poolin/colors.dart';

// class Check extends StatefulWidget {
//   final Function onCheckedAction;
//   const Check({
//     Key? key,
//     required this.onCheckedAction,
//   }) : super(key: key);

//   @override
//   State<Check> createState() => _CheckState();
// }

// class _CheckState extends State<Check> {
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     Color getColor(Set<MaterialState> states) {
//       const Set<MaterialState> interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused,
//       };
//       if (states.any(interactiveStates.contains)) {
//         return Colors.white;
//       }
//       return Colors.white;
//     }

//     return Checkbox(
//       checkColor: BlipColors.orange,
//       fillColor: MaterialStateProperty.resolveWith(getColor),
//       value: isChecked,
//       onChanged: (bool? value) {
//         [
//           setState(() {
//             isChecked = value!;
//           }),
//           widget.onCheckedAction()
//         ];
//       },
//     );
//   }
// }
