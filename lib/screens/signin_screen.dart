import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/responsive/mobile_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/responsive_layout.dart';
import 'package:jewelery_shop_managmentsystem/responsive/web_screen_layout.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/screens/signup_screen.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoadingPage()));
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  void showdialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: LottieBuilder.asset(
              'assets/images/confirm.json',
              controller: animationController,
              onLoaded: (complet) {
                animationController.forward();
              },
              width: MediaQuery.of(context).size.width > websize ? 200 : 800,
              fit: BoxFit.cover,
            ),
          );
        },
      );
  final boredruser = OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffE9E9E9),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(15),
  );

  bool islogin = false;

  void logIn(String email, String password) async {
    ApiProvider response = await Provider.of<Auth>(context, listen: false)
        .login(email: email, password: password);
    if (response.error == null) {
      showdialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width > websize
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  width: 750,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          spreadRadius: 1,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        width: MediaQuery.of(context).size.width / 4,
                        child: LottieBuilder.asset(
                          'assets/images/login.json',
                        ),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 50),
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontFamily: 'RobotoB',
                                      fontSize: 36,
                                    ),
                                  ),
                                  alignment: Alignment.center),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: AppLocalizations.of(context)!
                                        .emailusername,
                                    border: boredruser,
                                    enabledBorder: boredruser,
                                    focusedBorder: boredruser,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 50,
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText:
                                        AppLocalizations.of(context)!.password,
                                    border: boredruser,
                                    enabledBorder: boredruser,
                                    focusedBorder: boredruser,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  AppLocalizations.of(context)!.forgotpassword,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontFamily: 'RobotoM',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  logIn(_emailcontroller.text,
                                      _passwordcontroller.text);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .primaryColorLight
                                              .withOpacity(0.3),
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        )
                                      ]),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontFamily: 'RobotoB',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(AppLocalizations.of(context)!
                                        .newtologistics),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (_) => SignUp(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.register,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontFamily: 'RobotoB',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: LottieBuilder.asset(
                      'assets/images/login.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontFamily: 'RobotoB',
                        fontSize: 36,
                      ),
                    ),
                    alignment: AppLocalizations.of(context)!.login == 'Login'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          controller: _emailcontroller,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.emailusername,
                            border: boredruser,
                            enabledBorder: boredruser,
                            focusedBorder: boredruser,
                          ),
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.password,
                            border: boredruser,
                            enabledBorder: boredruser,
                            focusedBorder: boredruser,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            AppLocalizations.of(context)!.forgotpassword,
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'RobotoM',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            logIn(_emailcontroller.text,
                                _passwordcontroller.text);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .primaryColorLight
                                        .withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.login,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontFamily: 'RobotoB',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.newtologistics),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => SignUp(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.register,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'RobotoB',
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
            ),
    );
  }
}
