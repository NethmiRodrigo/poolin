import 'package:flutter/material.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/icons.dart';

class HomeScreenCard extends StatelessWidget {
  HomeScreenCard(
      {Key? key, required this.text, required this.route, this.hasIcon = false})
      : super(key: key);
  String text;
  Widget route;
  bool hasIcon = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: BlipColors.orange,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
            style: BlipFonts.labelBold
                .merge(const TextStyle(color: BlipColors.white)),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(
                BlipIcons.arrowRight,
                size: 20,
                color: BlipColors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => route,
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
