import 'dart:convert';
import 'dart:io';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/models/userdata.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/profile/profilesuccess.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hooks/formfields/formfields.dart';
import '../../providers/sharedstorage/localstorage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  imageFunction() {
    if (photo != null) {
      photoShow = true;
    } else {
      photoShow = false;
    }
  }

  final ImagePicker xPicker = ImagePicker();
  File? image;
  XFile? photo;
  bool photoShow = false;
  String name = "Anayo Obiajulu";
  bool isGallery = false;
  bool isCamera = false;
  String base64Photo = "";
  int xId = 0;
  bool uploadSuccess = false;
  String firstname = "";
  String lastname = "";
  String email = "";
  String phonex = "";
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  String imageLink = "";
  UserData? xUser;

  @override
  void initState() {
    getCstData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageFunction();
    return Scaffold(
      appBar: guoAppBar(context, "Profile", showBack: false),
      body: xUser == null
          ? Loaderx(ImageClass.loader)
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
              child: SingleChildScrollView(
                child: Column(children: [
                  sbHeight(mqHeight(context, .1)),
                  Center(
                      child: Stack(children: [
                    photoShow && uploadSuccess
                        ? InkWell(
                            onTap: () {
                              _call();
                            },
                            child: CircleAvatar(
                              radius: 38,
                              backgroundImage: NetworkImage(imageLink),
                              child: Icon(Icons.camera_alt_sharp),
                            ),
                          )
                        : xUser?.data.user.profileImage != null
                            ? InkWell(
                                onTap: () {
                                  _call();
                                },
                                child: CircleAvatar(
                                  radius: 38,
                                  backgroundImage: NetworkImage(
                                      xUser!.data.user.profileImage),
                                  child: Icon(Icons.camera_alt_sharp),
                                ),
                              )
                            : profileCard(context, false, ImageClass.download,
                                () {
                                _call();
                              }),
                  ])),
                  sbHeight(mqHeight(context, .015)),
                  dText(firstname + " " + lastname, mqHeight(context, .024),
                      fontweight: FontWeight.w700, letterSpacing: .04),
                  sbHeight(mqHeight(context, .005)),
                  dText(email, mqHeight(context, .017),
                      color: guocolor.primaryColor, letterSpacing: .15),
                  sbHeight(mqHeight(context, .05)),
                  Row(
                    children: [
                      dText("First Name", mqHeight(context, .018),
                          color: guocolor.black, letterSpacing: .15),
                    ],
                  ),
                  sbHeight(mqHeight(context, .01)),
                  guoFormField(
                      context, mqHeight(context, .05), mqWidth(context, .5),
                      containercolor: guocolor.white,
                      showBorder: false,
                      showRadius: true,
                      radiusborder: true, onT: () {
                    setState(() {});
                  }, controller: firstNameC, title: firstname),
                  sbHeight(mqHeight(context, .025)),
                  Row(
                    children: [
                      dText("Last Name", mqHeight(context, .018),
                          color: guocolor.black, letterSpacing: .15),
                    ],
                  ),
                  sbHeight(mqHeight(context, .01)),
                  guoFormField(
                      context, mqHeight(context, .05), mqWidth(context, .5),
                      containercolor: guocolor.white,
                      showBorder: false,
                      showRadius: true,
                      radiusborder: true, onT: () {
                    setState(() {});
                  }, controller: lastNameC, title: lastname),
                  sbHeight(mqHeight(context, .025)),
                  Row(
                    children: [
                      dText("Email", mqHeight(context, .018),
                          color: guocolor.black, letterSpacing: .15),
                    ],
                  ),
                  sbHeight(mqHeight(context, .01)),
                  guoFormField(
                      context, mqHeight(context, .05), mqWidth(context, .5),
                      containercolor: guocolor.white,
                      showBorder: false,
                      showRadius: true,
                      radiusborder: true, onT: () {
                    setState(() {});
                  }, controller: emailC, title: email),
                  sbHeight(mqHeight(context, .025)),
                  Row(
                    children: [
                      dText("Phone Number", mqHeight(context, .018),
                          color: guocolor.black, letterSpacing: .15),
                    ],
                  ),
                  sbHeight(mqHeight(context, .01)),
                  guoFormField(
                      context, mqHeight(context, .05), mqWidth(context, .5),
                      containercolor: guocolor.white,
                      showBorder: false,
                      showRadius: true,
                      radiusborder: true, onT: () {
                    setState(() {});
                  }, controller: phoneNumberC, title: phonex),
                ]),
              ),
            ),
      bottomNavigationBar: xUser == null
          ? null
          : bottomNavwithbutton(context, () {
              _runupdate();
            }, "Update"),
    );
  }

  _pickImage() async {
    print(isGallery);
    var myphoto = await xPicker.pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera);
    if (myphoto != null) {
      setState(() {
        photo = myphoto;
      });
    }
    photo != null ? _runFunction() : null;
    //  tobase64(photo!);
  }

  _call() {
    Provider.of<ProviderBloc>(context, listen: false).showPicker(context, () {
      print("gallery");
      setState(() {
        isGallery = true;
        base64Photo = "";
        _pickImage();
        closeAction(context);
      });
    }, () {
      print("camera");
      setState(() {
        isCamera = true;
        base64Photo = "";
        _pickImage();
        closeAction(context);
      });
    });
  }

  tobase64(XFile x) {
    final xbytes = File(x.path).readAsBytesSync();
    setState(() {
      base64Photo = base64Encode(xbytes);
    });
    print(base64Photo);
    base64Photo != "" ? _runFunction() : null;
  }

  getCstId() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var cst = _shared.getInt("id");
    setState(() {
      xId = cst!;
    });
    print("$xId - seyyy");
    getCustomerDetails();
  }

  _runFunction() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    });
    _loader();
    postImage();
  }

  _runupdate() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    });
    _loader();
    _updateUser();
  }

  _updateUser() {
    Provider.of<AccountBloc>(context, listen: false)
        .updateData(
            firstNameC.text.isEmpty ? firstname : firstNameC.text,
            lastNameC.text.isEmpty ? lastname : lastNameC.text,
            phoneNumberC.text.isEmpty ? phonex : phoneNumberC.text,
            emailC.text.isEmpty ? email : emailC.text)
        .then((value) => xUpdate(value));
  }

  xUpdate(String x) {
    var body = jsonDecode(x);
    if (body["status"] == 200) {
      setState(() {});
      closeAction(context);
      Provider.of<LocalStorageBloc>(context, listen: false)
          .setFirstname(body["data"]["firstName"]);
      Provider.of<LocalStorageBloc>(context, listen: false)
          .getLastname(body["data"]["lastName"]);
      Provider.of<LocalStorageBloc>(context, listen: false)
          .getEmail(body["data"]["email"]);
      Provider.of<LocalStorageBloc>(context, listen: false)
          .getPhone(body["data"]["phoneNumber"]);
      mynextScreen(context, PSuccess());
    } else {
      closeAction(context);
      toast(body["message"]);
    }
  }

  _loader() {
    if (Provider.of<AccountBloc>(context, listen: false).isLoading) {
      Provider.of<ProviderBloc>(context, listen: false)
          .showAnimatedLoader(context, ImageClass.loader);
    }
  }

  postImage() {
    Provider.of<AccountBloc>(context, listen: false)
        .mpath(xId, photo!.path)
        .then((value) => mOutput(value));
  }

  mOutput(String x) async {
    print(x);
    var bodyT = jsonDecode(x);
    print(bodyT);
    if (bodyT["status"] == 200) {
      setState(() {
        uploadSuccess = true;
        imageLink = bodyT["data"]["profileImage"];
      });
      closeAction(context);
      toast(bodyT["message"]);
    } else {
      setState(() {
        setState(() {
          uploadSuccess = false;
        });
      });
    }
  }

  outputData(String xValue) {
    print(xValue);
    var xD = jsonDecode(xValue);
    if (xD["status"] == 200) {
      setState(() {
        uploadSuccess = true;
      });
      closeAction(context);
      toast(xD["message"]);
    } else {
      setState(() {});
      closeAction(context);
      toast(xD["message"]);
    }
  }

  getFirstname() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var fname = _shared.getString("firstname");
    setState(() {
      firstname = fname!;
    });
    print(firstname);
  }

  getLastname() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var lname = _shared.getString("lastname");
    setState(() {
      lastname = lname!;
    });
    print(lastname);
  }

  getEmail() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var xmail = _shared.getString("email");
    setState(() {
      email = xmail!;
    });
    print(email);
  }

  getNumber() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var phoneNumber = _shared.getString("phone");
    setState(() {
      phonex = phoneNumber!;
    });
    print(phonex);
  }

  getCstData() {
    getCstId();
    print(xId);
    getEmail();
    getFirstname();
    getLastname();
    getNumber();
  }

  getCustomerDetails() {
    print("araaaaa $xId");
    Provider.of<AccountBloc>(context, listen: false)
        .getUser(xId)
        .then((value) => xdetails(value));
  }

  xdetails(String x) {
    var xData1 = jsonDecode(x);
    if (xData1["status"] == 200) {
      setState(() {
        xUser = UserData.fromJson(xData1);
        uploadSuccess = true;
      });
    } else {
      setState(() {});
    }
  }
}
