import 'package:flutter/material.dart';
import 'package:pharmacist_application/core/util/theme.dart';

import '../../../../core/util/palette.dart';

class ColoredFilledButton extends StatelessWidget {
  const ColoredFilledButton({Key? key, required this.color, required this.secondColor, required this.onTap, required this.icon, required this.text}) : super(key: key);
  final Color color;
  final Color secondColor;
  final String text;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: Icon(
                icon,
                color: Theme.of(context).isDark? ColorConfig.primary: ColorConfig.WHITE,
              ),
            ),
            Center(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 14, color: secondColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
