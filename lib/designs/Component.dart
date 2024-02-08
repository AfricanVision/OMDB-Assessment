
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../about/internal/application/TextType.dart';
import '../utils/Colors.dart';

text(String text, double textSize, TextType type){

  String textType = getTextType(type);

  return  Text(
    text,
    textAlign: TextAlign.left,
    style:  TextStyle(
        decoration: TextDecoration.none,
        color: colorPrimaryDark,
        fontSize: textSize,
        fontFamily: textType),);
}

raisedButton(String label, VoidCallback? onPressed){

  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2, backgroundColor: colorPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
        padding: const EdgeInsets.only(left: 16, top: 18, bottom: 18, right: 16),
      ),

      child: Text(
        label,
        textAlign: TextAlign.center,
        style:  TextStyle(
            decoration: TextDecoration.none,
            color: colorWhite,
            fontSize: 14,
            fontFamily: getTextType(TextType.Bold)),));
}

buttonWithWidget(Widget widget, Color? color,VoidCallback? clickAction){
  return ElevatedButton(

      onPressed: clickAction,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        backgroundColor: color ?? colorPrimary,
        padding: EdgeInsets.zero,
      ),

      child: widget);
}

iconButton(Widget icon, Color color,VoidCallback? onPressed){
  return IconButton(
    onPressed: onPressed,
    icon: icon,);
}



textButtonWithOption(String label, double textSize, TextType type, Color color, VoidCallback? onPressed,){
  return TextButton(onPressed: onPressed, child: Text(
    label,
    textAlign: TextAlign.center,

    style: TextStyle(
        decoration: TextDecoration.none,
        color: color,
        fontSize: textSize,
        fontFamily: getTextType(type)),
  ));
}



textWithAlignAndColor(String text, double textSize, TextType type, TextAlign align,Color color){

  String textType = getTextType(type);

  return  Text(
    text,
    textAlign: align,
    style:  TextStyle(
        decoration: TextDecoration.none,
        color: color,
        fontSize: textSize,
        fontFamily: textType),);
}


textWithColor(String text, double textSize, TextType type, Color color){

  String textType = getTextType(type);

  return  Text(
    text,
    textAlign: TextAlign.left,
    style:  TextStyle(
        decoration: TextDecoration.none,
        color: color,
        fontSize: textSize,
        fontFamily: textType),);
}

inputFieldUserCode(String label, FormFieldValidator<String> validator, bool enabled, TextInputType textInputType, String helpers, Widget prefixIcon, TextEditingController controller, List<TextInputFormatter> inputFormatters) {
  return TextFormField(
    enabled: enabled,
    validator: validator,
    controller: controller,
    style:  TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: getTextType(TextType.Bold)),
    maxLines: 1,
    cursorColor: colorPrimary,
    autofocus: false,
    textAlign: TextAlign.center,
    textInputAction: TextInputAction.done,
    keyboardType: textInputType,
    autovalidateMode: AutovalidateMode.disabled,
    inputFormatters: inputFormatters,
    textCapitalization: TextCapitalization.characters,
    decoration: InputDecoration(
      prefixIcon: Padding(padding: const EdgeInsets.only(left: 16, right: 16,),
        child: prefixIcon,),
      prefixIconColor: Colors.grey,
      errorMaxLines: 5,
      helperMaxLines: 5,
      isDense: true,
      contentPadding: const EdgeInsets.only(
          top: 24.0, bottom: 24.0, left: 16.0, right: 16.0),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 35,
        minHeight: 35,
      ),
      fillColor: Colors.transparent,
      filled: true,
      labelText: label,
      helperText: helpers,
      helperStyle: TextStyle(color: Colors.grey, fontSize: 11, fontFamily: getTextType(TextType.Regular)),
      hintStyle: const TextStyle(color: Colors.grey),
      errorStyle: TextStyle(color: colorPrimary, fontSize: 11,fontFamily: getTextType(TextType.Regular)),
      labelStyle: TextStyle(color: Colors.grey, fontSize: 16, fontFamily: getTextType(TextType.Bold)),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorPrimary, width: 2.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorPrimary, width: 4.0),

      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorGrey, width: 3.0),
      ),
      enabledBorder:  const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorGrey, width: 3.0),
      ),

    ),
  );
}

inputField(String label, FormFieldValidator<String> validator, bool enabled, TextInputType textInputType, String helpers, Widget prefixIcon, TextEditingController controller, List<TextInputFormatter> inputFormatters) {
  return TextFormField(
    enabled: enabled,
    validator: validator,
    controller: controller,
    style:  TextStyle(
        color: colorPrimaryDark,
        fontSize: 12.0,
        fontFamily: getTextType(TextType.Regular)),
    maxLines: 1,
    cursorColor: colorPrimary,
    autofocus: false,
    textAlign: TextAlign.left,
    textInputAction: TextInputAction.done,
    keyboardType: textInputType,
    autovalidateMode: AutovalidateMode.disabled,
    inputFormatters: inputFormatters,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      prefixIcon: Padding(padding: const EdgeInsets.only(left: 16, right: 16,),
        child: prefixIcon,),
      prefixIconColor: colorPrimaryDark,
      errorMaxLines: 5,
      helperMaxLines: 5,
      isDense: true,
      contentPadding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 16.0, right: 16.0),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 35,
        minHeight: 35,
      ),
      fillColor: Colors.transparent,
      filled: true,
      labelText: label,
      helperText: helpers,
      helperStyle: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: getTextType(TextType.Regular)),
      hintStyle: const TextStyle(color: Colors.grey),
      errorStyle: TextStyle(color: colorPrimaryLight, fontSize: 12,fontFamily: getTextType(TextType.Regular)),
      labelStyle: TextStyle(color: colorPrimaryDark, fontSize: 12, fontFamily: getTextType(TextType.Medium)),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(color: colorPrimary, width: 1.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(color: colorPrimary, width: 2.0),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(color: colorPrimaryDark, width: 1.0),
      ),
      enabledBorder:  const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(color: colorPrimaryDark, width: 1.0),
      ),

    ),
  );
}

inputFieldOnKeyPress(String label, FormFieldValidator<String> validator, bool enabled, TextInputType textInputType, String helpers, Widget prefixIcon, ValueChanged<String>? onChange, TextEditingController controller, List<TextInputFormatter> inputFormatters) {
  return TextFormField(
    enabled: enabled,
    validator: validator,
    controller: controller,
    onChanged: onChange,
    style:  TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: getTextType(TextType.Bold)),
    maxLines: 1,
    cursorColor: colorPrimary,
    autofocus: false,
    textAlign: TextAlign.left,
    textInputAction: TextInputAction.done,
    keyboardType: textInputType,
    autovalidateMode: AutovalidateMode.disabled,
    inputFormatters: inputFormatters,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      prefixIcon: Padding(padding: const EdgeInsets.only(left: 16, right: 16,),
        child: prefixIcon,),
      prefixIconColor: Colors.grey,
      errorMaxLines: 5,
      helperMaxLines: 5,
      isDense: true,
      contentPadding: const EdgeInsets.only(
          top: 24.0, bottom: 24.0, left: 16.0, right: 16.0),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 35,
        minHeight: 35,
      ),
      fillColor: Colors.transparent,
      filled: true,
      labelText: label,
      helperText: helpers,
      helperStyle: TextStyle(color: Colors.grey, fontSize: 11, fontFamily: getTextType(TextType.Regular)),
      hintStyle: const TextStyle(color: Colors.grey),
      errorStyle: TextStyle(color: colorPrimary, fontSize: 11,fontFamily: getTextType(TextType.Regular)),
      labelStyle: TextStyle(color: Colors.grey, fontSize: 16, fontFamily: getTextType(TextType.Bold)),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorPrimary, width: 2.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorPrimary, width: 4.0),

      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorGrey, width: 3.0),
      ),
      enabledBorder:  const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorGrey, width: 3.0),
      ),

    ),
  );
}

selectFieldCustom(String label, FormFieldValidator<String> validator, bool enabled, TextInputType textInputType, String helpers, GestureTapCallback? onTap, TextEditingController controller, List<TextInputFormatter> inputFormatters) {
  return TextFormField(
    enabled: enabled,
    validator: validator,
    controller: controller,
    onTap: onTap,
    autofocus: false,
    showCursor: false,
    readOnly: true,
    style:  TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: getTextType(TextType.Bold)),
    maxLines: 1,
    cursorColor: colorPrimary,
    textAlign: TextAlign.left,
    textInputAction: TextInputAction.done,
    keyboardType: textInputType,
    autovalidateMode: AutovalidateMode.disabled,
    inputFormatters: inputFormatters,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      suffixIcon: const Padding(padding: EdgeInsets.only(left: 16, right: 16,),
        child: Icon(Icons.arrow_drop_down_rounded, color: colorMilkWhite, size: 25,),),
      prefixIconColor: Colors.grey,
      errorMaxLines: 5,
      helperMaxLines: 5,
      isDense: true,
      contentPadding: const EdgeInsets.only(
          top: 24.0, bottom: 24.0, left: 16.0, right: 16.0),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 35,
        minHeight: 35,
      ),
      fillColor: Colors.transparent,
      filled: true,
      labelText: label,
      helperText: helpers,
      helperStyle: TextStyle(color: Colors.grey, fontSize: 11, fontFamily: getTextType(TextType.Regular)),
      hintStyle: const TextStyle(color: Colors.grey),
      errorStyle: TextStyle(color: colorPrimary, fontSize: 11,fontFamily: getTextType(TextType.Regular)),
      labelStyle: TextStyle(color: Colors.grey, fontSize: 16, fontFamily: getTextType(TextType.Bold)),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorPrimary, width: 2.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorPrimary, width: 4.0),

      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorGrey, width: 3.0),
      ),
      enabledBorder:  const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorGrey, width: 3.0),
      ),

    ),
  );
}


String getTextType(TextType type){
  switch(type){
    case TextType.Bold:
      return "Bold";
    case TextType.Medium:
      return "Medium";
    case TextType.Regular:
      return "Regular";
    default:
      return "Regular";
  }
}

textWithLimit(String text, double textSize, int limit, TextType type){

  String textType = getTextType(type);

  return  Text(
    text,
    textAlign: TextAlign.left,
    maxLines: limit,
    style:  TextStyle(
        decoration: TextDecoration.none,
        color: Colors.white,
        fontSize: textSize,
        fontFamily: textType),);
}

textWithColorAndLimit(String text, double textSize, TextType type, int limit, Color color, TextAlign align){

  String textType = getTextType(type);

  return  Text(
    text,
    textAlign: align,
    maxLines: limit,
    style:  TextStyle(
        decoration: TextDecoration.none,
        color: color,
        fontSize: textSize,
        fontFamily: textType),);
}


userImageRounded(Widget widget, Color background,VoidCallback? callback ){

  return ElevatedButton(onPressed: callback,
      style: ElevatedButton.styleFrom(
        elevation: 15, backgroundColor: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
        padding: const EdgeInsets.all(9),
      ),
      child: widget);

}



outlinedButton(VoidCallback? onPressed, String label) {
  return OutlinedButton(onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      foregroundColor: colorPrimary, padding: const EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
      side:  const BorderSide( width: 2, color: colorPrimary,   style: BorderStyle.solid, ),
    ),

      child: Text(
        label,
        textAlign: TextAlign.left,
        style: TextStyle(
            decoration: TextDecoration.none,
            color: colorPrimary,
            fontSize: 14,
            fontFamily: getTextType(TextType.Bold)),
      ),
  );
}



searchField(bool enabled, ValueChanged<String>? change){

  return TextFormField(
    enabled: enabled,
    onChanged: change,
    style:  TextStyle(
        color: colorPrimaryDark,
        fontSize: 16.0,
        fontFamily: getTextType(TextType.Bold)),
    maxLines: 1,
    cursorColor: colorPrimary,
    autofocus: false,
    textAlign: TextAlign.left,
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.text,
    autovalidateMode: AutovalidateMode.disabled,
    decoration: InputDecoration(
      prefixIcon: Padding(padding: const EdgeInsets.only(left: 16, right: 16,),
        child: Icon(Icons.search,

          color: colorPrimaryDark,),),
      prefixIconColor: Colors.grey,
      errorMaxLines: 5,
      helperMaxLines: 5,
      isDense: true,
      contentPadding: const EdgeInsets.only(
          top: 24.0, bottom: 24.0, left: 16.0, right: 16.0),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 35,
        minHeight: 35,
      ),
      fillColor: Colors.transparent,
      filled: true,
      labelText: "Search",
      helperText: "Enter your search criteria.",
      helperStyle: TextStyle(color: Colors.grey, fontSize: 11, fontFamily: getTextType(TextType.Regular)),
      hintStyle: const TextStyle(color: Colors.grey),
      errorStyle: TextStyle(color: colorPrimary, fontSize: 11,fontFamily: getTextType(TextType.Regular)),
      labelStyle: TextStyle(color: Colors.grey, fontSize: 16, fontFamily: getTextType(TextType.Bold)),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorPrimary, width: 2.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorPrimary, width: 4.0),

      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorGrey, width: 3.0),
      ),
      enabledBorder:  const OutlineInputBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        borderSide: BorderSide(color: colorGrey, width: 3.0),
      ),

    ),
  );

}


