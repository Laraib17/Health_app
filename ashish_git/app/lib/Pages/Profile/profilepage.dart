import 'package:app/Pages/Login/LoginPage.dart';
import 'package:app/SharedData/button.dart';
import 'package:app/SharedData/helper/helper_function.dart';
import 'package:app/FireBase/service/authentication.dart';
import 'package:app/Pages/HomePage/welcome3.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    gettinUserData();
  }

  gettinUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar:   AppBar(
          elevation: 0,
          actions: [
            
            // ElevatedButton(onPressed: (){}, child: Text("ashish"))
            // Image.asset('assets/images/Logo.png', height: 50, width: 50,),
          ],
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 72, 60, 229),
          title: Text("Profile Page" , style: TextStyle(color: Colors.white),),
        ), 
        
        backgroundColor: Color.fromARGB(255, 72, 60, 229),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 370,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(108, 252, 252, 252),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Column(
                    children: [
                      Lottie.asset(
                        "assets/images/newprofileheader.json",
                        width: 300,
                        height: 300,
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(186, 5, 5, 5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                            child: Text(
                          "Basic Account ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13),
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(108, 252, 252, 252),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_2,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Center(
                          child: Text(
                        userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 30,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(108, 252, 252, 252),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.white,
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      Center(
                          child: Text(
                        email,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    style : profilepagehomebutton,
                      onPressed: () {nextScreenReplace(context, const Welcome3());}, child: Row(
                        
                        verticalDirection: VerticalDirection.down ,
                        
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                
                          Icon (Icons.home),
                          SizedBox(width: 10, ),
                          Text("Home Page"),
                        ],
                      )),
                ),



                Container(
                  width: 150,
                  child: ElevatedButton(
                    style : profilepagelogoutbutton,
                      onPressed: () {
                       authService.signOut().whenComplete(() {
                                                nextScreenReplace(context, const LoginPage());
                                              });}, child: Row(
                        
                        verticalDirection: VerticalDirection.down ,
                        
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                
                          Icon (Icons.exit_to_app),
                          SizedBox(width: 10, ),
                          Text("Logout"),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
