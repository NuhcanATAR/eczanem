import 'package:eczanem/screens/home/home.dart';
import 'package:flutter/material.dart';

// pub dev
import 'package:firebase_core/firebase_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// routers page
import 'package:eczanem/theme_style/main_style.dart';
import 'package:eczanem/screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const buildMain());
}

// ignore: camel_case_types
class buildMain extends StatelessWidget {
  const buildMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/routersLoading",
      routes: {
        "/routersLoading": (context) => const buildRoutersLoading(),
        "/userLoadingScreen": (context) => const userLoginScreen(),
        "/home": (context) => const buildHome(),
      },
    );
  }
}

// ignore: camel_case_types
class buildRoutersLoading extends StatefulWidget {
  const buildRoutersLoading({super.key});

  @override
  State<buildRoutersLoading> createState() => _buildRoutersLoadingState();
}

// ignore: camel_case_types
class _buildRoutersLoadingState extends State<buildRoutersLoading> {
  @override
  // ignore: unused_element
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const userLoginScreen(),
          ),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl:
                  "https://firebasestorage.googleapis.com/v0/b/eczanedb.appspot.com/o/appLogo%2FDuyuruIcon.jpg?alt=media&token=718996ab-0772-4fc9-8224-c76fabbf08ea",
              imageBuilder: (context, imageProvider) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: context.dynamicWidth(0.2),
                    height: context.dynamicHeight(0.1),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Eczanem",
                    style: GoogleFonts.nunito(
                      textStyle:
                          Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  Text(
                    "Senin Eczanen",
                    style: GoogleFonts.nunito(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.black,
                              ),
                    ),
                  ),
                ],
              ),
              errorWidget: (context, url, error) =>
                  const CircularProgressIndicator(),
              placeholder: (context, url) => LoadingAnimationWidget.beat(
                  color: themeMainColor.backgroundColor, size: 35),
            ),
          ],
        ),
      ),
    );
  }
}
