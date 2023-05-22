import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guomobile/constant/colors.dart';

import '../layout/mediaqueries.dart';

Widget formField1(
    BuildContext context, String hintText, double height, double width,
    {bool obscureText = false,
    Color? boxcolor,
    Color? hintcolor,
    bool showBorder = false,
    BorderRadius? radius,
    TextEditingController? controller,
    bool autocorrect = true,
    bool showprefix = false,
    bool showTrailing = false,
    Icon? prefixIcon,
    bool textNext = false,
    Icon? trailingIcon,
    int? maxlines,
    int? minlines,
    bool? isString,
    bool isInt = true,
    TextStyle? style,
    Function()? onT,
    Function()? onchanged,
    Function()? onPressed}) {
  return Container(
    decoration: BoxDecoration(
        color: boxcolor,
        borderRadius: radius,
        border: showBorder
            ? Border.all(
                color: guocolor.black.withOpacity(.1),
              )
            : null),
    height: height,
    width: width,
    child: TextField(
        onChanged: ((value) => onchanged),
        maxLength: maxlines,
        onTap: onT,
        style: TextStyle(
            fontFamily: "Futura",
            fontSize: mqHeight(context, .016),
            color: const Color(0xff65727B)),
        controller: controller,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
            hintText: hintText,
            counterText: "",
            hintStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .017,
              color: hintcolor,
            ),
            border: InputBorder.none,
            prefixIcon: showprefix
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: prefixIcon,
                  )
                : null,
            suffixIcon: showTrailing ? trailingIcon : null),
        obscureText: obscureText,
        textInputAction: textNext ? TextInputAction.next : TextInputAction.done,
        keyboardType: isInt
            ? TextInputType.number
            : isString!
                ? TextInputType.name
                : TextInputType.emailAddress),
  );
}

Widget guoFormField(
  BuildContext context,
  double height,
  double width, {
  TextEditingController? controller,
  FocusNode? focus,
  Color? containercolor,
  Color? borderColor,
  bool showBorder = false,
  BorderRadius? radius,
  bool showRadius = false,
  void Function()? onEditComplete,
  void Function()? onT,
  void Function()? suffixFunction,
  bool showShadow = false,
  bool isReadonly = false,
  void Function(String)? onchanged,
  void Function(String)? onSubmit,
  String? Function(String)? validator,
  bool? autofocus,
  bool radiusborder = false,
  Key? key,
  String? initial,
  bool showprefix = false,
  bool showSuffix = false,
  String? title,
  IconData? pIcon,
  int? maxlength,
  int? maxlines,
  bool isnext = true,
  bool isInt = false,
  bool isObscure = false,
  bool autocorrect = false,
  TextInputType? textType,
  String? Function(String?)? validatorx,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        border: showBorder
            ? Border.all(
                color: guocolor.black.withOpacity(.4),
              )
            : null,
        color: containercolor,
        boxShadow: showShadow
            ? [
                const BoxShadow(
                  color: Colors.black12,
                  blurStyle: BlurStyle.normal,
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset.zero,
                ),
              ]
            : null,
        borderRadius: showRadius ? BorderRadius.circular(10) : null),
    child: TextFormField(
      validator: validatorx,
      style: TextStyle(
        fontFamily: "Futura",
        fontSize: mqHeight(context, .016),
        color: guocolor.black.withOpacity(.5),
      ),
      onEditingComplete: onEditComplete,
      onChanged: onchanged,
      key: key,
      onTap: onT,
      readOnly: isReadonly ? true : false,
      initialValue: initial,
      focusNode: focus,
      onFieldSubmitted: onSubmit,
      controller: controller,
      maxLength: maxlength,
      maxLines: maxlines,
      autofocus: autofocus == true ? true : false,
      decoration: InputDecoration(
        prefixIcon: showprefix
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Icon(
                  pIcon,
                ),
              )
            : null,
        suffixIcon: showSuffix
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: suffixFunction,
                  child: Icon(
                    pIcon,
                    size: 17,
                  ),
                ),
              )
            : null,
        counterText: "",
        border: InputBorder.none,
        focusedBorder: radiusborder == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: guocolor.red.withOpacity(.5)),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: guocolor.black.withOpacity(.3))),
        errorBorder: radiusborder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: guocolor.black, style: BorderStyle.solid, width: 1))
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(
                    color: guocolor.black, style: BorderStyle.solid, width: 1)),
        focusColor: guocolor.red,
        hintText: title,
        hintStyle: TextStyle(
          fontFamily: "Futura",
          fontSize: MediaQuery.of(context).size.height * .016,
          color: guocolor.black.withOpacity(.3),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .03),
      ),
      textInputAction: isnext ? TextInputAction.next : TextInputAction.done,
      keyboardType: isInt ? TextInputType.number : TextInputType.emailAddress,
      obscureText: isObscure ? true : false,
    ),
  );
}

Widget GestureformField1(
    BuildContext context, String hintText, double height, double width,
    {bool obscureText = false,
    Color? boxcolor,
    Color? hintcolor,
    BorderRadius? radius,
    TextEditingController? controller,
    bool autocorrect = true,
    bool? showprefix,
    bool? showTrailing,
    Icon? prefixIcon,
    bool? textNext,
    Icon? trailingIcon,
    int? maxlines,
    int? minlines,
    bool? isString,
    bool? isInt,
    TextStyle? style,
    Function()? onChanged,
    Function()? onPressed}) {
  return GestureDetector(
    onTap: () {
      onPressed;
    },
    child: Container(
      decoration: BoxDecoration(
        color: boxcolor,
        borderRadius: radius,
      ),
      height: height,
      width: width,
      child: TextField(
          style: GoogleFonts.lato(),
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.lato(
                fontSize: MediaQuery.of(context).size.height * .01,
                color: hintcolor,
              ),
              border: InputBorder.none,
              prefixIcon: showprefix!
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: prefixIcon,
                    )
                  : null,
              suffixIcon: showTrailing!
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: trailingIcon,
                    )
                  : null),
          obscureText: obscureText,
          textInputAction:
              textNext! ? TextInputAction.next : TextInputAction.done,
          keyboardType: isInt!
              ? TextInputType.number
              : isString!
                  ? TextInputType.name
                  : TextInputType.emailAddress),
    ),
  );
}

Widget formFieldwithdropdown(
    BuildContext context, String hintText, double height, double width,
    {bool obscureText = false,
    Color? boxcolor,
    Color? hintcolor,
    BorderRadius? radius,
    TextEditingController? controller,
    bool autocorrect = true,
    bool? showprefix,
    bool? showTrailing,
    Icon? prefixIcon,
    bool? textNext,
    Icon? trailingIcon,
    int? maxlines,
    int? minlines,
    bool? isString,
    bool? isInt,
    TextStyle? style,
    Function()? onChanged,
    Function()? onPressed}) {
  return Container(
    decoration: BoxDecoration(
      color: boxcolor,
      borderRadius: radius,
    ),
    height: height,
    width: width,
    child: TextField(
        style: GoogleFonts.lato(),
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.lato(
              fontSize: MediaQuery.of(context).size.height * .01,
              color: hintcolor,
            ),
            border: InputBorder.none,
            prefixIcon: showprefix!
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: prefixIcon,
                  )
                : null,
            suffixIcon: showTrailing!
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: () {
                          onPressed;
                        },
                        child: const Icon(Icons.arrow_drop_down_sharp)),
                  )
                : null),
        obscureText: obscureText,
        textInputAction:
            textNext! ? TextInputAction.next : TextInputAction.done,
        keyboardType: isInt!
            ? TextInputType.number
            : isString!
                ? TextInputType.name
                : TextInputType.emailAddress),
  );
}

Widget RoundformField1(BuildContext context, String hintText, double height,
    double width, double? radius,
    {bool obscureText = false,
    Color? boxcolor,
    Color? hintcolor,
    TextEditingController? controller,
    bool autocorrect = true,
    bool? showprefix,
    bool? showTrailing,
    Icon? prefixIcon,
    bool? textNext,
    Icon? trailingIcon,
    int? maxlines,
    int? minlines,
    bool? isString,
    bool? isInt,
    TextStyle? style,
    Function()? onChanged,
    Function()? validtor,
    Function()? onPressed}) {
  return Container(
    decoration: BoxDecoration(
      color: boxcolor,
      borderRadius: BorderRadius.circular(radius!),
    ),
    height: height,
    width: width,
    child: TextField(
        style: GoogleFonts.lato(),
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.lato(
              fontSize: MediaQuery.of(context).size.height * .01,
              color: hintcolor,
            ),
            border: InputBorder.none,
            prefixIcon: showprefix!
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: prefixIcon,
                  )
                : null,
            suffixIcon: showTrailing!
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: trailingIcon,
                  )
                : null),
        obscureText: obscureText,
        textInputAction:
            textNext! ? TextInputAction.next : TextInputAction.done,
        keyboardType: isInt!
            ? TextInputType.number
            : isString!
                ? TextInputType.name
                : TextInputType.emailAddress),
  );
}

Widget searchFormField(BuildContext context, double height, double width,
    Color color, Color borderColor, String hint,
    {TextEditingController? controller,
    void Function(String)? changeFunction}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor)),
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: TextField(
        onChanged: changeFunction,
        controller: controller,
        style: TextStyle(
          color: guocolor.black.withOpacity(.5),
          fontSize: mqHeight(context, .015),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: guocolor.black.withOpacity(.5),
            fontSize: mqHeight(context, .015),
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}
