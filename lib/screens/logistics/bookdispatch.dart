import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/validations/validation.dart';
import 'package:guomobile/screens/logistics/inputselections.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/formfields/formfields.dart';
import '../../hooks/layout/mediaqueries.dart';

class BookDispatch extends StatefulWidget {
  const BookDispatch({super.key});

  @override
  State<BookDispatch> createState() => _BookDispatchState();
}

class _BookDispatchState extends State<BookDispatch> {
  DateTime selectedDeliveryDate = DateTime.now();
  DateTime selectedPickupDate = DateTime.now();

  bool isSelectDate = false;
  bool isSelectDatePickup = false;
  String finalDate = "";
  bool isDoortodoor = false;
  String finalDatePickUp = "";
  bool doorSelelcted = false;
  bool terminalselected = false;
  bool isexpress = false;
  bool isschedule = false;
  bool showAlternatePhone2 = false;
  bool showAlternatePhone = false;
  bool flexibleDate = false;
  String validationmessage = "";
  String phoneValidationmessge = "";
  String phoneValidationmessge2 = "";
  String emailValidation = "";
  TextEditingController pickupTerminalc = TextEditingController();
  TextEditingController pickupstatec = TextEditingController();
  TextEditingController sendernamec = TextEditingController();
  TextEditingController xEmail = TextEditingController();
  TextEditingController senderphonec = TextEditingController();
  TextEditingController addressc = TextEditingController();
  TextEditingController daddressc = TextEditingController();
  TextEditingController cityc = TextEditingController();
  TextEditingController receiverc = TextEditingController();
  TextEditingController realternatephonec = TextEditingController();
  TextEditingController sealternatephonec = TextEditingController();
  TextEditingController receiverphonec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Book Dispatch"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            sbHeight(mqHeight(context, .02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: mqWidth(context, .32),
                  child: dText(
                      "Kindly enter your details  so we can match you with available dispatch rider.",
                      mqHeight(context, .018),
                      color: Color(0xff8C8C95)),
                ),
                dispatchCircle("0", false),
              ],
            ),
            sbHeight(mqHeight(context, .015)),
            dText("Dispatch Type", mqHeight(context, .02)),
            sbHeight(mqHeight(context, .015)),
            Row(children: [
              Column(
                children: [
                  dispatchCircleHome(
                      !doorSelelcted
                          ? Color(0xff8C8C95)
                          : guocolor.primaryColor,
                      Icons.door_back_door,
                      iconcolor: !doorSelelcted
                          ? Color(0xff8C8C95)
                          : guocolor.primaryColor, onT: () {
                    setState(() {
                      doorSelelcted = true;
                      terminalselected = false;
                    });
                  }),
                  sbHeight(mqHeight(context, .01)),
                  dText("Door To Door", mqHeight(context, .015),
                      color: !doorSelelcted
                          ? Color(0xff8C8C95)
                          : guocolor.primaryColor),
                ],
              ),
              sbWidth(mqWidth(context, .03)),
              Column(
                children: [
                  dispatchCircleHome(
                      terminalselected
                          ? guocolor.primaryColor
                          : Color(0xff8C8C95),
                      Icons.terminal,
                      iconcolor: terminalselected
                          ? guocolor.primaryColor
                          : Color(0xff8C8C95), onT: () {
                    setState(() {
                      doorSelelcted = false;
                      terminalselected = true;
                    });
                  }),
                  sbHeight(mqHeight(context, .01)),
                  dText("Terminal Pick Up", mqHeight(context, .015),
                      color: terminalselected
                          ? guocolor.primaryColor
                          : Color(0xff8C8C95)),
                ],
              )
            ]),
            sbHeight(mqHeight(context, .07)),
            dText(
                doorSelelcted
                    ? "Enter Pick-up Address"
                    : "Enter Pick-up Terminal",
                mqHeight(context, .018)),
            sbHeight(mqHeight(context, .01)),
            guoFormField(
              context,
              mqHeight(context, .05),
              mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              radiusborder: true,
              onT: () {
                setState(() {
                  Provider.of<ValidationBloc>(context, listen: false)
                      .validPickupTerminal = true;
                });
              },
              isnext: true,
              title: "Ikeja Terminal",
              controller: pickupTerminalc,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false)
                    .validPickupTerminal
                ? dText(validationmessage, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .02)),
            dText(
                doorSelelcted ? "Nearest Landmark" : "Enter Pick-up City/State",
                mqHeight(context, .018)),
            sbHeight(mqHeight(context, .01)),
            guoFormField(
              context,
              mqHeight(context, .05),
              mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              radiusborder: true,
              onT: () {
                setState(() {
                  setState(() {
                    Provider.of<ValidationBloc>(context, listen: false)
                        .validPickupcity = true;
                  });
                });
              },
              isnext: true,
              title: "Select",
              controller: pickupstatec,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false)
                    .validPickupTerminal
                ? dText(validationmessage, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .02)),
            dText("Sender Name", mqHeight(context, .018)),
            sbHeight(mqHeight(context, .01)),
            guoFormField(
              context,
              mqHeight(context, .05),
              mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              radiusborder: true,
              onT: () {
                setState(() {
                  Provider.of<ValidationBloc>(context, listen: false)
                      .validsendername = true;
                });
              },
              isnext: true,
              title: "Oluwaseyi",
              controller: sendernamec,
            ),
            sbHeight(mqHeight(context, .02)),
            dText("Sender Email", mqHeight(context, .018)),
            sbHeight(mqHeight(context, .01)),
            guoFormField(
              context,
              mqHeight(context, .05),
              mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              radiusborder: true,
              onT: () {
                setState(() {
                  Provider.of<ValidationBloc>(context, listen: false)
                      .validEmail = true;
                });
              },
              isnext: true,
              title: "Oluwaseyi@nerdbug.io",
              controller: xEmail,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validEmail
                ? dText(emailValidation, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .02)),
            dText("Sender Phone Number", mqHeight(context, .018)),
            sbHeight(mqHeight(context, .01)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              setState(() {
                Provider.of<ValidationBloc>(context, listen: false)
                    .validsenderphone = true;
              });
            },
                isnext: true,
                isInt: true,
                title: "+2348137330706",
                controller: senderphonec),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false)
                    .validsenderphone
                ? dText(phoneValidationmessge, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .014)),
            InkWell(
              onTap: () {
                if (!showAlternatePhone) {
                  setState(() {
                    showAlternatePhone = true;
                  });
                } else {
                  setState(() {
                    showAlternatePhone = false;
                  });
                }
              },
              child: dText(
                  showAlternatePhone
                      ? "-remove alternate phone number"
                      : "+add alternate phone number",
                  mqHeight(context, .013),
                  color: guocolor.black.withOpacity(.4),
                  letterSpacing: .3),
            ),
            sbHeight(mqHeight(context, .01)),
            showAlternatePhone ? alternatePhoneCustom2() : emptyString(),
            sbHeight(mqHeight(context, .02)),
            dText("Enter Drop-off Adress", mqHeight(context, .018)),
            sbHeight(mqHeight(context, .01)),
            guoFormField(
              context,
              mqHeight(context, .05),
              mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              radiusborder: true,
              onT: () {
                setState(() {
                  Provider.of<ValidationBloc>(context, listen: false)
                      .validaddress = true;
                });
              },
              isnext: true,
              title: "15, Gbenga ogunleye Lagos",
              controller: daddressc,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validaddress
                ? dText(validationmessage, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .02)),
            dText("Enter Drop-off City/State", mqHeight(context, .018)),
            sbHeight(mqHeight(context, .01)),
            guoFormField(
              context,
              mqHeight(context, .05),
              mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              radiusborder: true,
              onT: () {
                setState(() {
                  Provider.of<ValidationBloc>(context, listen: false)
                      .validcity = true;
                });
              },
              isnext: true,
              title: "Ikotun,Lagos",
              controller: cityc,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validcity
                ? dText(validationmessage, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .02)),
            dText("Receiver's Name", mqHeight(context, .018)),
            sbHeight(mqHeight(context, .01)),
            guoFormField(
              context,
              mqHeight(context, .05),
              mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              radiusborder: true,
              onT: () {
                setState(() {
                  Provider.of<ValidationBloc>(context, listen: false)
                      .validreceivername = true;
                });
              },
              isnext: false,
              title: "Aderonke Fatunmole",
              controller: receiverc,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false)
                    .validreceivername
                ? dText(validationmessage, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .02)),
            dText("Receivers Phone Number", mqHeight(context, .018)),
            sbHeight(mqHeight(context, .01)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              setState(() {
                Provider.of<ValidationBloc>(context, listen: false)
                    .validreceiverphone = true;
              });
            },
                isnext: true,
                isInt: true,
                title: "Ikotun,Lagos",
                controller: receiverphonec),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false)
                    .validreceiverphone
                ? dText(phoneValidationmessge2, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .014)),
            InkWell(
              onTap: () {
                if (!showAlternatePhone2) {
                  setState(() {
                    showAlternatePhone2 = true;
                  });
                } else {
                  setState(() {
                    showAlternatePhone2 = false;
                  });
                }
              },
              child: dText(
                  showAlternatePhone2
                      ? "-remove alternate phone number"
                      : "+add alternate phone number",
                  mqHeight(context, .013),
                  color: guocolor.primaryColor.withOpacity(.8),
                  letterSpacing: .3),
            ),
            sbHeight(mqHeight(context, .01)),
            showAlternatePhone2 ? alternatePhoneCustom() : emptyString(),
            isschedule && isSelectDate ? _dateCustom() : emptyString(),
            sbHeight(mqHeight(context, .01)),
            isschedule && isSelectDate ? _pickupDateCustom() : emptyString(),
            isschedule ? sbHeight(mqHeight(context, .02)) : sbHeight(0),
            Row(
              children: [
                tickCircle(isexpress ? true : false, onT: () {
                  setState(() {
                    isSelectDate = false;
                    isexpress = true;
                    isschedule = false;
                  });
                }),
                sbWidth(mqWidth(context, .01)),
                dText("Express", mqHeight(context, .016)),
                sbWidth(mqWidth(context, .032)),
                tickCircle(isschedule ? true : false, onT: () {
                  setState(() {
                    isexpress = false;
                    isschedule = true;
                  });
                  _selectDeliveryDate(context);
                }),
                sbWidth(mqWidth(context, .01)),
                dText("Scheduled", mqHeight(context, .016),
                    color: guocolor.primaryColor),
              ],
            ),
            sbHeight(mqHeight(context, .023)),
            Row(
              children: [
                boxTick(flexibleDate ? true : false, onT: () {
                  if (!flexibleDate) {
                    setState(() {
                      flexibleDate = true;
                    });
                  } else {
                    setState(() {
                      flexibleDate = false;
                    });
                  }
                }),
                sbWidth(mqWidth(context, .01)),
                dText("My date and time are flexible", mqHeight(context, .016)),
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
                _runProceed();
              },
            ),
            sbHeight(mqHeight(context, .1)),
          ]),
        ),
      ),
    );
  }

  Widget _pickupDateCustom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeight(mqHeight(context, .02)),
        dText("PickUpDate", mqHeight(context, .018)),
        sbHeight(mqHeight(context, .01)),
        guoFormField(
          context,
          mqHeight(context, .05),
          mqWidth(context, .5),
          containercolor: guocolor.white,
          showBorder: false,
          showRadius: true,
          isReadonly: true,
          radiusborder: true,
          onT: () {
            setState(() {
              _selectPickUpDate(context);
            });
          },
          isnext: true,
          isInt: true,
          title: finalDatePickUp,
        ),
      ],
    );
  }

  Widget _dateCustom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeight(mqHeight(context, .02)),
        dText("Scheduled Delivery Date", mqHeight(context, .018)),
        sbHeight(mqHeight(context, .01)),
        guoFormField(
          context,
          mqHeight(context, .05),
          mqWidth(context, .5),
          containercolor: guocolor.white,
          showBorder: false,
          showRadius: true,
          isReadonly: true,
          radiusborder: true,
          onT: () {
            setState(() {
              _selectDeliveryDate(context);
            });
          },
          isnext: true,
          isInt: true,
          title: finalDate,
        ),
      ],
    );
  }

  Widget alternatePhoneCustom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeight(mqHeight(context, .02)),
        dText("Receiver Alternate Phone Number", mqHeight(context, .018)),
        sbHeight(mqHeight(context, .01)),
        guoFormField(
          context,
          mqHeight(context, .05),
          mqWidth(context, .5),
          containercolor: guocolor.white,
          showBorder: false,
          showRadius: true,
          radiusborder: true,
          onT: () {},
          isnext: true,
          isInt: true,
          title: "+2348188339933",
          controller: sealternatephonec,
        ),
      ],
    );
  }

  Widget alternatePhoneCustom2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeight(mqHeight(context, .02)),
        dText("Sender Alternate Phone Number", mqHeight(context, .018)),
        sbHeight(mqHeight(context, .01)),
        guoFormField(
          context,
          mqHeight(context, .05),
          mqWidth(context, .5),
          containercolor: guocolor.white,
          showBorder: false,
          showRadius: true,
          radiusborder: true,
          onT: () {},
          isnext: true,
          isInt: true,
          title: "+2348188339933",
          controller: realternatephonec,
        ),
      ],
    );
  }

  _runProceed() {
    _validatePickUp();
    _validatePickUpCity();
    _validatesendername();
    _validatesendersPhone();
    _validatedropoffaddress();
    _validatedropoffcity();
    _validatereceivername();
    _validatereceiversPhone();
    _validationEmail();

    Provider.of<ValidationBloc>(context, listen: false).validPickupTerminal &&
            Provider.of<ValidationBloc>(context, listen: false)
                .validPickupcity &&
            Provider.of<ValidationBloc>(context, listen: false)
                .validsendername &&
            Provider.of<ValidationBloc>(context, listen: false)
                .validsenderphone &&
            Provider.of<ValidationBloc>(context, listen: false).validaddress &&
            Provider.of<ValidationBloc>(context, listen: false).validcity &&
            Provider.of<ValidationBloc>(context, listen: false)
                .validreceivername &&
            Provider.of<ValidationBloc>(context, listen: false)
                .validreceiverphone &&
            Provider.of<ValidationBloc>(context, listen: false).validEmail
        ? mynextScreen(
            context,
            InputSelections(
              dispatchType: doorSelelcted ? "doortodoor" : "TerminalPickUp",
              pickUpAddress: pickupTerminalc.text,
              senderName: sendernamec.text,
              senderPhoneNumber: senderphonec.text,
              senderalternatephone:
                  showAlternatePhone ? sealternatephonec.text : "",
              dropOffAddress: daddressc.text,
              receiverName: receiverc.text,
              receiverPhoneNumber: receiverphonec.text,
              otherPhoneNumber:
                  showAlternatePhone2 ? realternatephonec.text : "",
              scheduledDate: isschedule ? selectedDeliveryDate : null,
              isInstant: isexpress ? true : false,
              isScheduled: isschedule ? true : false,
              isflexibleschedule: flexibleDate ? true : false,
              pickUpDate: isschedule ? selectedPickupDate : null,
              senderEmail: xEmail.text,
            ))
        : null;
  }

  _validatePickUp() {
    if (pickupTerminalc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false)
            .validPickupTerminal = false;
        validationmessage = "Field cant be empty";
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false)
            .validPickupTerminal = true;
      });
    }
  }

  _validationEmail() {
    RegExp xRegex = RegExp(
        Provider.of<ValidationBloc>(context, listen: false).emailValidation);
    if (!xRegex.hasMatch(xEmail.text) && !xEmail.text.isEmpty) {
      setState(() {
        emailValidation = "Please enter a valid email";
        Provider.of<ValidationBloc>(context, listen: false).validEmail = false;
      });
    } else if (xEmail.text.length <= 11 && !xEmail.text.isEmpty) {
      setState(() {
        emailValidation = "Please enter a valid email";
        Provider.of<ValidationBloc>(context, listen: false).validEmail = false;
      });
    } else if (xEmail.text.isEmpty) {
      setState(() {
        emailValidation = "Email cant be empty";
        Provider.of<ValidationBloc>(context, listen: false).validEmail = false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validEmail = true;
      });
    }
  }

  _validatePickUpCity() {
    if (pickupstatec.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validPickupcity =
            false;
        validationmessage = "Field cant be empty";
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validPickupcity =
            true;
      });
    }
  }

  _validatesendername() {
    if (sendernamec.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validsendername =
            false;
        validationmessage = "Field cant be empty";
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validsendername =
            true;
      });
    }
  }

  _validatereceivername() {
    if (receiverc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validreceivername =
            false;
        validationmessage = "Field cant be empty";
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validreceivername =
            true;
      });
    }
  }

  _validatedropoffaddress() {
    if (daddressc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validaddress =
            false;
        validationmessage = "Field cant be empty";
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validaddress = true;
      });
    }
  }

  _validatedropoffcity() {
    if (cityc.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validcity = false;
        validationmessage = "Field cant be empty";
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validcity = true;
      });
    }
  }

  _validatesendersPhone() {
    RegExp xRegexPhone = RegExp(
        Provider.of<ValidationBloc>(context, listen: false).phoneValidation);
    if (!xRegexPhone.hasMatch(senderphonec.text) && !sendernamec.text.isEmpty) {
      setState(() {
        phoneValidationmessge = "Please enter a valid phone number";
        Provider.of<ValidationBloc>(context, listen: false).validsenderphone =
            false;
      });
    } else if (senderphonec.text.length != 11 && !senderphonec.text.isEmpty) {
      setState(() {
        phoneValidationmessge = "Please enter a valid phone number";
        Provider.of<ValidationBloc>(context, listen: false).validsenderphone =
            false;
      });
    } else if (senderphonec.text.isEmpty) {
      setState(() {
        phoneValidationmessge = "Phone number cant be empty";
        Provider.of<ValidationBloc>(context, listen: false).validsenderphone =
            false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validsenderphone =
            true;
      });
    }
  }

  _validatereceiversPhone() {
    RegExp xRegexPhone = RegExp(
        Provider.of<ValidationBloc>(context, listen: false).phoneValidation);
    if (!xRegexPhone.hasMatch(receiverphonec.text) &&
        !receiverphonec.text.isEmpty) {
      setState(() {
        phoneValidationmessge2 = "Please enter a valid phone number";
        Provider.of<ValidationBloc>(context, listen: false).validreceiverphone =
            false;
      });
    } else if (receiverphonec.text.length != 11 &&
        !receiverphonec.text.isEmpty) {
      setState(() {
        phoneValidationmessge2 = "Please enter a valid phone number";
        Provider.of<ValidationBloc>(context, listen: false).validreceiverphone =
            false;
      });
    } else if (receiverphonec.text.isEmpty) {
      setState(() {
        phoneValidationmessge2 = "Phone number cant be empty";
        Provider.of<ValidationBloc>(context, listen: false).validreceiverphone =
            false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validreceiverphone =
            true;
      });
    }
  }

  void _selectDeliveryDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDeliveryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
    if (selected != null)
      setState(() {
        isSelectDate = true;
        selectedDeliveryDate = selected;
        finalDate = DateFormat("MMMM dd, yyyy").format(selected);
      });
  }

  void _selectPickUpDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDeliveryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
    if (selected != null)
      setState(() {
        isSelectDatePickup = true;
        selectedPickupDate = selected;
        finalDatePickUp = DateFormat("MMMM dd, yyyy").format(selected);
      });
  }

  _checkDispatchType() {
    if (isDoortodoor == false) {
      setState(() {
        isDoortodoor = true;
      });
    } else {
      setState(() {
        isDoortodoor = false;
      });
    }
  }
}
