import 'package:flutter/material.dart';

// pub dev
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

// routers page
import 'package:eczanem/screens/forgot_pass/forgot_pass.dart';
import 'package:eczanem/theme_style/main_style.dart';

// ignore: camel_case_types
class forgotRouterErrorEmailLoading extends StatefulWidget {
  const forgotRouterErrorEmailLoading({super.key});

  @override
  State<forgotRouterErrorEmailLoading> createState() =>
      _forgotRouterErrorEmailLoadingState();
}

// ignore: camel_case_types
class _forgotRouterErrorEmailLoadingState
    extends State<forgotRouterErrorEmailLoading> {
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
            builder: (context) => const forgotEmailErorrScreen(),
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
            LoadingAnimationWidget.inkDrop(
                color: themeMainColor.backgroundColor, size: 70),
            const SizedBox(
              height: 30,
            ),
            Text(
              "E-mail Kontrol Ediliyor...",
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

// ignore: camel_case_types
class forgotEmailErorrScreen extends StatefulWidget {
  const forgotEmailErorrScreen({super.key});

  @override
  State<forgotEmailErorrScreen> createState() => _forgotEmailErorrScreenState();
}

// ignore: camel_case_types
class _forgotEmailErorrScreenState extends State<forgotEmailErorrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Şifre Sıfırlama Talebi",
          style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: themeMainColor.backgroundColor,
                  )),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 15,
                child: FadeInUp(
                  duration: const Duration(seconds: 1),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://firebasestorage.googleapis.com/v0/b/eczanedb.appspot.com/o/registericon%2Ficons8-close-window-96.png?alt=media&token=693d9742-cbaf-4ad6-87bc-a84baedb4e2d",
                    imageBuilder: (context, imageProvider) => SizedBox(
                      width: 135,
                      height: 135,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const CircularProgressIndicator(),
                    placeholder: (context, url) => LoadingAnimationWidget.beat(
                        color: themeMainColor.backgroundColor, size: 35),
                  ),
                ),
              ),
              Expanded(
                flex: 35,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      FadeInUp(
                        duration: const Duration(seconds: 1),
                        child: Text(
                          "E-mail Adresini Bulunamadı",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ubuntu(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInUp(
                        duration: const Duration(seconds: 1),
                        child: Text(
                          "Girmiş Olduğunuz E-mail Adresi Kayıtlarda Bulunamadı, Lütfen tekrar deneyiniz.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.black54,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInUp(
                        duration: const Duration(seconds: 1),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const forgotPassScreen(),
                                ),
                                (Route<dynamic> route) => false);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: themeMainColor.backgroundColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: Text(
                              "Tekrar Dene",
                              style: GoogleFonts.ubuntu(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
