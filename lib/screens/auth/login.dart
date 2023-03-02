import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/cart.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/fav.dart';
import 'package:shop_k/models/homeItem.dart';
import 'package:shop_k/models/user.dart';
import 'package:shop_k/provider/address.dart';
import 'package:shop_k/provider/cart_provider.dart';
import 'package:shop_k/screens/home/Home.dart';
import 'package:shop_k/screens/auth/confirm_phone.dart';
import 'package:shop_k/screens/auth/sgin_up.dart';
import 'package:shop_k/screens/auth/sub.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  bool _visibility = true;
  TextEditingController _editingController1 = TextEditingController();
  TextEditingController _editingController2 = TextEditingController();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  Future login()async{
    final String url = domain+'login';
    try {
      Response response = await Dio().post(url,
        data: {
          'email':_editingController1.text,
          'password':_editingController2.text,
        },
      );
      if(response.statusCode==200&&response.data['user']!=null){
        Map userData = response.data['user'];
        user = UserClass(id: userData['id'],name: userData['name'],phone: userData['phone'],email:userData['email']);
        Provider.of<AddressProvider>(context,listen: false).getAddress();
        setUserId(userData['id']);
        setLogin(true);
        setAuth(response.data['access_token']);
        dbHelper.deleteAll();
        Provider.of<CartProvider>(context,listen: false).clearAll();
        await prefs.setBool('login',true);
        await prefs.setInt('id',userData['id']);
        await prefs.setString('auth',response.data['access_token']);
        await getHomeItems();
        await dbHelper.deleteAll();
        await Provider.of<CartProvider>(context,listen: false).setItems();
        getLikes();
        navPRRU(context, Home());
        return null;
      }
      if(response.statusCode==200&&response.data['status']==0){
        final snackBar = SnackBar(
          content: Text(response.data['message']),
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
        _btnController.error();
        await Future.delayed(const Duration(seconds: 2));
        _btnController.stop();
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        content: Text(translate(context,'login','error')),
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
      _btnController.error();
      await Future.delayed(const Duration(seconds: 2));
      _btnController.stop();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            systemOverlayStyle: st,
            backgroundColor: Colors.white,
            toolbarHeight: h*0.2,
            title: Center(
              child: Text(translate(context,'login','title'), style: TextStyle(fontSize: w * 0.045, color: mainColor,fontWeight: FontWeight.bold),),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            // actions: [
            //   Directionality(
            //     textDirection: TextDirection.rtl,
            //     child: BackButton(color: mainColor,),
            //   ),
            // ],
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(right: w*.05,left: w*0.05,top: h*0.01),
              child: Container(
                width: w*0.9,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: h*0.04,),
                      TextFormField(
                        controller: _editingController1,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.start,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _focusNode1,
                        onEditingComplete: (){
                          _focusNode1.unfocus();
                          FocusScope.of(context).requestFocus(_focusNode2);
                        },
                        inputFormatters:[
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9 a-z  @ .]")),
                        ],
                        validator: (value){
                          if (value!.length<4&&'@'.allMatches(value).length!=1) {
                            return translate(context,'validation','valid_email');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: form(),
                          enabledBorder: form(),
                          errorBorder: form(),
                          focusedErrorBorder: form(),
                          errorStyle: TextStyle(color: Colors.red[300]),
                          hintText: translate(context,'inputs','email'),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: h*0.04,),
                      TextFormField(
                        controller: _editingController2,
                        style: TextStyle(color: Colors.white),
                        obscureText: _visibility,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.done,
                        focusNode: _focusNode2,
                        validator: (value){
                          if (value!.isEmpty) {
                            return translate(context,'validation','field');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: form(),
                          enabledBorder: form(),
                          errorBorder: form(),
                          focusedErrorBorder: form(),
                          errorStyle: TextStyle(color: Colors.red[300]),
                          hintText: translate(context,'inputs','pass'),
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: w*0.01),
                            child: IconButton(
                              icon: !_visibility?Icon(Icons.visibility,color: Colors.white,):Icon(Icons.visibility_off,color: Colors.white,),
                              onPressed: (){
                                setState(() {
                                  _visibility=!_visibility;
                                });
                                if(!_focusNode2.hasFocus){
                                  _focusNode2.unfocus();
                                  _focusNode2.canRequestFocus = false;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h*0.04,),
                      RoundedLoadingButton(
                        controller: _btnController,
                        child: Container(
                          width: w*0.9,
                          height: h*0.07,
                          child: Center(child: Text(translate(context,'buttons','login'),style: TextStyle(color: mainColor,fontSize: w*0.07,fontWeight: FontWeight.bold),)),
                        ),
                        successColor: mainColor,
                        color: Colors.white,
                        borderRadius: 20,
                        height: h*0.09,
                        disabledColor: Colors.white,
                        errorColor: Colors.red,
                        valueColor: mainColor,
                        onPressed: ()async{
                          FocusScope.of(context).requestFocus(new FocusNode());
                          if (_formKey.currentState!.validate()){
                            login();
                          }else{
                            _btnController.error();
                            await Future.delayed(Duration(seconds: 2));
                            _btnController.stop();
                          }
                        },
                      ),
                      SizedBox(height: h*0.02,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          child:Text(translate(context,'login','reset'),style: TextStyle(color: Colors.white,fontSize: w*0.03,
                            fontWeight: FontWeight.bold,
                          ),),
                          onTap: ()async{
                            navP(context, ConfirmPhone());
                            // showDialog(
                            //     context: context,
                            //     barrierDismissible: false,
                            //     builder: (dialogContext){
                            //       return AlertDialog(
                            //         title: Align(alignment: Alignment.topLeft,child: IconButton(
                            //           icon: const Icon(Icons.close),
                            //           onPressed: (){
                            //             _timer.cancel();
                            //             Navigator.pop(dialogContext);
                            //           },
                            //         ),),
                            //         titlePadding: const EdgeInsets.only(left: 0,bottom: 0),
                            //         shape: const RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            //         ),
                            //         content: SizedBox(
                            //           height: h*27/100,
                            //           child: Column(
                            //             children: <Widget>[
                            //               Align(child: Text(translate(context,'sms','title'),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: w*5/100),),alignment: Alignment.center,),
                            //               SizedBox(height: h*2/100,),
                            //               Directionality(
                            //                 textDirection: TextDirection.ltr,
                            //                 child: TextField(
                            //                   decoration: new InputDecoration(
                            //                     border: new OutlineInputBorder(
                            //                         borderSide: new BorderSide(color: Colors.black),
                            //                         borderRadius: BorderRadius.circular(10)
                            //                     ),
                            //                     hintText: translate(context,'sms','hint'),
                            //                     contentPadding: EdgeInsets.zero,
                            //                     prefixIcon: Icon(
                            //                       Icons.mail,
                            //                       color: mainColor,
                            //                     ),
                            //                   ),
                            //                   keyboardType: TextInputType.number,
                            //                 ),
                            //               ),
                            //               SizedBox(height: h*1.5/100,),
                            //               StatefulBuilder(
                            //                 builder: (context,setState3){
                            //                   if(counter==60){
                            //                     _timer = Timer.periodic(Duration(seconds: 1), (e){
                            //                       if(mounted){
                            //                         setState3((){
                            //                           counter--;
                            //                         });
                            //                       }
                            //                       if(counter==0){
                            //                         e.cancel();
                            //                       }
                            //                     });
                            //                   }
                            //                   return SizedBox(
                            //                     width: double.infinity,
                            //                     child: Row(
                            //                       children: [
                            //                         RichText(
                            //                           text: TextSpan(
                            //                               children: [
                            //                                 TextSpan(text: 'Re-send code   ',
                            //                                     style: TextStyle(color: mainColor,fontSize: w*0.035)),
                            //                                 TextSpan(text: counter.toString(),style: TextStyle(color: Colors.black)),
                            //                               ]
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   );
                            //                 },
                            //               ),
                            //               SizedBox(height: h*1.5/100,),
                            //               InkWell(
                            //                 child: Container(
                            //                   width: w*30/100,
                            //                   height: h*6/100,
                            //                   decoration: BoxDecoration(
                            //                       borderRadius: BorderRadius.circular(7),
                            //                       border: Border.all(color: Colors.black)
                            //                   ),
                            //                   child: Center(
                            //                     child: Text(translate(context,'buttons','send'),style: TextStyle(color: mainColor,fontSize: w*4.5/100,fontWeight: FontWeight.bold),),
                            //                   ),
                            //                 ),
                            //                 onTap: ()async{
                            //
                            //                 },
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         contentPadding: EdgeInsets.only(top: 0,right: w*2/100,left: w*2/100,bottom: 0),
                            //       );
                            //     }
                            // ).then((value) {
                            //   _timer.cancel();
                            //   counter=60;
                            // });
                          },
                        ),
                      ),
                      SizedBox(height: h*0.04,),
                      InkWell(
                        child: Container(
                          width: w*0.9,
                          height: h*0.09,
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)
                          ),
                          child: Center(child: Text(translate(context,'login','register'),style: TextStyle(color: Colors.white,fontSize: w*0.05,fontWeight: FontWeight.bold),)),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SignUp()));
                        },
                      ),
                      SizedBox(height: h*0.02,),
                      InkWell(
                        child:Text(translate(context,'login','guest'),style: TextStyle(color: Colors.white,fontSize: w*0.03,
                          fontWeight: FontWeight.bold,
                        ),),
                        onTap: ()async{
                          dialog(context);
                          dbHelper.deleteAll();
                          Provider.of<CartProvider>(context,listen: false).clearAll();
                          addressGuest = null;
                          await getHomeItems();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>Home()),(route)=>false);
                        },
                      ),
                      SizedBox(height: h*0.05,),
                      InkWell(
                        child: Container(
                          width: w*0.9,
                          height: h*0.09,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: w*0.05),
                            child: Row(
                              children: [
                                Icon(Icons.person_sharp,color: mainColor,size: w*0.09,),
                                SizedBox(width: w*0.08,),
                                Text(translate(context,'login','sub'),style: TextStyle(color: mainColor,fontSize: w*0.05,
                                    fontWeight: FontWeight.bold,height: 1.5),),
                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Subscription()));
                        },
                      ),
                      SizedBox(height: h*0.04,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  InputBorder form() {
    return new OutlineInputBorder(
        borderSide: BorderSide(color: (Colors.white), width: 1),
        borderRadius: BorderRadius.circular(20),
    );
  }
}

