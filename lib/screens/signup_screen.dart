import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/screens/signin_screen.dart';
import 'package:jewelery_shop_managmentsystem/utils/constant.dart';
import 'package:jewelery_shop_managmentsystem/widgets/text_form_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();
  late AnimationController animationController;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

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
    _emailController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  final boredruser = OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffE9E9E9),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(15),
  );

  void showdialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: LottieBuilder.asset(
              'assets/images/thank_you.json',
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
  void SignUp(String name, String userName, String email, String password,
      String passwordconfirm) async {
    ApiProvider response = await Auth().SignUp(
        name: name,
        username: userName,
        email: email,
        password: password,
        passwordconfirm: passwordconfirm);
    if (response.error == null) {
      saveUser(response.data as User);
    } else {
      error = response.error;
    }
    setState(() {});
  }

  void saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    await prefs.setInt('userId', user.id ?? 0);
    print(user.email);
    print(user.token);
    RefreshUser refresh = Provider.of<RefreshUser>(context, listen: false);
    await refresh.refreshuser;
    showdialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width > websize
          ? Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
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
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Align(
                      child: Text(
                        AppLocalizations.of(context)!.signup,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontFamily: 'RobotoB',
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 80),
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: AppLocalizations.of(context)!.email,
                              border: boredruser,
                              enabledBorder: boredruser,
                              focusedBorder: boredruser,
                            ),
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Name',
                              border: boredruser,
                              enabledBorder: boredruser,
                              focusedBorder: boredruser,
                            ),
                          ),
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: AppLocalizations.of(context)!.username,
                              border: boredruser,
                              enabledBorder: boredruser,
                              focusedBorder: boredruser,
                            ),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: AppLocalizations.of(context)!.password,
                              border: boredruser,
                              enabledBorder: boredruser,
                              focusedBorder: boredruser,
                            ),
                          ),
                          TextFormField(
                            controller: _passwordConfirmController,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText:
                                  AppLocalizations.of(context)!.passwordconfirm,
                              border: boredruser,
                              enabledBorder: boredruser,
                              focusedBorder: boredruser,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              SignUp(
                                  _nameController.text,
                                  _usernameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  _passwordConfirmController.text);
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
                                  AppLocalizations.of(context)!.signup,
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
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!
                              .alreadyhaveanaccount),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => SignIn(),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
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
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Align(
                        child: Text(
                          AppLocalizations.of(context)!.signup,
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontFamily: 'RobotoB',
                            fontSize: 36,
                          ),
                        ),
                        alignment:
                            AppLocalizations.of(context)!.signup == 'Sign Up'
                                ? Alignment.topLeft
                                : Alignment.topRight,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 80),
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormUser(
                                controller: _emailController,
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
                                controller: _nameController,
                                hintText:
                                    AppLocalizations.of(context)!.username),
                            for (var _error in error?['errors']?['name'] ?? [])
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _error,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            TextFormUser(
                                controller: _usernameController,
                                hintText:
                                    AppLocalizations.of(context)!.username),
                            for (var _error
                                in error?['errors']?['username'] ?? [])
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _error,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            TextFormUser(
                                controller: _passwordController,
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
                            TextFormUser(
                                controller: _passwordConfirmController,
                                hintText: AppLocalizations.of(context)!
                                    .passwordconfirm,
                                isobscure: true,
                                isIcon: true),
                            for (var _error in error?['errors']
                                    ?['password_confirmation'] ??
                                [])
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _error,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            InkWell(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  SignUp(
                                      _nameController.text,
                                      _usernameController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                      _passwordConfirmController.text);
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
                                    AppLocalizations.of(context)!.signup,
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
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)!
                                .alreadyhaveanaccount),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => SignIn(),
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.login,
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
                ),
              ),
            ),
    );
  }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
}

Widget inputTextField(s) {
  return TextField(
    style: TextStyle(fontSize: 18),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: Color.fromARGB(255, 221, 221, 221)),
          borderRadius: BorderRadius.circular(6)),
      hintText: '$s',
    ),
  );
}
