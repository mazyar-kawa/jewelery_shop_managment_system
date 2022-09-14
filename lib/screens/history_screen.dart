import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Theme.of(context).primaryColorLight,
                  )),
              Text(
                AppLocalizations.of(context)!.history,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoB',
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
                child: Text(
              AppLocalizations.of(context)!.yourHistoryisempty,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoB',
                color: Theme.of(context).primaryColorLight,
              ),
            )),
          ),
          Container(
            child: Center(
              child: LottieBuilder.asset(
                'assets/images/empty-box.json',
                width: MediaQuery.of(context).size.width > websize ? 650 : 350,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
