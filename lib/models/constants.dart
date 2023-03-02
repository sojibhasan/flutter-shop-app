

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/screens/auth/country.dart';
import 'package:shop_k/screens/auth/login.dart';

SystemUiOverlayStyle st = SystemUiOverlayStyle(
statusBarColor: mainColor,
statusBarIconBrightness: Brightness.light,
statusBarBrightness: Brightness.light,
);
String domain = 'https://kocart.easyshop-qa.com/api/V1/';
String imagePath = 'https://kocart.easyshop-qa.com/assets/images/products/min/';
String imagePath2 = 'https://kocart.easyshop-qa.com/assets/images/products/gallery/';
String language='en';
String getCurrancy(){
  return language=='en'?'IDR':'IDR';
}
int studentId = 0;
void setLang(lang){
  language=lang;
}
late String token;
void setToken(String _token){
  token = _token;
}
void changeLang(){
  if(language=='en'){
    language='en';
  }else{
    language='id';
  }
}
double h =0.0;
double w =0.0;
void setSize(_w,_h){
  h = _h;
  w = _w;
}
late SharedPreferences prefs ;
Future startShared()async{
  prefs = await SharedPreferences.getInstance();
}
void navP(context,className){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>className));
}
void navPR(context,className){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>className));
}
void navPRRU(context,className){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>className), (route) => false);
}
void navPop(context){
  Navigator.pop(context);
}
void navPopU(context){
  Navigator.popUntil(context, (route) => false);
}
void showBar(context,msg){
  var bar =SnackBar(
    content: Text(msg),
    action: SnackBarAction(label: translate(context,'snack_bar','undo'),
      onPressed: (){
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    duration: const Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(bar);
}
void dialog(context){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        child: Opacity(
          opacity: 0.7,
          child: Container(
            width: w,
            height: h,
            color: Colors.black12,
            child: Center(
              child: CircularProgressIndicator(color: mainColor,),
            ),
          ),
        ),
        onWillPop: ()async=>false,
      );
    },
  );
}
void alertSuccess (context){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: translate(context, 'alert', 'success'),
      desc:
      translate(context, 'alert', 'operation'),
      btnOkOnPress: () {
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        navPop(context);
      })
      .show();
}
void alertSuccessAddress (context){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: translate(context, 'alert', 'success'),
      desc:
      translate(context, 'alert', 'operation'),
      btnOkOnPress: () {
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        int count = 3;
        Navigator.popUntil(context, (route) => count--<=0);
      })
      .show();
}
void alertSuccessData (context,data){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: translate(context, 'alert', 'success'),
      desc: data,
      btnOkOnPress: () {
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        navPop(context);
      })
      .show();
}
void alertSuccessNoBack (context){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: translate(context, 'alert', 'success'),
      desc:
      translate(context, 'alert', 'operation'),
      btnOkOnPress: () {
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
      })
      .show();
}
void alertSuccessPass (context){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: translate(context, 'alert', 'success'),
      desc:
      translate(context, 'alert', 'operation'),
      btnOkOnPress: () {
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        navPRRU(context, Login());
      })
      .show();
}
String countryCode = '+62';
List<int> countryNumber = [6,7,8,9] ;
void error (context){
  AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      dismissOnTouchOutside: false,
      title:  translate(context, 'alert', 'failed'),
      desc: translate(context, 'alert', 'try'),
      btnOkOnPress: () {
      },
      onDissmissCallback: (val){
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red)
      .show();
}
void errorWPop (context){
  AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      dismissOnTouchOutside: false,
      title:  translate(context, 'alert', 'failed'),
      desc: translate(context, 'alert', 'try'),
      btnOkOnPress: () {
      },
      onDissmissCallback: (val){
        navPop(context);
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red)
      .show();
}
void customError (context,data){
  AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      dismissOnTouchOutside: false,
      title:  translate(context, 'alert', 'failed'),
      desc:data,
      btnOkOnPress: () {
      },
      onDissmissCallback: (val){
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red)
      .show();
}
void customErrorWPop (context,data){
  AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      dismissOnTouchOutside: false,
      title:  translate(context, 'alert', 'failed'),
      desc:data,
      btnOkOnPress: () {
      },
      onDissmissCallback: (val){
        navPop(context);
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red)
      .show();
}