import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/user_provider.dart';



class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(child: headerSection()),
                  Container(child: textSection(user)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(child: buttonSection(context, user)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buttonSection(context, user) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
          elevation: 0,
          onPressed: (){

            if (_formKey.currentState.validate()) {
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content:
                  Text('Signing in ')));
              user.loginUser(emailController.text, passwordController.text);

            }},


          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            'Sign In',
            style: TextStyle(color: Colors.white70),
          )),
    );
  }

  textSection(user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          txtEmail("Email", Icons.email, user),
          SizedBox(height: 30.0),
          txtPassword("Password", Icons.lock),
        ],
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();

  TextFormField txtEmail(String title, IconData icon, user) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter email';
        } else if (!value.contains('@')) {
          return 'Please enter valid email';
        }
        return null;
      },
      controller: emailController,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey),
//        icon: Icon(icon),
      ),
    );
  }

  TextFormField txtPassword(String title, IconData icon) {
    return TextFormField(
      onChanged: null,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },

      controller: passwordController,
      obscureText: true,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        focusColor: Colors.green,
        border: OutlineInputBorder(),
        hintText:  title,
        hintStyle: TextStyle(color: Colors.grey),
//        icon: Icon(icon),
      ),
    );
  }

  headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
      child: Column(
        children: <Widget>[
          Image.asset("assets/construction.png"),
          Container(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            // child: Image.asset("assets/logo_desc.png"),  //insert your logo
          ))
        ],
      ),
    );
  }
}
