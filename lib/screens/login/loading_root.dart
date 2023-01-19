import 'package:flutter/material.dart';

// pub dev
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// routers page
import 'package:eczanem/screens/home/home.dart';
import 'package:eczanem/theme_style/main_style.dart';

// ignore: camel_case_types
class loadingRootScreen extends StatefulWidget {
  const loadingRootScreen({super.key});

  @override
  State<loadingRootScreen> createState() => _loadingRootScreenState();
}

// ignore: camel_case_types
class _loadingRootScreenState extends State<loadingRootScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const buildHome(),
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
            LoadingAnimationWidget.beat(
                color: themeMainColor.backgroundColor, size: 70),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Bilgiler Kontrol Ediliyor...",
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Lütfen Bekleyiniz",
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
