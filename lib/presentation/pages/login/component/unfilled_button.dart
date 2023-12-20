import 'package:flutter/material.dart';

class UnfilledButton extends StatelessWidget {
  const UnfilledButton({Key? key, required this.color, required this.onTap, required this.icon, required this.text}) : super(key: key);
  final Color color;
  final String text;
  final IconData icon;
  final Function onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color),
      ),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            Center(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 14, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
