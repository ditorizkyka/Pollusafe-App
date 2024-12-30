import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:pollusafe_app/src/core/controller/UserController.dart';
import 'package:pollusafe_app/src/core/screen/data/passData/pass_data.dart';
import 'package:pollusafe_app/src/widgets/button/button_app.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // var userAccount = passData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Account",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: SizeApp.h20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: UserController.passData(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return Center(
                    child: Column(children: [
                      Gap.h20,
                      CircleAvatar(
                        radius: SizeApp.h64,
                        backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                      ),
                      Gap.h36,
                      Text(
                        snap.data!.name,
                        style: GoogleFonts.roboto(
                          color: ColorApp.darkBlue,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gap.h8,
                      Text(
                        snap.data!.email,
                        style: GoogleFonts.roboto(
                          color: ColorApp.darkGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap.h52,
                      optionSettings(
                        color: Colors.blue,
                        title: "Settings AQI",
                        icon: Icons.settings_outlined,
                        onTap: () {
                          context.goNamed("settings_aqi");
                        },
                      ),
                      optionSettings(
                        color: Colors.purple,
                        title: "Language",
                        icon: Icons.language_outlined,
                        onTap: () {
                          context.goNamed("settings_language");
                        },
                      ),
                      optionSettings(
                        color: Colors.blueGrey,
                        title: "Sign Out",
                        icon: Icons.logout_outlined,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => const AlertDialogAppSignOut(
                                  title: "Sign Out",
                                  description:
                                      "Are you sure you want to sign out?"));
                          // FirebaseAuth.instance.signOut();
                          // context.goNamed('signin');
                        },
                      )
                    ]),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}

class AlertDialogAppSignOut extends StatelessWidget {
  final String title;
  final String description;

  const AlertDialogAppSignOut({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorApp.darkBlue,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        description,
        style: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ColorApp.darkGrey,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
            width: 120,
            height: 50,
            child: ButtonApp(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: "Close"),
          ),
          Gap.w16,
          SizedBox(
            width: 120,
            height: 50,
            child: ButtonApp(
                backgroundcolor: Colors.red,
                onPressed: () {
                  FirebaseAuth.instance.signOut();

                  context.goNamed('signin');
                },
                text: "Sign Out"),
          ),
        ])
      ],
    );
  }
}

class optionSettings extends StatelessWidget {
  final String title;
  final IconData icon;
  final MaterialColor color;
  final Function()? onTap;
  const optionSettings({
    required this.color,
    required this.title,
    required this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: ColorApp.darkBlue,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 17,
        ),
        onTap: onTap,
      ),
    );
  }
}
