import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/screens/signup_screen.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/text_form_field.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();
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
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) {
            return LoadingPage();
          }), (Route<dynamic> route) => false);
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

  Map<dynamic, dynamic>? error;

  void logIn(String email, String password) async {
    ApiProvider response = await Auth().login(email: email, password: password);
    if (response.error == null) {
      saveUser(response.data as User);
    } else {
      error = response.error;
      if (error?['message'] == 'The provided credentials are incorrect.') {
        print(error?['message']);
      }
    }
    setState(() {});
  }

  void saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    await prefs.setInt('userId', user.id ?? 0);
    RefreshUser refresh = Provider.of<RefreshUser>(context, listen: false);
    await refresh.refreshuser;
    showdialog(context);
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
              child: SingleChildScrollView(child: Builder(builder: (context) {
                return Form(
                  key: formkey,
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
                        alignment:
                            AppLocalizations.of(context)!.login == 'Login'
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
                            TextFormUser(
                                controller: _emailcontroller,
                                hintText: AppLocalizations.of(context)!.email),
                            for (var _error in error?['errors']?['email'] ?? [])
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _error,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            TextFormUser(
                                controller: _passwordcontroller,
                                hintText:
                                    AppLocalizations.of(context)!.password,
                                isobscure: true,
                                isIcon: true),
                            for (var _error
                                in error?['errors']?['password'] ?? [])
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _error,
                                  style: TextStyle(color: Colors.red),
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
                                if (formkey.currentState!.validate()) {
                                  logIn(_emailcontroller.text,
                                      _passwordcontroller.text);
                                }
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
                          ],
                        ),
                      ),
                      if (error?['message'] ==
                          'The provided credentials are incorrect.')
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            error?['message'],
                            style: TextStyle(color: Colors.red),
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
                  ),
                );
              })),
            ),
    );
  }
}
