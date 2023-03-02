import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/country.dart';
import 'package:shop_k/models/fav.dart';
import 'package:shop_k/screens/auth/country.dart';
import 'package:shop_k/screens/auth/login.dart';
import 'package:shop_k/screens/lang.dart';
import 'models/homeItem.dart';
import 'models/user.dart';
import 'screens/home/Home.dart';
class Splach extends StatefulWidget {
  @override
  _SplachState createState() => _SplachState();
}

class _SplachState extends State<Splach> {
  Future go()async{
    await Future.delayed(Duration(milliseconds: 50),()async{
      String? lang = prefs.getString('language_code');
      if(lang!=null){
        if(login){
          getLikes();
          getCountries();
          await getHomeItems();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()),(route)=>false);
        }else{
          getCountries();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()),(route)=>false);
        }
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LangPage()),(route)=>false);
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_)async{
      String? token = prefs.getString('token');
      if(token==null){
        String? _token = await FirebaseMessaging.instance.getToken();
        if(_token!=null){
          prefs.setString('token', _token);
          setToken(_token);
        }
      }else{
        setToken(token);
      }
      int id=prefs.getInt('id')??0;
      // int cId=prefs.getInt('countryId')??0;
      // String cCode=prefs.getString('countryKey')??'';
      // int cNumber=prefs.getInt('countryNumber')??0;
      setUserId(id);
      // setCountryId(cId,cCode,cNumber);
      bool login=prefs.getBool('login')??false;
      setLogin(login);
      String auth = prefs.getString('auth')??'';
      setAuth(auth);
      go();
    });
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    setSize(w, h);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        height: h,
        width: w,
        color: mainColor,
        child: Center(child: Image.asset('assets/logo.png')),
      ),
    );
  }
}
