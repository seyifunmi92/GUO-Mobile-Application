import 'dart:convert';
import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/models/categories.dart';
import 'package:guomobile/models/categoryid.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/logistics/summary.dart';
import 'package:guomobile/services/logisticsbloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../asset/imageclass.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/containers/container.dart';
import '../../hooks/formfields/formfields.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../hooks/text/text.dart';
import '../../providers/validations/validation.dart';

class InputSelections extends StatefulWidget {
  String? dispatchType;
  String? pickUpAddress;
  String? senderName;
  String? senderPhoneNumber;
  String? senderalternatephone;
  String? dropOffAddress;
  String? receiverName;
  String? receiverPhoneNumber;
  String? otherPhoneNumber;
  DateTime? scheduledDate;
  bool? isInstant;
  bool? isScheduled;
  bool? isflexibleschedule;

  InputSelections(
      {this.dispatchType,
      this.pickUpAddress,
      this.senderName,
      this.senderPhoneNumber,
      this.senderalternatephone,
      this.dropOffAddress,
      this.receiverName,
      this.receiverPhoneNumber,
      this.otherPhoneNumber,
      this.scheduledDate,
      this.isInstant,
      this.isScheduled,
      this.isflexibleschedule});

  @override
  State<InputSelections> createState() => _InputSelectionsState();
}

class _InputSelectionsState extends State<InputSelections> {
  TextEditingController quantityc = TextEditingController();
  TextEditingController weightc = TextEditingController();
  TextEditingController valuec = TextEditingController();
  TextEditingController categoryc = TextEditingController();
  TextEditingController subcategoryc = TextEditingController();
  TextEditingController widthc = TextEditingController();
  TextEditingController heightc = TextEditingController();
  TextEditingController descriptionc = TextEditingController();
  TextEditingController typec = TextEditingController();
  CategoriesList? xcategories;
  List<Datum>? xCategoriesList;
  bool isPerishable = false;
  bool isFragile = false;
  bool isBulky = false;
  bool isHeavy = false;
  bool luggagecheck = false;
  bool tandc = false;
  final ImagePicker xPicker = ImagePicker();
  File? image;
  XFile? photo;
  XFile? photo2;
  XFile? photo3;
  int pIndex = 0;
  CategorybyId? xCatId;
  String perish = "";
  String bulky = "";
  String fragile = "";
  String heavy = "";
  int categoryId = 0;
  int subCategoryid = 0;
  bool image1show = false;
  String categoryHint = "Select";
  String catidhint = "Select";
  bool isGallery = false;
  bool isCamera = false;
  bool uploadSuccess = false;
  bool uploadSuccess2 = false;
  bool uploadSuccess3 = false;
  @override
  void initState() {
    Provider.of<LogisticsBloc>(context, listen: false).isloading = true;
    print(widget.dispatchType);
    print(widget.dropOffAddress);
    print(widget.scheduledDate);
    print(widget.senderalternatephone);
    print(widget.otherPhoneNumber);
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<LogisticsBloc>(context, listen: false).isloading
        ? guoLoader()
        : Scaffold(
            backgroundColor: guocolor.offWhite,
            appBar: guoAppBar(context, "Input Selection"),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sbHeight(mqHeight(context, .02)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: mqWidth(context, .32),
                          child: dText(
                              "Kindly enter your details so we can match you with available dispatch rider.",
                              mqHeight(context, .018),
                              color: Color(0xff8C8C95)),
                        ),
                        dispatchCircle("100%", true),
                      ],
                    ),
                    sbHeight(mqHeight(context, .03)),
                    dText("Quantity of item", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    guoFormField(
                        context, mqHeight(context, .05), mqWidth(context, .5),
                        containercolor: guocolor.white,
                        showBorder: false,
                        showRadius: true,
                        radiusborder: true, onT: () {
                      setState(() {
                        Provider.of<ValidationBloc>(context, listen: false)
                            .validquantity = true;
                      });
                    },
                        isnext: true,
                        title: "1",
                        controller: quantityc,
                        isInt: true),
                    sbHeight(mqHeight(context, .005)),
                    !Provider.of<ValidationBloc>(context, listen: false)
                            .validquantity
                        ? dText("Quantity can not be empty",
                            mqHeight(context, .012),
                            color: guocolor.red.withOpacity(.7))
                        : dText("", 0),
                    sbHeight(mqHeight(context, .02)),
                    dText("Weight (kg)", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    guoFormField(
                        context, mqHeight(context, .05), mqWidth(context, .5),
                        containercolor: guocolor.white,
                        showBorder: false,
                        showRadius: true,
                        radiusborder: true, onT: () {
                      setState(() {
                        Provider.of<ValidationBloc>(context, listen: false)
                            .validweight = true;
                      });
                    },
                        isnext: true,
                        title: "20kg",
                        isInt: true,
                        controller: weightc),
                    sbHeight(mqHeight(context, .005)),
                    !Provider.of<ValidationBloc>(context, listen: false)
                            .validweight
                        ? dText(
                            "Weight can not be empty", mqHeight(context, .012),
                            color: guocolor.red.withOpacity(.7))
                        : dText("", 0),
                    sbHeight(mqHeight(context, .02)),
                    dText("Value in Naira", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    guoFormField(
                        context, mqHeight(context, .05), mqWidth(context, .5),
                        containercolor: guocolor.white,
                        showBorder: false,
                        showRadius: true,
                        radiusborder: true, onT: () {
                      setState(() {
                        Provider.of<ValidationBloc>(context, listen: false)
                            .validnaira = true;
                      });
                    },
                        isnext: true,
                        title: "N 200,000.00",
                        isInt: true,
                        controller: valuec),
                    sbHeight(mqHeight(context, .005)),
                    !Provider.of<ValidationBloc>(context, listen: false)
                            .validnaira
                        ? dText(
                            "Price can not be empty", mqHeight(context, .012),
                            color: guocolor.red.withOpacity(.7))
                        : dText("", 0),
                    sbHeight(mqHeight(context, .02)),
                    dText("Category (Multiple)", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    guoFormField(
                        context, mqHeight(context, .05), mqWidth(context, .5),
                        containercolor: guocolor.white,
                        showBorder: false,
                        showRadius: true,
                        isReadonly: true,
                        radiusborder: true, onT: () {
                      showCategoryDialog();
                      setState(() {
                        Provider.of<ValidationBloc>(context, listen: false)
                            .validcategory = true;
                      });
                    },
                        isnext: true,
                        title: categoryHint,
                        controller: categoryc),
                    sbHeight(mqHeight(context, .005)),
                    !Provider.of<ValidationBloc>(context, listen: false)
                            .validcategory
                        ? dText("Category can not be empty",
                            mqHeight(context, .012),
                            color: guocolor.red.withOpacity(.7))
                        : dText("", 0),
                    sbHeight(mqHeight(context, .02)),
                    dText("Sub Category", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    guoFormField(
                        context, mqHeight(context, .05), mqWidth(context, .5),
                        containercolor: guocolor.white,
                        showBorder: false,
                        showRadius: true,
                        isReadonly: true,
                        radiusborder: true, onT: () {
                      setState(() {
                        Provider.of<ValidationBloc>(context, listen: false)
                            .validsubcategory = true;
                      });
                    },
                        isnext: true,
                        title: catidhint,
                        controller: subcategoryc),
                    sbHeight(mqHeight(context, .005)),
                    !Provider.of<ValidationBloc>(context, listen: false)
                            .validsubcategory
                        ? dText("Sub catergory can not be empty",
                            mqHeight(context, .012),
                            color: guocolor.red.withOpacity(.7))
                        : dText("", 0),
                    sbHeight(mqHeight(context, .02)),
                    dText("Width (cm)", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    guoFormField(
                        context, mqHeight(context, .05), mqWidth(context, .5),
                        containercolor: guocolor.white,
                        showBorder: false,
                        showRadius: true,
                        radiusborder: true, onT: () {
                      setState(() {
                        Provider.of<ValidationBloc>(context, listen: false)
                            .validwidth = true;
                      });
                    }, isnext: true, title: "20cm", controller: widthc),
                    sbHeight(mqHeight(context, .005)),
                    !Provider.of<ValidationBloc>(context, listen: false)
                            .validwidth
                        ? dText(
                            "Width can not be empty", mqHeight(context, .012),
                            color: guocolor.red.withOpacity(.7))
                        : dText("", 0),
                    sbHeight(mqHeight(context, .02)),
                    dText("Height (cm)", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    guoFormField(
                        context, mqHeight(context, .05), mqWidth(context, .5),
                        containercolor: guocolor.white,
                        showBorder: false,
                        showRadius: true,
                        radiusborder: true, onT: () {
                      setState(() {
                        Provider.of<ValidationBloc>(context, listen: false)
                            .validheight = true;
                      });
                    }, isnext: true, title: "10cm", controller: heightc),
                    sbHeight(mqHeight(context, .005)),
                    !Provider.of<ValidationBloc>(context, listen: false)
                            .validheight
                        ? dText(
                            "Height can not be empty", mqHeight(context, .012),
                            color: guocolor.red.withOpacity(.7))
                        : dText("", 0),
                    sbHeight(mqHeight(context, .02)),
                    dText("Description", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    guoFormField(
                        context, mqHeight(context, .1), mqWidth(context, .5),
                        containercolor: guocolor.white,
                        showBorder: false,
                        showRadius: true,
                        radiusborder: true, onT: () {
                      setState(() {
                        Provider.of<ValidationBloc>(context, listen: false)
                            .validdescription = true;
                      });
                    }, isnext: true, title: "", controller: descriptionc),
                    sbHeight(mqHeight(context, .005)),
                    !Provider.of<ValidationBloc>(context, listen: false)
                            .validdescription
                        ? dText("Description can not be empty",
                            mqHeight(context, .012),
                            color: guocolor.red.withOpacity(.7))
                        : dText("", 0),
                    sbHeight(mqHeight(context, .02)),
                    dText("Add Image", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    Row(
                      children: [
                        shadowContainer(
                          context,
                          mqHeight(context, .1),
                          mqWidth(context, .1),
                          "",
                          () {
                            _callImage();
                          },
                          uploadSuccess ? false : true,
                          icon: Icons.camera_alt,
                          photopath: photo?.path ?? "",
                        ),
                        sbWidth(mqWidth(context, .02)),
                        shadowContainer(
                          context,
                          mqHeight(context, .1),
                          mqWidth(context, .1),
                          "",
                          () {
                            _callImage2();
                          },
                          uploadSuccess2 ? false : true,
                          icon: Icons.camera_alt,
                          photopath: photo2?.path ?? "",
                        ),
                        sbWidth(mqWidth(context, .02)),
                        shadowContainer(
                          context,
                          mqHeight(context, .1),
                          mqWidth(context, .1),
                          "",
                          () {
                            _callImage3();
                          },
                          uploadSuccess3 ? false : true,
                          icon: Icons.camera_alt,
                          photopath: photo3?.path ?? "",
                        ),
                      ],
                    ),
                    sbHeight(mqHeight(context, .04)),
                    dText("Choose Type (You can Select More Than one)",
                        mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .01)),
                    guoFormField(
                        context, mqHeight(context, .05), mqWidth(context, .5),
                        containercolor: guocolor.white,
                        showBorder: false,
                        showRadius: true,
                        isReadonly: true,
                        radiusborder: true, onT: () {
                      Provider.of<ProviderBloc>(context, listen: false)
                          .showType(context);
                      setState(() {});
                    }, isnext: false, title: "Select", controller: typec),
                    sbHeight(mqHeight(context, .04)),
                    Row(
                      children: [
                        boxTickradius(luggagecheck ? true : false,
                            BorderRadius.circular(20), onT: () {
                          checkluggage();
                        }),
                        sbWidth(mqWidth(context, .02)),
                        Container(
                            width: mqWidth(context, .37),
                            child: dText(
                                GuoText.logisticnotice, mqHeight(context, .015),
                                color: Color(0xff8C8C95))),
                      ],
                    ),
                    sbHeight(mqHeight(context, .04)),
                    Row(
                      children: [
                        boxTickradius(
                            tandc ? true : false, BorderRadius.circular(20),
                            onT: () {
                          checkTandC();
                        }),
                        sbWidth(mqWidth(context, .02)),
                        Container(
                            width: mqWidth(context, .37),
                            child: dText(GuoText.tc, mqHeight(context, .015),
                                color: Color(0xff8C8C95))),
                      ],
                    ),
                    sbHeight(mqHeight(context, .07)),
                    straightButton(
                      "Proceed",
                      mqHeight(context, .059),
                      mqWidth(context, .915),
                      guocolor.primaryColor,
                      8,
                      fontSize: mqHeight(context, .022),
                      fontColor: guocolor.white,
                      onT: () {
                        _runFunction();
                      },
                    ),
                    sbHeight(mqHeight(context, .1)),
                  ],
                ),
              ),
            ),
          );
  }

  _runFunction() {
    _checkstorage();
    _validateqty();
    _validateweight();
    _validatenaira();
    _validCategory();
    _validatesubcategory();
    _validateWidth();
    _validateHeight();
    _validateDescription();

    Provider.of<ValidationBloc>(context, listen: false).validquantity &&
            Provider.of<ValidationBloc>(context, listen: false).validweight &&
            Provider.of<ValidationBloc>(context, listen: false).validnaira &&
            Provider.of<ValidationBloc>(context, listen: false).validcategory &&
            Provider.of<ValidationBloc>(context, listen: false)
                .validsubcategory &&
            Provider.of<ValidationBloc>(context, listen: false).validwidth &&
            Provider.of<ValidationBloc>(context, listen: false).validheight &&
            Provider.of<ValidationBloc>(context, listen: false).validdescription
        ? mynextScreen(
            context,
            Summarys(
              dispatchType: widget.dispatchType,
              address: widget.pickUpAddress,
              dropOffAddress: widget.dropOffAddress,
              parcelWeight: int.parse(weightc.text),
              category: categoryId,
              photo1: photo?.path ?? "",
              photo2: photo2?.path ?? "",
              photo3: photo3?.path ?? "",
              quantity: quantityc.text,
              price: valuec.text,
              senderName: widget.senderName,
              senderPhone: widget.senderPhoneNumber,
              receiverName: widget.receiverName,
              receiverPhone: widget.receiverPhoneNumber,
              itemQuantity: int.parse(quantityc.text),
              itemWeight: int.parse(weightc.text),
              itemValue: int.parse(valuec.text),
              subCategory: subCategoryid,
              width: int.parse(widthc.text),
              height: int.parse(heightc.text),
              description: descriptionc.text,
              type: "$perish,$fragile,$bulky,$heavy",
              isInstant: widget.isInstant,
              isScheduled: widget.isScheduled,
              flexibleSchedule: widget.isflexibleschedule,
            ))
        : null;
  }

  _validateqty() {
    if (quantityc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validquantity =
            false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validquantity =
            true;
      });
    }
  }

  _validateweight() {
    if (weightc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validweight = false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validweight = true;
      });
    }
  }

  _validatenaira() {
    if (valuec.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validnaira = false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validnaira = true;
      });
    }
  }

  _validCategory() {
    if (categoryc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validcategory =
            false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validcategory =
            true;
      });
    }
  }

  _validatesubcategory() {
    if (subcategoryc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validsubcategory =
            false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validsubcategory =
            true;
      });
    }
  }

  _validateWidth() {
    if (widthc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validwidth = false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validwidth = true;
      });
    }
  }

  _validateHeight() {
    if (heightc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validheight = false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validheight = true;
      });
    }
  }

  _validateDescription() {
    if (descriptionc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validdescription =
            false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validdescription =
            true;
      });
    }
  }

  checkluggage() {
    if (!luggagecheck) {
      setState(() {
        luggagecheck = true;
      });
    } else {
      setState(() {
        luggagecheck = false;
      });
    }
  }

  checkTandC() {
    if (!tandc) {
      setState(() {
        tandc = true;
      });
    } else {
      setState(() {
        tandc = false;
      });
    }
  }

  _callImage() {
    Provider.of<ProviderBloc>(context, listen: false).showPicker(context, () {
      setState(() {
        isGallery = true;
        isCamera = false;
        _pickImage();
        closeAction(context);
      });
    }, () {
      setState(() {
        isCamera = true;
        isGallery = false;
        _pickImage();
        closeAction(context);
      });
    });
  }

  _callImage2() {
    Provider.of<ProviderBloc>(context, listen: false).showPicker(context, () {
      setState(() {
        isGallery = true;
        isCamera = false;
        _pickImage2();
        closeAction(context);
      });
    }, () {
      setState(() {
        isCamera = true;
        isGallery = false;
        _pickImage2();
        closeAction(context);
      });
    });
  }

  _callImage3() {
    Provider.of<ProviderBloc>(context, listen: false).showPicker(context, () {
      setState(() {
        isGallery = true;
        isCamera = false;
        _pickImage3();
        closeAction(context);
      });
    }, () {
      setState(() {
        isCamera = true;
        isGallery = false;
        _pickImage3();
        closeAction(context);
      });
    });
  }

  _pickImage() async {
    var myphoto = await xPicker.pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera);
    if (myphoto != null) {
      setState(() {
        photo = myphoto;
        uploadSuccess = true;
      });
    }
  }

  _pickImage2() async {
    print(isCamera);
    print(isGallery);
    var myphoto = await xPicker.pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera);
    if (myphoto != null) {
      setState(() {
        photo2 = myphoto;
        uploadSuccess2 = true;
      });
    }
  }

  _pickImage3() async {
    print(isCamera);
    print(isGallery);
    var myphoto = await xPicker.pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera);
    if (myphoto != null) {
      setState(() {
        photo3 = myphoto;
        uploadSuccess3 = true;
      });
    }
  }

  _getCategories() {
    Provider.of<LogisticsBloc>(context, listen: false)
        .getCategories()
        .then((value) => categoriesx(value));
  }

  _getCategoriebyId() {
    Provider.of<LogisticsBloc>(context, listen: false)
        .getCategoriesbyid(categoryId)
        .then((value) => categoriesxid(value));
  }

  categoriesx(String x) {
    var xC = jsonDecode(x);
    if (xC["status"] == 200) {
      List catList = xC["data"];
      setState(() {
        xCategoriesList =
            catList.map<Datum>((xx) => Datum.fromJson(xx)).toList();
        xcategories = CategoriesList.fromJson(xC);
        Provider.of<LogisticsBloc>(context, listen: false).isloading = false;
        toast(xC["message"]);
      });
    } else {
      setState(() {
        Provider.of<LogisticsBloc>(context, listen: false).isloading = false;
      });
      toast(xC["message"]);
    }
  }

  categoriesxid(String x) {
    var xC = jsonDecode(x);
    if (xC["status"] == 200) {
      setState(() {
        xCatId = CategorybyId.fromJson(xC);
        subcategoryc.text = xCatId!.data.name;
        subCategoryid = xCatId!.data.categoryId;
        Provider.of<LogisticsBloc>(context, listen: false).isloading = false;
        toast(xC["message"]);
      });
    } else {
      setState(() {
        Provider.of<LogisticsBloc>(context, listen: false).isloading = false;
      });
      toast(xC["message"]);
    }
  }

  showCategoryDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: Curves.bounceOut.transform(a1.value),
          child: catCard(),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }

  Widget catCard() {
    return Scaffold(
      backgroundColor: guocolor.transparent,
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Container(
          height: mqHeight(context, .4),
          width: mqWidth(context, 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: guocolor.white,
          ),
          child: Column(
            children: [
              sbHeight(mqHeight(context, .02)),
              dText("Select Categories", mqHeight(context, .02),
                  color: guocolor.black, fontweight: FontWeight.w700),
              sbHeight(mqHeight(context, .05)),
              ...xCategoriesList!.map((e) => listx(e)),
              sbHeight(mqHeight(context, .03)),
              straightButton("Close", mqHeight(context, .05),
                  mqWidth(context, .1), guocolor.primaryColor, 10,
                  fontColor: guocolor.white, onT: () {
                closeAction(context);
              }),
            ],
          ),
        ),
      )),
    );
  }

  Widget listx(Datum xData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .05)),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  categoryc.text = xData.name;
                  categoryId = xData.id;
                  _getCategoriebyId();

                  closeAction(context);
                });
              },
              child: dText(xData.name, mqHeight(context, .02))),
          sbHeight(mqHeight(context, .02)),
          DottedLine(
            dashColor: guocolor.black.withOpacity(.2),
          ),
          sbHeight(mqHeight(context, .02)),
        ],
      ),
    );
  }

  Widget subcatCard() {
    return Scaffold(
      backgroundColor: guocolor.transparent,
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Container(
          height: mqHeight(context, .4),
          width: mqWidth(context, 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: guocolor.white,
          ),
          child: Column(
            children: [
              sbHeight(mqHeight(context, .02)),
              dText("Select Categories", mqHeight(context, .02),
                  color: guocolor.black, fontweight: FontWeight.w700),
              sbHeight(mqHeight(context, .05)),
              ...xCategoriesList!.map((e) => listx(e)),
              sbHeight(mqHeight(context, .03)),
              straightButton("Close", mqHeight(context, .05),
                  mqWidth(context, .1), guocolor.primaryColor, 10,
                  fontColor: guocolor.white, onT: () {
                closeAction(context);
              }),
            ],
          ),
        ),
      )),
    );
  }

  _checkstorage() {
    getBoolP();
    getBoolBulky();
    getBoolFragile();
    getBoolHeavy();
  }

  getBoolP() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var p = _shared.getBool("isPerishable");
    setState(() {
      isPerishable = p!;
    });

    if (isPerishable = true) {
      setState(() {
        perish = "Perishable";
      });
    }
  }

  getBoolBulky() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var p = _shared.getBool("isBulky");
    setState(() {
      isBulky = p!;
    });
    if (isBulky = true) {
      setState(() {
        bulky = "Bulky";
      });
    }
  }

  getBoolHeavy() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var p = _shared.getBool("isHeavy");
    setState(() {
      isHeavy = p!;
    });
    if (isHeavy = true) {
      setState(() {
        heavy = "Heavy";
      });
    }
  }

  getBoolFragile() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var p = _shared.getBool("isFragile");
    setState(() {
      isFragile = p!;
    });

    if (isFragile = true) {
      setState(() {
        fragile = "Perishable";
      });
    }
  }
}
