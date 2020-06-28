import 'package:flutter/material.dart';

import './providers/user_provider.dart';
import './screens/login.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
          lazy: false,
        ),

       
//        ChangeNotifierProvider<SharedPrefs>(
//          create: (_) => SharedPrefs(),
//          lazy: false,
//        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Marammat Customer App',
        home: Scaffold(body: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);

    if (userprovider.status == Status.Unauthenticated) {
      return Login();
    } else if (userprovider.status == Status.Authenticated) {
      return Home();
    } else if(userprovider.status == Status.Authenticating){
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
