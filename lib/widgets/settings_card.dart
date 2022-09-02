import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileCards extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onPressed;
  const ProfileCards({
    Key? key,
    required this.title,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: SvgPicture.asset(
                  image,
                  width: 30,
                  color: title == 'Log out'
                      ? Colors.red
                      : Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'RobotoB',
                    fontSize: 18,
                    color: title == 'Log out'
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: title == 'Log out'
                ? Colors.red
                : Theme.of(context).primaryColor,
          )
        ]),
      ),
    );
  }
}
