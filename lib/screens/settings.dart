import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

//todo validations for all fields

class Settings extends StatelessWidget {
  final TextEditingController oldPasswordController = new TextEditingController();
  final TextEditingController newPasswordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
      body: Container(
       decoration: BoxDecoration(
         color: Colors.blue[50],
           borderRadius: BorderRadius.only(
               topLeft: Radius.circular(30.0),
               topRight: Radius.circular(30.0))
       ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Container(
                color: Colors.white,
                  height: 100.0,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Settings',style: TextStyle(fontSize: 30.0),textAlign: TextAlign.center,)),
              ListTile(
                title: Text('Change Password',textAlign: TextAlign.left,),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Scaffold(
                      body: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                      
                          children: <Widget>[

                            Container(child:textSection()),
                            Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Container(child:buttonSection(context,userprovider)),
                            ),
                          ],
                        ),
                      ),
                    )
                  );
                },

              ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                       color: Colors.blue[600],
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                    child: Center(child: Text('Logout',style: TextStyle(color: Colors.white),)),
                    ),
                    onTap: (){
                      userprovider.signOut();
                      Navigator.pop(context);
                    },
                  ),
                )

            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: BackButton(),elevation:0,

      ),



    );


  }

  textSection(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
//      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Change Password' , style: TextStyle(color: Colors.black45, fontSize: 20),),
          ),
          oldPassword("Old Password", Icons.lock_outline),
          SizedBox(height: 30.0),
          newPassword("New Password", Icons.lock),
          SizedBox(height: 30.0),
          confirmPassword("Confirm Password", Icons.lock),
        ],
      ),
    );
  }


  buttonSection(context,user) {



    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
          onPressed: () {

            user.changePassword( oldPasswordController.text,newPasswordController.text,confirmPasswordController.text);
              Navigator.pop(context);

          },
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child:

          Text('Confirm', style: TextStyle(color: Colors.white70),)
      ),
    );
  }

  TextFormField oldPassword(String title, IconData icon){
    return TextFormField(

      controller: oldPasswordController,
      obscureText: true,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey),
//        icon: Icon(icon),
      ),
    );
  }
  TextFormField newPassword(String title, IconData icon){
    return TextFormField(

      controller: newPasswordController,
      obscureText: true,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey),
//        icon: Icon(icon),
      ),
    );

  }
  TextFormField confirmPassword(String title, IconData icon){
    return TextFormField(

      controller: confirmPasswordController,
      obscureText: true,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey),
//        icon: Icon(icon),
      ),
    );
  }
}
