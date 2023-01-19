import 'dart:io';
import 'package:eczanem/screens/login/login.dart';
import 'package:flutter/material.dart';

// pub dev
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

// routers page
import 'package:eczanem/theme_style/main_style.dart';
import 'package:eczanem/model/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: buildHome(),
  ));
}

// ignore: camel_case_types
class buildHome extends StatefulWidget {
  const buildHome({super.key});

  @override
  State<buildHome> createState() => _buildHomeState();
}

// ignore: camel_case_types
class _buildHomeState extends State<buildHome> {
  @override
  void initState() {
    super.initState();
    getCorumData();
  }

  final List<eczaneModel> eczanaList = [];
  bool getCorumLoading = false;

  Future getCorumData() async {
    setState(() {
      getCorumLoading = true;
    });
    var resUrl = await http
        .get(Uri.parse("https://www.corumeo.org.tr/nobetci-eczaneler"));
    final bodyCorum = resUrl.body;
    final documentCorum = parse(bodyCorum);
    // ignore: unused_local_variable
    final responseCorum = documentCorum
        .getElementsByClassName(" col-md-10 top-1")
        .forEach((element) {
      setState(() {
        eczanaList.add(
          eczaneModel(
            title: element.children[0].text.toString(),
            location: element.children[1].text.toString(),
            phone: '#',
          ),
        );
      });

      // nöbetçi eczane adları : element.children[0].text.toString()
      // detaylı bilgi : element.children[1].text.toString()
    });
    setState(() {
      getCorumLoading = false;
    });
  }

  var dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeMainColor.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Eczanem",
            style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                var alertExitDialog = AlertDialog(
                  content: SizedBox(
                    width: double.infinity,
                    height: context.dynamicHeight(0.3),
                    child: Column(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl:
                              "https://firebasestorage.googleapis.com/v0/b/eczanedb.appspot.com/o/exiticon%2Ficons8-logout-90.png?alt=media&token=78395be8-451d-40d7-8aa3-4c6eb78e68f8",
                          imageBuilder: (context, imageProvider) => SizedBox(
                            width: 90,
                            height: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
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
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Hesabınızdan Çıkışmı Yapmak İstiyorsunuz?",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: context.dynamicHeight(0.06),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () async {
                                    await FirebaseAuth.instance.signOut();
                                    FirebaseAuth.instance
                                        .userChanges()
                                        .listen((User? user) {
                                      if (user == null) {
                                        // ignore: avoid_print
                                        print('Kullanıcı çıkış Yaptı');
                                      } else {
                                        // ignore: avoid_print
                                        print('Hesaba Giriş Yapıldı');
                                      }
                                    });
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const userLoginScreen(),
                                        ),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    child: Text(
                                      "Evet",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    child: Text(
                                      "Hayır",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                showDialog(
                    context: context, builder: (context) => alertExitDialog);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 21,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            // title
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                // ignore: prefer_const_constructors
                margin: EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hoşgeldiniz \nÇorum ${dateTime.day}.${dateTime.month}.${dateTime.year} Tarihli Nöbetçi Eczane Listesi",
                  style: GoogleFonts.nunito(
                    textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
            // list 1
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: getCorumLoading
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: themeMainColor.backgroundColor, size: 25),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: eczanaList.length,
                        itemBuilder: (context, index) => SizedBox(
                          width: context.dynamicWidth(0.55),
                          height: context.dynamicHeight(0.22),
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 15, left: 15, bottom: 15),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.9),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Column(
                              children: <Widget>[
                                // icon
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // title
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: context.dynamicHeight(0.08),
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) => SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height:
                                                    context.dynamicHeight(0.4),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            width: 120,
                                                            height: 3,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              4)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      // body content
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: context
                                                            .dynamicHeight(
                                                                0.33),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Flexible(
                                                              fit:
                                                                  FlexFit.tight,
                                                              flex: 1,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  CachedNetworkImage(
                                                                    imageUrl:
                                                                        "https://www.corumeo.org.tr/images/epano.gif",
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const CircularProgressIndicator(),
                                                                    placeholder: (context,
                                                                            url) =>
                                                                        LoadingAnimationWidget.beat(
                                                                            color:
                                                                                themeMainColor.backgroundColor,
                                                                            size: 25),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  // title
                                                                  SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child: Text(
                                                                      eczanaList[
                                                                              index]
                                                                          .title,
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                        textStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .titleMedium!
                                                                            .copyWith(
                                                                              color: Colors.redAccent,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  // city location
                                                                  SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                          Icons
                                                                              .store,
                                                                          color:
                                                                              themeMainColor.backgroundColor,
                                                                          size:
                                                                              21,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                context.dynamicHeight(0.20),
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              child: Text(
                                                                                eczanaList[index].location,
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.nunito(
                                                                                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    },
                                    child: Text(
                                      eczanaList[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: context.dynamicHeight(0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ugulamadan Çıkmak İstediğinize Eminmisiniz?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(
                              // ignore: deprecated_member_use
                              primary: Colors.redAccent),
                          child: const Text("Evet"),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        // ignore: sort_child_properties_last
                        child: const Text("Hayır",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Colors.lightBlue,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
