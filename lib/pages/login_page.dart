import 'package:flutter/material.dart';
import 'package:latlogin_page/components/My_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                     const Text( "Welcome Back! you've been missed!",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 30),

                    MyTextField(
                      controller: usernameController,
                      hintText: "Username",
                      obscureText: false,
                    ),

                    const SizedBox(height: 15),

                    MyTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           const Text("haven't create account?",style: TextStyle(color: Colors.white),),
                          TextButton(
                            onPressed: (){},
                            child:const Text("Sign Up", style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SizedBox(
                        width: 400,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:const Color.fromARGB(255, 42, 165, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)
                            )
                          ),
                          onPressed: () {}, 
                          child: const Text("Log in",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                            
                          ),                        
                        ),
                    ),
                
              ],
            ),
          )
         ),
       ),
    );
  }
}