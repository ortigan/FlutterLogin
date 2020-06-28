import 'package:flutter/material.dart';

import '../screens/settings.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Image.asset("assets/logo.png",
                  height: 40.0, fit: BoxFit.fitHeight),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'Alpha',
                    style: TextStyle(fontSize: 8.0),
                  ),
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              })
        ],
      ),
      body: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);


    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              height: MediaQuery.of(context).size.height,
              color: Color.fromARGB(255, 15, 172, 243),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.pngarts.com/files/3/Avatar-PNG-Download-Image.png"),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userprovider.name,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              userprovider.email,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: Text('Home Page'),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}




