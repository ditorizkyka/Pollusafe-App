import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:latlogin_page/components/constans.dart';
import 'package:latlogin_page/pages/main_Pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _checked = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: Center(
              child: Stack(children: [
                ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                      
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 90,),
                          Text(
                            "Welcome Back!",
                            style: primaryTextStyle.copyWith(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Pollusafe is an application which needs to notification tracker to AQI(Air Quality Index) for all user who use this application.",
                            style: secondaryTextStyle.copyWith(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: primaryTextStyle.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: white1),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "youremail@gmail.com",
                                        hintStyle: secondaryTextStyle.copyWith(
                                            color: textColor1.withOpacity(0.6),
                                            fontSize: 14),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 17),
                                        border: InputBorder.none),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Password",
                                style: primaryTextStyle.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: white1),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                            Icons.visibility_off_outlined),
                                        hintText: "Type your password here",
                                        hintStyle: secondaryTextStyle.copyWith(
                                            color: textColor1.withOpacity(0.6),
                                            fontSize: 14),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 17),
                                        border: InputBorder.none),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _checked,
                                      onChanged: (newBool) {
                                        setState(() {
                                          _checked = newBool;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Text(
                                      "Remember me",
                                      style: thirdTextStyle,
                                    )
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Forgot Passoword?",
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 12),
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: button,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              child: Text(
                                "LOGIN",
                                style: primaryTextStyle.copyWith(
                                    color: white1, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: button2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              child: Text(
                                "SIGNUP",
                                style: primaryTextStyle.copyWith(
                                    color: white1, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      padding: const EdgeInsets.all(40),
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                return const MainPage();
                              }) );
                            },
                            child: Text(
                              "SKIP",
                              style: primaryTextStyle.copyWith(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    )
                  ],
                )
              ]),
            ),
          )),
    );
  }
}
