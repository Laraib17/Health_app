
import 'package:app/Pages/Login/LoginPage.dart';
import 'package:app/Pages/Profile/profilepage.dart';
import 'package:app/Pages/ChatGroups/search_page.dart';
import 'package:app/SharedData/button.dart';
import 'package:app/SharedData/helper/helper_function.dart';
import 'package:app/FireBase/service/authentication.dart';
import 'package:app/FireBase/service/database_service.dart';
import 'package:app/widgets/group_tile.dart';
import 'package:app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class chatpage extends StatefulWidget {
  const chatpage({Key? key}) : super(key: key);

  @override
  State<chatpage> createState() => chatpageState();
}

class chatpageState extends State<chatpage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups ;
  bool _isLoading = false;
  String groupName = "";  


  @override
  void initState() {
    super.initState();
    gettinUserData();
  }


  //string manipulatioon

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1, res.length);
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

    //list of snapshots
     await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 226, 255),
      
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {


              nextScreen(context, const SearchPage());
            },
            icon: const Icon(Icons.search_sharp),
          ),

         
        ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 72, 60, 229),
        title: Text('Chat Groups'),
      ),
      drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 83, 73, 228),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Lottie.asset(
                "assets/images/profilephotonew.json",
                width: 100,
                height: 300,
              ),
              Center(
                child: Text(
                  userName,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),


              Center(
                child: Text(
                  email,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              const SizedBox(
                height: 10,
              ),


          
             
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ElevatedButton(
                  style: drawerprofile,
                  child: Text('Profile'),
                  onPressed: () {
                    nextScreenReplace(context, const ProfilePage());
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ElevatedButton(
                  style: drawerprofile,
                  child: Text('Groups'),
                  onPressed: () {
                    nextScreenReplace(context, const chatpage());
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ElevatedButton(
                  style: drawerprofile,
                  child: Text('Contact Us'),
                  onPressed: () {
                    nextScreenReplace(context, const chatpage());
                  },
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ElevatedButton(
                  style: drawerprofile,
                  child: Text('About '),
                  onPressed: () {
                    nextScreenReplace(context, const chatpage());
                  },
                ),
              ),

              
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 70,
                ),
                child: ElevatedButton(
                  style: drawerlogout,
                  child: Text('Logout'),
                  onPressed: () {
                    authService.signOut().whenComplete(() {
                      nextScreenReplace(context, const LoginPage());
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      body:
    
       groupList(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        popUpDialog(context);
      },
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      focusColor: Color.fromARGB(0, 255, 255, 255),
       elevation: 0, child:  Lottie.asset("assets/images/addbutton2.json" , 
      ),),
      
    );
  }

 popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a group",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        )
                      : TextField(
                          onChanged: (val) {
                            setState(() {
                              groupName = val;
                            });
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (groupName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(userName,
                              FirebaseAuth.instance.currentUser!.uid, groupName)
                          .whenComplete(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                      showSnackbar(
                          context, Colors.green, "Group created successfully.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text("CREATE"),
                )
              ],
            );
          }));
        });
  }


   groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  
                  int reverseIndex = snapshot.data['groups'].length - index - 1;
                  return GroupTile(
                      groupId: getId(snapshot.data['groups'][reverseIndex]),
                      groupName: getName(snapshot.data['groups'][reverseIndex]),
                      userName: snapshot.data['fullName']);
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 229, 16, 16),),
          );
        }
      },
    );
  }
 
 


noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Lottie.asset("assets/images/creatchatgroup.json"),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }


  }
  

  