import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/widgets/text_field_user_managment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserManagmentScreen extends StatefulWidget {
  const UserManagmentScreen({Key? key}) : super(key: key);

  @override
  State<UserManagmentScreen> createState() => _UserManagmentScreenState();
}

class _UserManagmentScreenState extends State<UserManagmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
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
                    AppLocalizations.of(context)!.userManagement,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoB',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Stack(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10000),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  TextFieldUserManagment(
                    initialValue: 'Mr.Mazyar',
                    lable: AppLocalizations.of(context)!.username,
                  ),
                  TextFieldUserManagment(
                    initialValue: 'password',
                    lable: AppLocalizations.of(context)!.password,
                  ),
                  TextFieldUserManagment(
                    initialValue: '0770*******',
                    lable: AppLocalizations.of(context)!.phone,
                  ),
                  TextFieldUserManagment(
                    initialValue: 'Slemani',
                    lable: AppLocalizations.of(context)!.address,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Theme.of(context).primaryColor,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Center(
                child: Text(AppLocalizations.of(context)!.save,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 20,
                      fontFamily: 'RobotoB',
                    )),
              ),
            )
          ],
        ),
      ],
    ));
  }
}
