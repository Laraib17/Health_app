import 'package:flutter/material.dart';

import 'button.dart';
import 'welcome2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 51, 180),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // const CircleAvatar(
            //   radius: 50,
            //   backgroundImage: AssetImage('assets/images/pfp2.png'),
            // ),

            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),

            

            // const Text(
            //   'SOLUTION IS HERE',
            //   style: TextStyle(
            //     // fontWeight: FontWeight.bold,
            //     fontSize: 20,
            //   ),
            // ),

            const SizedBox(
              height: 15,
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 40),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Color.fromRGBO(207, 223, 180, 0.74),
            //       border: Border.all(color: Color.fromARGB(255, 194, 245, 165)),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child:  const Padding(
            //       padding: EdgeInsets.only(left: 110),
            //       child: TextField(
                    
            //         decoration:  InputDecoration(
            //           border: InputBorder.none,
            //           hintText: ' Your Name ',
                      
            //         ),
                    
            //       ),
            //     ),
            //   ),
            // ),

            Image.asset(
                'assets/images/doctor2.png',
                height: 400,
                width: 400,
              ), // 


              const Text(
              ' WELCOME ',
              
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            // // sign in button
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal : 40.0),
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color : Color.fromARGB(255, 115, 28, 229),
            //       border  : Border.all(color : Color.fromARGB(255, 148, 12, 178)),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Center(child: Text('Log In' ,
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold ,
            //       fontSize: 15,
            //     ),)),
            //   ),
            // ),

            Container(
              child: ElevatedButton(
                style: buttonPrimary,
                child: Text('LETS GO '),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Welcome2(
                      
                    )),
                  );
                },
              ),
            ),



            
          ]),
        ));

      

        
  }
}