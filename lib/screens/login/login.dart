import 'package:flutter/material.dart';

// pub dev
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

// routers page
import 'package:eczanem/screens/register/register.dart';
import 'package:eczanem/theme_style/main_style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:eczanem/screens/forgot_pass/forgot_pass.dart';
import 'package:eczanem/screens/login/loading_root.dart';

void main() async {
  runApp(const MaterialApp(
    home: userLoginScreen(),
  ));
}

// ignore: camel_case_types
class userLoginScreen extends StatefulWidget {
  const userLoginScreen({super.key});

  @override
  State<userLoginScreen> createState() => _userLoginScreenState();
}

// ignore: camel_case_types
class _userLoginScreenState extends State<userLoginScreen>
    with loginController {
  Future<void> logUser() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _userMail.text.toString(),
              password: _userPass.value.text.toString());
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const loadingRootScreen(),
          ),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: non_constant_identifier_names
        var RegInfo = AlertDialog(
          content: SizedBox(
            width: double.infinity,
            height: context.dynamicHeight(0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl:
                      "https://firebasestorage.googleapis.com/v0/b/eczanedb.appspot.com/o/registericon%2Ficons8-close-window-96.png?alt=media&token=693d9742-cbaf-4ad6-87bc-a84baedb4e2d",
                  imageBuilder: (context, imageProvider) => SizedBox(
                    width: 95,
                    height: 95,
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
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "E-mail Adresi Bulunamadı!",
                  style: GoogleFonts.ubuntu(
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "${_userMail.text.toString()} Adına Hesap Kayıtı Bulunamadı! Başka E-mail Adresi Giriniz.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
        showDialog(context: context, builder: (context) => RegInfo);
      } else if (e.code == 'wrong-password') {
        // ignore: non_constant_identifier_names
        var RegInfo = AlertDialog(
          content: SizedBox(
            width: double.infinity,
            height: context.dynamicHeight(0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl:
                      "https://firebasestorage.googleapis.com/v0/b/eczanedb.appspot.com/o/registericon%2Ficons8-lock-144.png?alt=media&token=aac20ded-b766-4e86-9715-943375640311",
                  imageBuilder: (context, imageProvider) => SizedBox(
                    width: 95,
                    height: 95,
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
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Kullanıcı Şifre Hatası!",
                  style: GoogleFonts.ubuntu(
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Girilen Kullanıcı Şifreniz Hatalıdır Lütfen Tekrar Deneyiniz veya Şifrenizi Sıfırlayınız!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
        showDialog(context: context, builder: (context) => RegInfo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _logFormKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // title text
                  _titleWidget,
                  SizedBox(
                    height: context.dynamicHeight(0.05),
                  ),
                  // email content
                  _emailinputWidget,
                  const SizedBox(
                    height: 15,
                  ),
                  // password content
                  _passinputWidget,
                  const SizedBox(
                    height: 15,
                  ),
                  // forgot pass btn
                  _forgotpassBtn,
                  const SizedBox(
                    height: 15,
                  ),
                  // login btn
                  _loginBtnWidget,
                  // register content
                  _registerBtnWidget,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _titleWidget => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // title
          FadeInUp(
            duration: const Duration(seconds: 1),
            child: Text(
              "Eczanem'e Hoşgeldiniz",
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // sub title
          FadeInUp(
            duration: const Duration(seconds: 2),
            child: Text(
              "Hesabınıza giriş yapınız",
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black54,
                    ),
              ),
            ),
          ),
        ],
      );

  Widget get _emailinputWidget => FadeInUp(
        duration: const Duration(milliseconds: 1250),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: context.dynamicHeight(0.08),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: TextFormField(
              controller: _userMail,
              validator: userMailVal,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.email,
                  color: Colors.grey,
                  size: 21,
                ),
                hintText: "E-mail Adresiniz",
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      );

  Widget get _passinputWidget => FadeInUp(
        duration: const Duration(milliseconds: 1500),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: context.dynamicHeight(0.08),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: TextFormField(
              controller: _userPass,
              validator: userPassVal,
              obscureText: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 21,
                ),
                hintText: "Şifreniz",
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      );

  Widget get _forgotpassBtn => FadeInUp(
        delay: const Duration(milliseconds: 1550),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const forgotPassScreen(),
                  ),
                );
              },
              child: Text(
                "Şifremi Unuttum",
                style: GoogleFonts.nunito(
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: themeMainColor.backgroundColor,
                      ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _loginBtnWidget => FadeInUp(
        duration: const Duration(milliseconds: 2150),
        child: GestureDetector(
          onTap: () {
            if (_logFormKey.currentState!.validate()) {
              logUser();
            }
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: context.dynamicHeight(0.075),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: themeMainColor.backgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: Text(
                "Giriş Yap",
                style: GoogleFonts.nunito(
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _registerBtnWidget => FadeInUp(
        duration: const Duration(milliseconds: 2250),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: context.dynamicHeight(0.1),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    "Henüz bir hesabınız yokmu?",
                    style: GoogleFonts.nunito(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.black54,
                              ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const registerScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Kayıt Ol",
                      style: GoogleFonts.nunito(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: themeMainColor.backgroundColor,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

// ignore: camel_case_types
class loginController {
  // controller
  final TextEditingController _userMail = TextEditingController();
  final TextEditingController _userPass = TextEditingController();

  // form key
  final _logFormKey = GlobalKey<FormState>();

  // form validator

  // user mail validator
  String? userMailVal(String? mailVal) {
    if (mailVal == null || mailVal.isEmpty) {
      return "* Zorunlu Alan";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(mailVal)) {
      return "* Geçersiz Email Adresi";
    }
    return null;
  }

  // user password validator
  String? userPassVal(String? passVal) {
    if (passVal == null || passVal.isEmpty) {
      return "* Zorunlu Alan";
    } else if (passVal.length < 8) {
      return "* Şifreniz 8 Karakter Üstü Olmalı";
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(passVal)) {
      return "* Şifrenizde (*,Büyük Harf,Sayı) Ekleyiniz";
    }
    return null;
  }
}
