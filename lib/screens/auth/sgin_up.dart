import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/cart.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/homeItem.dart';
import 'package:shop_k/models/user.dart';
import 'package:shop_k/provider/cart_provider.dart';
import 'package:shop_k/screens/home/Home.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  List<String> _hint = language=='en'?[
    'Name','E-mail','phone number','password','confirm password'
  ]:[
  'Name','Surel','nomor telepon','kata sandi','konfirmasi sandi'
  ];
  late Timer  _timer;
  int counter = 60;
  bool dialogSms = false,makeError = false,finishSms = true,checkRe = false;
  bool _visibility1 = true ,_visibility2 = true ,check = true;
  List<FocusNode> _listFocus = List<FocusNode>.generate(5, (_) => new FocusNode()) ;
  List<TextEditingController> _listEd = List<TextEditingController>.generate(5, (_) => new TextEditingController()) ;
  Future register()async{
    final String url = domain+'register';
    try {
      Response response = await Dio().post(url,
        data: {
          'phone':_listEd[2].text,
          'password':_listEd[3].text,
          'password_confirmation':_listEd[4].text,
          'email':_listEd[1].text,
          'name':_listEd[0].text
        },
      );
      if(response.data['status']==0){
        String data ='';
        if(language=='ar'){
          response.data['message'].forEach((e){
            data += e + '\n';
          });
        }else{
          response.data['message'].forEach((e){
            data += e + '\n';
          });
        }
        final snackBar = SnackBar(
          content: Text(data),
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
        _btnController.stop();
        return null;
      }
      if(response.statusCode==200){
        Map userData = response.data['data']['user'];
        user = UserClass(id: userData['id'],name: userData['name'],phone: userData['phone'],email:userData['email']);
        await prefs.setBool('login',true);
        await prefs.setInt('id',userData['id']);
        await prefs.setString('auth',response.data['data']['token']);
        await getHomeItems();
        setUserId(userData['id']);
        setLogin(true);
        setAuth(response.data['data']['token']);
        dbHelper.deleteAll();
        Provider.of<CartProvider>(context,listen: false).clearAll();
        navPRRU(context, Home());
      }
    } catch (e) {
      print('e');
      print(e);
      _btnController.error();
      await Future.delayed(const Duration(seconds: 2));
      _btnController.stop();
    }
  }
  String? verificationId;
  Future fireSms(context,String phone,RoundedLoadingButtonController _btnController)async{
    counter = 60;
    final TextEditingController sms = TextEditingController();
    try{
      String ph=countryCode+phone;
      Future<PhoneVerificationFailed?> verificationFailed  (FirebaseAuthException authException)async{
        checkRe = false;
        await Future.delayed(const Duration(milliseconds: 1000));
        _btnController.stop();
        showBar(context, translate(context,'fire_base','error1'));
      }
      Future<PhoneCodeAutoRetrievalTimeout?> autoTimeout  (String varId)async{
        finishSms = true;
        checkRe = false;
        verificationId = varId;
        _btnController.stop();
      }
      await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: ph,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential credential)async{
            try{
              var  result = await FirebaseAuth.instance.signInWithCredential(credential);
              var ha = result.user;
              if(ha!=null){
                await register();
              }
            }catch(e)
            {
              _btnController.error();
              await Future.delayed(const Duration(milliseconds: 1000));
              _btnController.stop();
              showBar(context,translate(context,'fire_base','error2'));
            }
          },
          verificationFailed: verificationFailed,
          codeSent: (String verificationId,[int? forceResendingToken]){
            checkRe = false;
            finishSms = false;
            if(dialogSms){
              dialogSms = false;
              navPop(context);
            }
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context){
                  final _formKey2 = GlobalKey<FormState>();
                  _btnController.stop();
                  return Form(
                    key: _formKey2,
                    child: AlertDialog(
                      title: Align(alignment: Alignment.topLeft,child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: (){
                          _timer.cancel();
                          Navigator.pop(context);
                        },
                      ),),
                      titlePadding: const EdgeInsets.only(left: 0,bottom: 0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      content: SizedBox(
                        height: h*30/100,
                        child: Column(
                          children: <Widget>[
                            Align(child: Text(translate(context,'sms','title'),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: w*5/100),),alignment: Alignment.center,),
                            SizedBox(height: h*2/100,),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: TextFormField(
                                controller: sms,
                                decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: translate(context,'sms','hint'),
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: mainColor,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return translate(context,'validation','field');
                                  }
                                  if(makeError){
                                    return translate(context,'sms','in');
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: h*1.5/100,),
                            StatefulBuilder(
                              builder: (context2,setState3){
                                if(counter==60){
                                  _timer = Timer.periodic(Duration(seconds: 1), (e){
                                    if(mounted){
                                      setState3((){
                                        counter--;
                                      });
                                    }
                                    if(counter==0){
                                      e.cancel();
                                    }
                                  });
                                }
                                return SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        child: RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(text: translate(context,'sms','re'),
                                                    style: TextStyle(color: mainColor,fontSize: w*0.035)),
                                                TextSpan(text: counter.toString(),style: TextStyle(color: Colors.black)),
                                              ]
                                          ),
                                        ),
                                        onTap: (){
                                          if(counter==0){
                                            if(!checkRe){
                                              checkRe = true;
                                              _timer.cancel();
                                              dialogSms = true;
                                              fireSms(context, phone, _btnController);
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: h*1.5/100,),
                            InkWell(
                              child: Container(
                                width: w*30/100,
                                height: h*6/100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(
                                  child: Text(translate(context,'buttons','send'),style: TextStyle(color: mainColor,fontSize: w*4.5/100,fontWeight: FontWeight.bold),),
                                ),
                              ),
                              onTap: ()async{
                                if (_formKey2.currentState!.validate()){
                                  try{
                                    FocusScope.of(context).unfocus();
                                    AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: sms.text);
                                    var  result = await FirebaseAuth.instance.signInWithCredential(credential);
                                    var ha = result.user;
                                    if(ha!=null){
                                      sms.text = '';
                                      Navigator.pop(context,'ok');
                                      _timer.cancel();
                                      await register();
                                    }
                                  }catch(e){
                                    print('hamza');
                                    makeError = true;
                                    if (_formKey2.currentState!.validate()){
                                      print('hamza2');
                                    }
                                    makeError = false ;
                                    print('hamza3');
                                  }
                                }else{
                                  print('hamza4');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsets.only(top: 0,right: w*2/100,left: w*2/100,bottom: 0),
                    ),
                  );
                }
            ).then((value) {
              if(value==null){
                _btnController.reset();
              }
            });
          },
          codeAutoRetrievalTimeout: autoTimeout);
    }catch (e)
    {
      // showBar(context, e, e);
      _btnController.error();
      await Future.delayed(const Duration(milliseconds: 1000));
      _btnController.stop();
      showDialog(context: context,
          builder:(context)=> AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(60)),
            ),
            content: SizedBox(
                height: h*0.5,
                width: h/3.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(e.toString())
                    ],
                  ),
                )
            ),
          )
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            systemOverlayStyle: st,
            title: Text(translate(context,'register','title'), style: TextStyle(fontSize: w * 0.05, color: mainColor,fontWeight: FontWeight.bold),),
            centerTitle: true,
            elevation: 0,
          ),
          body: Center(
            child: Container(
              width: w*0.9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: List.generate(_listFocus.length, (index) {
                        return Column(
                          children: [
                            SizedBox(height: h*0.03,),
                            TextFormField(
                              cursorColor: Colors.black,
                              inputFormatters:index!=1?null:[
                                FilteringTextInputFormatter.allow(RegExp(r"[0-9 a-z A-Z @ .]")),
                              ],
                              controller: _listEd[index],
                              focusNode: _listFocus[index],
                              textInputAction: index<4?TextInputAction.next:TextInputAction.done,
                              obscureText: index==4?_visibility2:index==3?_visibility1:false,
                              keyboardType: index==1?TextInputType.emailAddress:index==2?TextInputType.number:TextInputType.text,
                              onEditingComplete: (){
                                _listFocus[index].unfocus();
                                if(index<4){
                                  FocusScope.of(context).requestFocus(_listFocus[index+1]);
                                }
                              },
                              validator: (value){
                                if (value!.isEmpty) {
                                  return translate(context,'validation','field');
                                }
                                if(index==1){
                                  if (value.length<4||!value.endsWith('.com')||'@'.allMatches(value).length!=1){
                                    return translate(context,'validation','valid_email');
                                  }
                                }
                                if(index==2){
                                  if (!countryNumber.contains(value.length)){
                                    return translate(context,'validation','phone');
                                  }
                                }
                                if(index==3){
                                  if (value.length<6) {
                                    return translate(context,'validation','pass');
                                  }
                                }
                                if(index==4){
                                  if (value!=_listEd[3].text) {
                                    return translate(context,'validation','confirm_pass');
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: form(),
                                enabledBorder: form(),
                                errorBorder: form(),
                                focusedErrorBorder: form(),
                                hintText: _hint[index],
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                suffixIcon: index==4?IconButton(
                                  icon: !_visibility2?Icon(Icons.visibility,color: mainColor,):Icon(Icons.visibility_off,color: mainColor,),
                                  onPressed: (){
                                    setState(() {
                                      _visibility2=!_visibility2;
                                    });
                                    if(!_listFocus[index].hasFocus){
                                      _listFocus[index].unfocus();
                                      _listFocus[index].canRequestFocus = false;
                                    }
                                  },
                                ):index==3?IconButton(
                                  icon: !_visibility1?Icon(Icons.visibility,color: mainColor,):Icon(Icons.visibility_off,color: mainColor,),
                                  onPressed: (){
                                    setState(() {
                                      _visibility1=!_visibility1;
                                    });
                                    if(!_listFocus[index].hasFocus){
                                      _listFocus[index].unfocus();
                                      _listFocus[index].canRequestFocus = false;
                                    }
                                  },
                                ):SizedBox()
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: h*.02,),
                    // Container(
                    //   width: w*0.9,
                    //   child: FormField(
                    //     builder: (state){
                    //       return Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               Checkbox(
                    //                 value: check,
                    //                 onChanged: (val){
                    //                   setState(() {
                    //                     check = val!;
                    //                   });
                    //                 },
                    //                 activeColor: mainColor,
                    //               ),
                    //               SizedBox(width: w*0.02,),
                    //               Text(translate(context,'register','agree'),style: TextStyle(color: mainColor,fontSize: w*0.035,fontWeight: FontWeight.bold,),),
                    //               InkWell(
                    //                 child: Text(translate(context,'register','terms'),style: TextStyle(
                    //                   color: mainColor,
                    //                   fontSize: w*0.03,
                    //                   fontWeight: FontWeight.bold,
                    //                   decorationStyle: TextDecorationStyle.solid,
                    //                   decoration: TextDecoration.underline,
                    //                   decorationColor: mainColor,
                    //                   //fontFamily: family,
                    //                 ),),
                    //                 onTap: (){
                    //                   //Navigator.push(context, MaterialPageRoute(builder: (context)=>Terms()));
                    //                 },
                    //               )
                    //             ],
                    //           ),
                    //           Align(
                    //             child: Text(
                    //               state.errorText ?? '',
                    //               style: TextStyle(
                    //                 color: Theme.of(context).errorColor,
                    //               ),
                    //             ),
                    //             alignment: Alignment.centerLeft,
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //     validator: (val){
                    //       if(!check){
                    //         return translate(context,'validation','terms');
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // SizedBox(height: h*0.01,),
                    RoundedLoadingButton(
                      child: Container(
                        width: w*0.9,
                        height: h*0.07,
                        child: Center(child: Text(translate(context,'buttons','register'),style: TextStyle(color: Colors.white,fontSize: w*0.05),)),
                      ),
                      controller: _btnController,
                      successColor: mainColor,
                      color: mainColor,
                      disabledColor: mainColor,
                      errorColor: Colors.red,
                      onPressed: ()async{
                        FocusScope.of(context).unfocus();
                        if(finishSms){
                          if (_formKey.currentState!.validate()){
                            fireSms(context, _listEd[2].text, _btnController);
                          }else{
                            _btnController.error();
                            await Future.delayed(Duration(seconds: 2));
                            _btnController.stop();
                          }
                        }else{
                          final snackBar = SnackBar(
                            content: Text(translate(context,'sms','wait')),
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
                          _btnController.stop();
                        }
                      },
                    ),
                    SizedBox(height: h*.05,),
                  ],
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
        borderSide: BorderSide(color: mainColor, width: 1.5),
        borderRadius: BorderRadius.circular(15),
    );
  }
}

