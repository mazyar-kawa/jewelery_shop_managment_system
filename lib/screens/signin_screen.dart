import 'package:flutter/material.dart';
import 'package:jewelery_shop_managmentsystem/screens/bottom_navBar.dart';
import 'package:jewelery_shop_managmentsystem/screens/signup_screen.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            color: Color(0xffEDEDED),
            child: Center(
              child: FadeInImage(
                image: AssetImage('assets/images/signin75.png'),
                height: 300,
                placeholder: AssetImage('assets/images/placeholder70.png'),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'LogIn',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                inputTextField('email'),
                SizedBox(
                  height: 25,
                ),
                inputTextField('password'),
                SizedBox(
                  height: 35,
                ),
                ButtonTheme(
                    height: 45,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoadingPage()));
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      color: Color(0xff455A64),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      splashColor: Color(0xff455A64),
                      elevation: 5,
                    ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Already have an account?  ',
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                      minWidth: 40,
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        _navigateToNextScreen(context);
                      },
                      child: Text(
                        'Sing Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => SignUp()));
}
