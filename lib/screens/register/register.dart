import 'package:flutter/material.dart';

// pub dev
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:animate_do/animate_do.dart';
import 'package:eczanem/screens/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// routers page
import 'package:eczanem/theme_style/main_style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: registerScreen(),
  ));
}

// ignore: camel_case_types
class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

// ignore: camel_case_types
class _registerScreenState extends State<registerScreen> with regFormControl {
  Future regUser() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _userMail.value.text,
        password: _userPass.value.text,
      )
          .then((value) {
        throw FirebaseFirestore.instance
            .collection("registers")
            .doc(_userMail.text.toString())
            .set({
          "userNamedb": _userName.text.toString(),
          "userMaildb": _userMail.text.toString(),
          "userPassoworddb": _userPass.text.toString(),
        }).whenComplete(
          () {
            loggerinfo();

            // ignore: non_constant_identifier_names
            var RegInfo = AlertDialog(
              content: SizedBox(
                width: double.infinity,
                height: context.dynamicHeight(0.35),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      CachedNetworkImage(
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/eczanedb.appspot.com/o/registericon%2Ficons8-checkmark-144.png?alt=media&token=fc6f5e0b-e1c7-4336-8043-6e30cf774a9d",
                        imageBuilder: (context, imageProvider) => SizedBox(
                          width: 125,
                          height: 125,
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
                        placeholder: (context, url) =>
                            LoadingAnimationWidget.beat(
                                color: themeMainColor.backgroundColor,
                                size: 35),
                      ),
                      Text(
                        "Hesabınız Oluşturuldu",
                        style: GoogleFonts.ubuntu(
                          textStyle:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tebrikler, Hesabınız oluşturuldu, giriş yapabilirsiniz",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black54,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            showDialog(context: context, builder: (context) => RegInfo);
          },
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // ignore: non_constant_identifier_names
        var RegInfo = AlertDialog(
          content: SizedBox(
            width: double.infinity,
            height: context.dynamicHeight(0.35),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        "https://firebasestorage.googleapis.com/v0/b/eczanedb.appspot.com/o/registericon%2Ficons8-close-window-96.png?alt=media&token=693d9742-cbaf-4ad6-87bc-a84baedb4e2d",
                    imageBuilder: (context, imageProvider) => SizedBox(
                      width: 125,
                      height: 125,
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
                  Text(
                    "Hesab Oluşturulamadı!",
                    style: GoogleFonts.ubuntu(
                      textStyle:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.black,
                              ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${_userMail.text.toString()} Adına Hesap Zaten Kayıtlı Lütfen Başka E-mail Hesabı ile Kayıt Olunuz",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.black54,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        showDialog(context: context, builder: (context) => RegInfo);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _regFormKey,
        child: Padding(
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
                  // user name
                  _userNameinputWidget,
                  const SizedBox(
                    height: 15,
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
                  // login btn
                  _registerBtnWidget,

                  // register content
                  _loginBtnWidget,
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
              "Hesap Oluşturma",
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
              "Gerekli Bilgileri Girerek Hesabınızı Oluşturun",
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

  Widget get _userNameinputWidget => FadeInUp(
        duration: const Duration(milliseconds: 1050),
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
              controller: _userName,
              validator: userNameVal,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: 21,
                ),
                hintText: "Ad Soyad",
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

  Widget get _registerBtnWidget => FadeInUp(
        duration: const Duration(milliseconds: 2150),
        child: GestureDetector(
          onTap: () {
            if (_regFormKey.currentState!.validate()) {
              regUser();
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
                "Kayıt Ol",
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

  Widget get _loginBtnWidget => FadeInUp(
        duration: const Duration(milliseconds: 2250),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: context.dynamicHeight(0.1),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: <Widget>[
                Text(
                  "Hesabınız varmı?",
                  style: GoogleFonts.nunito(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const userLoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Giriş Yap",
                    style: GoogleFonts.nunito(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: themeMainColor.backgroundColor,
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
class regFormControl {
  // form key
  final _regFormKey = GlobalKey<FormState>();

  // ınput controller
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userMail = TextEditingController();
  final TextEditingController _userPass = TextEditingController();

  // logger
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  var loggerNotStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  void loggerinfo() {
    loggerNotStack.i("${_userMail.text.toString()} E-mail Adresi Kayıt Oldu");
  }

  // form validator

  // user name validator
  String? userNameVal(String? nameVal) {
    if (nameVal == null || nameVal.isEmpty) {
      return "* Zorunlu Alan";
    } else if (nameVal.length > 15) {
      return "* Adınız 15 Karakterden Küçük Olmalı";
    }
    return null;
  }

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
