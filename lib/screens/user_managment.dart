import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/model/user_model.dart';
import 'package:jewelery_shop_managmentsystem/screens/change_password.dart';
import 'package:jewelery_shop_managmentsystem/service/api_provider.dart';
import 'package:jewelery_shop_managmentsystem/service/auth_service.dart';
import 'package:jewelery_shop_managmentsystem/service/refresh_user.dart';
import 'package:jewelery_shop_managmentsystem/widgets/text_field_user_managment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class UserManagmentScreen extends StatefulWidget {
  const UserManagmentScreen({Key? key}) : super(key: key);

  @override
  State<UserManagmentScreen> createState() => _UserManagmentScreenState();
}

class _UserManagmentScreenState extends State<UserManagmentScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController? _name;
  TextEditingController? _username;
  TextEditingController? _phone;
  TextEditingController? _address;
  TextEditingController? _email;
  File? _image;
  PickedFile? _pickedFile;
  final _picked = ImagePicker();

  Future<void> _pickImage(ImageSource _source) async {
    _pickedFile = await _picked.getImage(source: _source);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
        
      });
    }
  }

  Map<dynamic, dynamic>? error;

  void updateUser(File image ,String name, String username, String email, String phone_no,
      String address) async {
    
    ApiProvider response =
        await Auth().UpdateUserData(image,name, username, email, phone_no, address);
    if (response.error == null) {
      saveUser(response.data);
    } else {
      error = response.error;
    }
    setState(() {});
  }

  void saveUser(AuthUser user) async {
    RefreshUser refresh = Provider.of<RefreshUser>(context, listen: false);
    await refresh.refreshuser(update: true, user: user);
  }

  late AuthUser user;
  @override
  void initState() {
    user = Provider.of<RefreshUser>(context, listen: false).currentUser;
    _name = TextEditingController(text: user.user!.name);
    _username = TextEditingController(text: user.user!.username);
    _email = TextEditingController(text: user.user!.email);
    _phone = TextEditingController(text: user.user!.phoneNo);
    _address = TextEditingController(text: user.user!.address);
    super.initState();
  }

  @override
  void dispose() {
    _name!.dispose();
    _username!.dispose();
    _email!.dispose();
    _phone!.dispose();
    _address!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
           
            AppLocalizations.of(context)!.userInformation,
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
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Stack(
                      children: [
                        Container(
                          child: _pickedFile != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage:
                                      FileImage(File(_pickedFile!.path)),
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage: user.user!.profilePicture !=
                                          null
                                      ? NetworkImage("http://192.168.1.32:8000"+user.user!.profilePicture,)
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
                                onPressed: () {
                                  showModalBottomSheet(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    context: context,
                                    elevation: 10,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 120,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _pickImage(
                                                      ImageSource.camera);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 15),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.camera_alt,
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                      ),
                                                      Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight,
                                                            fontFamily:
                                                                "RobotoM",
                                                            fontSize: 18),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _pickImage(
                                                      ImageSource.gallery);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 15),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .photo_library_rounded,
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                      ),
                                                      Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight,
                                                            fontFamily:
                                                                "RobotoM",
                                                            fontSize: 18),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
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
                          lable: AppLocalizations.of(context)!.name,
                          controller: _name!,
                        ),
                        for (var _error in error?['errors']?['name'] ?? [])
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
                          lable: AppLocalizations.of(context)!.username,
                          controller: _username!,
                        ),
                        for (var _error in error?['errors']?['username'] ?? [])
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
                          lable: AppLocalizations.of(context)!.email,
                          controller: _email!,
                        ),
                        for (var _error in error?['errors']?['email'] ?? [])
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
                          lable: AppLocalizations.of(context)!.phone,
                          controller: _phone!,
                        ),
                        for (var _error in error?['errors']?['phone_no'] ?? [])
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
                          lable: AppLocalizations.of(context)!.address,
                          controller: _address!,
                        ),
                        for (var _error in error?['errors']?['address'] ?? [])
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
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChangePasswordScreen()));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                        child: Text(AppLocalizations.of(context)!.changePassword,
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
                      if (formkey.currentState!.validate()) {
                        updateUser(_image!,_name!.text, _username!.text, _email!.text,
                            _phone!.text, _address!.text);
                      }
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                        child: Text(AppLocalizations.of(context)!.save,
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 20,
                              fontFamily: 'RobotoB',
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
