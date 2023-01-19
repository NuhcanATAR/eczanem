import 'package:eczanem/screens/forgot_pass/forgot_emailerror.dart';
import 'package:eczanem/screens/forgot_pass/forgot_passmsg.dart';
import 'package:eczanem/theme_style/main_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// pub dev
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: forgotPassScreen(),
  ));
}

// ignore: camel_case_types
class forgotPassScreen extends StatefulWidget {
  const forgotPassScreen({super.key});

  @override
  State<forgotPassScreen> createState() => _forgotPassScreenState();
}

// ignore: camel_case_types
class _forgotPassScreenState extends State<forgotPassScreen>
    with resPassControl {
  Future<void> senResMail() async {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: _userMail.text.toString())
        .then((value) => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const forgotPasswordRouteLoadingScreen()),
                  (Route<dynamic> route) => false),
            })
        .catchError((e) => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const forgotRouterErrorEmailLoading()),
                  (Route<dynamic> route) => false),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeMainColor.backgroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Şifremi Unuttum",
          style: GoogleFonts.nunito(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: themeMainColor.backgroundColor,
                ),
          ),
        ),
      ),
      body: Form(
        key: _resFormKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              // title text
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Şifrenizimi Unuttunuz?",
                  style: GoogleFonts.nunito(
                    textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // sub title
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Hesabınza Kayıt E-mail Adresinizi Girerek Şifrenizi Güncelleyebilirsiniz.",
                  style: GoogleFonts.nunito(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // e-mail input
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: context.dynamicHeight(0.08),
                child: Container(
                  alignment: Alignment.center,
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
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
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
              const SizedBox(
                height: 15,
              ),
              // res button
              GestureDetector(
                onTap: () {
                  if (_resFormKey.currentState!.validate()) {
                    senResMail();
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
                      "Şifre Sıfırla",
                      style: GoogleFonts.nunito(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
}

// ignore: camel_case_types
class resPassControl {
  // controller
  final TextEditingController _userMail = TextEditingController();

  // form key
  final _resFormKey = GlobalKey<FormState>();

  // user mail validator
  String? userMailVal(String? mailVal) {
    if (mailVal == null || mailVal.isEmpty) {
      return "* Zorunlu Alan";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(mailVal)) {
      return "* Geçersiz Email Adresi";
    }
    return null;
  }
}
