import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: SvgPicture.asset(
                    'assets/images/${image}',
                    width: 25,
                    color: title == AppLocalizations.of(context)!.logOut
                        ? Colors.red
                        : Theme.of(context).primaryColorLight,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'RobotoB',
                      fontSize: 18,
                      color: title == AppLocalizations.of(context)!.logOut
                          ? Colors.red
                          : Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
