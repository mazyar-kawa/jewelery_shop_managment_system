import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/widgets/text_field_user_managment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formkey = GlobalKey<FormState>();

  final TextEditingController _currentPassword = TextEditingController();

  final TextEditingController _newPassword = TextEditingController();

  final TextEditingController _retypeNewPassword = TextEditingController();

  Map<dynamic, dynamic>? error;

  void chnagePassword(String currentPassword, String newPassword,
      String retypeNewPassword, BuildContext context) async {
    ApiProvider response = await Auth()
        .UpdatePassword(currentPassword, newPassword, retypeNewPassword);
    
    if (response.error == null) {
      Auth().logOut();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
        return LoadingPage();
      }), (Route<dynamic> route) => false);
    } else {
      error = response.error;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.changePassword,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoB',
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 20,
            width: 25,
            child: RotatedBox(
              quarterTurns: 90,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            TextFieldUserManagment(
              lable: AppLocalizations.of(context)!.currentPassword,
              controller: _currentPassword,
            ),
            for (var _error in error?['errors']?['current_password'] ?? [])
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _error,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            TextFieldUserManagment(
              lable: AppLocalizations.of(context)!.newPassword,
              controller: _newPassword,
            ),
            for (var _error in error?['errors']?['new_password'] ?? [])
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _error,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            TextFieldUserManagment(
              lable: AppLocalizations.of(context)!.retypeNewPassword,
              controller: _retypeNewPassword,
            ),
            for (var _error
                in error?['errors']?['new_password_confirmation'] ?? [])
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _error,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  chnagePassword(_currentPassword.text, _newPassword.text,
                      _retypeNewPassword.text, context);
                  
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Theme.of(context).primaryColorLight,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Center(
                  child: Text(AppLocalizations.of(context)!.updatePassword,
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 20,
                        fontFamily: 'RobotoB',
                      )),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Theme.of(context).primaryColorLight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Theme.of(context).primaryColorLight,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Center(
                  child: Text(AppLocalizations.of(context)!.cancle,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 20,
                        fontFamily: 'RobotoB',
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
