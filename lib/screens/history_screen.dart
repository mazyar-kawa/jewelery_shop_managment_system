import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
                    color: Theme.of(context).primaryColor,
                  )),
              Text(
                'History',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoB',
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                    child: Text(
                  'Your History is empty',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'RobotoB',
                    color: Theme.of(context).primaryColor,
                  ),
                )),
              ),
              Container(
                child: Center(
                  child: LottieBuilder.asset(
                    'assets/images/empty-box.json',
                    width: 350,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
