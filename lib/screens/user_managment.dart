import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/provider/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/widgets/text_field_user_managment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UserManagmentScreen extends StatefulWidget {
  const UserManagmentScreen({Key? key}) : super(key: key);

  @override
  State<UserManagmentScreen> createState() => _UserManagmentScreenState();
}

class _UserManagmentScreenState extends State<UserManagmentScreen> {
  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<RefreshUser>(context).currentUser;

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
                        color: Theme.of(context).primaryColorLight,
                      )),
                  Text(
                    AppLocalizations.of(context)!.userManagement,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoB',
                      color: Theme.of(context).primaryColorLight,
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
                      backgroundImage: user.user!.profilePicture != null
                          ? NetworkImage(user.user!.profilePicture)
                          : NetworkImage(
                              'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg'),
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
                    initialValue: '${user.user!.name}',
                    lable: AppLocalizations.of(context)!.username,
                  ),
                  TextFieldUserManagment(
                    initialValue: '${user.user!.username}',
                    lable: AppLocalizations.of(context)!.password,
                  ),
                  TextFieldUserManagment(
                    initialValue: '${user.user!.phoneNo}',
                    lable: AppLocalizations.of(context)!.phone,
                  ),
                  TextFieldUserManagment(
                    initialValue: '${user.user!.address}',
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
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Theme.of(context).primaryColorLight,
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
