import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/info.dart';
import 'package:shop_k/models/order.dart';
import 'package:shop_k/models/user.dart';
import 'package:shop_k/provider/cart_provider.dart';
import 'package:shop_k/screens/about.dart';
import 'package:shop_k/screens/address/address.dart';
import 'package:shop_k/screens/auth/country.dart';
import 'package:shop_k/screens/auth/login.dart';
import 'package:shop_k/screens/cart/cart.dart';
import 'package:shop_k/screens/contac_us.dart';
import 'package:shop_k/screens/profile_user.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<int> counters=[0,0,0];
  Future getProfile()async{
    final String url = domain+'profile';
    try {
      Response response = await Dio().get(url,
        options: Options(
          headers: {
            "auth-token" : auth
          }
        ),
      );
      if(response.statusCode==200&&response.data['name'] is String){
        Map userData = response.data;
        user = UserClass(id: userData['id'],name: userData['name'],phone: userData['phone'],email:userData['email']);
        setUserId(userData['id']);
        navPR(context, ProfileUser());
      }else{
        Map userData = response.data;
        user = UserClass(id: userData['id'],name: userData['name'],phone: userData['phone'],email:userData['email']);
        setUserId(userData['id']);
      }
    } catch (e) {
      navPop(context);
      final snackBar = SnackBar(
        content: Text(translate(context,'snack_bar','try'),),
        action: SnackBarAction(
          label: translate(context,'snack_bar','undo'),
          disabledTextColor: Colors.yellow,
          textColor: Colors.yellow,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  Future<bool> getInfo(title)async{
    final String url = domain+'infos?type=$title';
    try {
      Response response = await Dio().get(url,);
      if(response.statusCode==200&&response.data['status'] == 1){
        setInfo(response.data['data']);
        return true;
      }
      if(response.statusCode==200&&response.data['status'] == 0){
        setInfo([]);
        return true;
      }
    } catch (e) {
    }
    return false;
  }
  Future<bool> logOutUser()async{
    final String url = domain+'logout';
    try {
      await Dio().post(url,
        options: Options(
          headers: {
            "auth-token" : auth
          }
        ),
      );
      return true;
    } catch (e) {
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    CartProvider cart = Provider.of<CartProvider>(context,listen: true);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: InkWell(
            child: Text(login?translate(context,'page_five','title'):'3D Color',style: TextStyle(color: Colors.white,fontSize: w*0.04),),
            onTap: (){
              if(login){
                dialog(context);
                getProfile();
              }
            },
          ),
          centerTitle: false,
          backgroundColor: mainColor,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: w*0.01),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff617bba),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  // child: Icon(Icons.search,color: Colors.white,size: w*0.05,),
                  child: Badge(
                    badgeColor: mainColor,
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart,color: Colors.white,),
                      padding: EdgeInsets.zero,
                      focusColor: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                      },
                    ),
                    animationDuration: Duration(seconds: 2,),
                    badgeContent: Text(cart.items.length.toString(),style: TextStyle(color: Colors.white,fontSize: w*0.03,),),
                    position: BadgePosition.topStart(start: w*0.007),
                  ),
                ),
              ),
            ),
            if(login)SizedBox(width: w*0.05,),
            if(login)IconButton(
                icon: Icon(Icons.location_on_outlined),
                iconSize: w*0.06,
                color: Colors.white,
                padding: EdgeInsets.zero,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Address()));
                },
              ),
            SizedBox(width: w*0.02,),
          ],
        ),
        body: Center(
          child: Container(
            width: w,
            height: h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(!login)SizedBox(height: h*0.02,),
                  if(!login)Text(translate(context,'page_five','register1'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04),),
                  if(!login)Text(translate(context,'page_five','register2'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04),),
                  SizedBox(height: h*0.02,),
                  login?
                  InkWell(
                    child: Container(
                      width: w*0.9,
                      height: h*0.07,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(child: Text(translate(context,'buttons','log_out'),style: TextStyle(color: Colors.white,fontSize: w*0.05),)),
                    ),
                    onTap: ()async{
                      dialog(context);
                      prefs.setBool('login',false);
                      prefs.setInt('id',0);
                      prefs.setString('auth','');
                      setUserId(0);
                      setAuth('');
                      setLogin(false);
                      await logOutUser();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()),(route)=>false);
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Country(1)),(route)=>false);
                    },
                  ):InkWell(
                    child: Container(
                      width: w*0.9,
                      height: h*0.07,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(child: Text(translate(context,'buttons','log_in'),style: TextStyle(color: Colors.white,fontSize: w*0.05),)),
                    ),
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()),(route)=>false);
                    },
                  ),
                  SizedBox(height: h*0.02,),
                  Container(
                    width: w,
                    height: h*0.02,
                    color: Colors.grey[200],
                  ),
                  row(w, h, translate(context,'page_five','notification'), 'noti',0,''),
                  if(login)Divider(color: Colors.grey[300],thickness: h*0.001,),
                  if(login)row(w, h, translate(context,'page_five','change_pass'), 'change',0,''),
                  if(login)Divider(color: Colors.grey[300],thickness: h*0.001,),
                  if(login)row(w, h, translate(context,'page_five','address'), 'address',0,''),
                  if(login)Divider(color: Colors.grey[300],thickness: h*0.001,),
                  if(login)row(w, h, translate(context,'page_five','orders'), 'orders',0,''),
                  Divider(color: Colors.grey[300],thickness: h*0.001,),
                  // row(w, h, translate(context,'page_five','countries'), '',3,''),
                  // Divider(color: Colors.grey[300],thickness: h*0.001,),
                  row(w, h, translate(context,'language','language'), 'lang',0,''),
                  Container(
                    width: w,
                    height: h*0.02,
                    color: Colors.grey[200],
                  ),
                  row(w, h, translate(context,'page_five','about'), 'a',1,'about'),
                  Divider(color: Colors.grey[300],thickness: h*0.001,),
                  row(w, h, translate(context,'page_five','privacy'), 'a',1,'PrivacyPolicy'),
                  Divider(color: Colors.grey[300],thickness: h*0.001,),
                  row(w, h, translate(context,'page_five','terms'), 'a',1,'TermsAndConditions'),
                  Divider(color: Colors.grey[300],thickness: h*0.001,),
                  row(w, h, translate(context,'page_five','delivery'), 'a',1,'delivery'),
                  Divider(color: Colors.grey[300],thickness: h*0.001,),
                  row(w, h, translate(context,'page_five','info'), 'a',1,'information'),
                  Divider(color: Colors.grey[300],thickness: h*0.001,),
                  row(w, h, translate(context,'page_five','questions'), 'a',1,'question'),
                  Divider(color: Colors.grey[300],thickness: h*0.001,),
                  row(w, h, translate(context,'page_five','contacts'), 'a',2,''),
                  Divider(color: Colors.grey[300],thickness: h*0.001,),
                  row(w, h, translate(context,'page_five','how'), 'a',1,'howToUse'),
                  Container(
                    width: w,
                    height: h*0.02,
                    color: Colors.grey[200],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget row(w,h,title,route,i,String api){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w*0.025,vertical: h*0.001),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle(fontSize: w*0.04,color: Colors.black),),
            Directionality(
              textDirection: TextDirection.rtl,
              child: BackButton(
                onPressed: (){

                },
                color: Colors.grey[200],
              ),
            )
          ],
        ),
        onTap: ()async{
          if(i==0){
            if(route == 'orders'){
              dialog(context);
              await getOrders().then((value) {
                if(value){
                  Navigator.pushReplacementNamed(context, route);
                }else{
                  navPop(context);
                  error(context);
                }
              });
            }else{
              Navigator.pushNamed(context, route);
            }
          }
          if(i==1){
            dialog(context);
            bool _check = await getInfo(api);
            if(_check){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>AboutUs(title)));
            }else{
              Navigator.pop(context);
              error(context);
            }
          }
          if(i==2){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ContactUs()));
          }
          // if(i==3){
          //   Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Country(2)));
          // }
        },
      ),
    );
  }
}
