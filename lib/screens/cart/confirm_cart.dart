import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_k/models/bottomnav.dart';

import '../auth/login.dart';
class ConfirmCart extends StatefulWidget {
  @override
  _ConfirmCartState createState() => _ConfirmCartState();
}

class _ConfirmCartState extends State<ConfirmCart> {
  final String lang='العربية';
  int _counter = 2;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Check out', style: TextStyle(fontSize: w * 0.05, color: Colors.black,fontWeight: FontWeight.bold),),
            leading: BackButton(color: mainColor,),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: w*0.05),
                      child: Text('Payment',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.05),),
                    ),
                  ),
                  SizedBox(height: h*0.02,),
                  Container(
                    height: h*0.08,
                    width: w*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(right: w*0.05,left: w*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Cash on delivery',style: TextStyle(fontSize: w*0.035),),
                          Container(
                            width: w*0.06,
                            height: w*0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: mainColor,width: w*0.005),
                              color: _counter==1?mainColor:Colors.white,
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.done),
                                onPressed: (){
                                  setState(() {
                                    _counter=1;
                                  });
                                },
                                iconSize: w*0.04,
                                color: Colors.white,
                                padding: EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h*0.02,),
                  Container(
                    height: h*0.08,
                    width: w*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(right: w*0.05,left: w*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('VISA',style: TextStyle(fontSize: w*0.035),),
                          Container(
                            width: w*0.06,
                            height: w*0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: mainColor,width: w*0.005),
                              color: _counter==2?mainColor:Colors.white,
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.done),
                                onPressed: (){
                                  setState(() {
                                    _counter=2;
                                  });
                                },
                                iconSize: w*0.04,
                                color: Colors.white,
                                padding: EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h*0.02,),
                  Container(
                    height: h*0.08,
                    width: w*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(right: w*0.05,left: w*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Master Card',style: TextStyle(fontSize: w*0.035),),
                          Container(
                            width: w*0.06,
                            height: w*0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: mainColor,width: w*0.005),
                              color: _counter==3?mainColor:Colors.white,
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.done),
                                onPressed: (){
                                  setState(() {
                                    _counter=3;
                                  });
                                },
                                iconSize: w*0.04,
                                color: Colors.white,
                                padding: EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h*0.02,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: w*0.05),
                      child: Text('Payment',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.05),),
                    ),
                  ),
                  SizedBox(height: h*0.01,),
                  Padding(
                    padding:  EdgeInsets.only(left: w*0.05,right: w*0.05,),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Price',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.bold),),
                            Text('KWD'+' 118',style: TextStyle(fontSize: w*0.04,color: mainColor),),
                          ],
                        ),
                        SizedBox(height: h*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Services',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.bold)),
                            Text('KWD'+' 118',style: TextStyle(fontSize: w*0.04,color: mainColor),),
                          ],
                        ),
                        SizedBox(height: h*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.bold),),
                            Text('KWD'+' 118',style: TextStyle(fontSize: w*0.05,color: mainColor,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: h*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('VISA',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.bold),),
                            Text('KWD'+' 118',style: TextStyle(fontSize: w*0.04,color: mainColor),),
                          ],
                        ),
                        SizedBox(height: h*0.02,),
                        Align(
                          child: Text('When executing the order via Knet, you agree to',style: TextStyle(fontSize: w*0.03,color: Colors.grey),),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Terms and Conditions',style: TextStyle(fontSize: w*0.035,color: mainColor,),),
                        ),
                        SizedBox(height: h*0.03,),
                        InkWell(
                          child: Container(
                            height: h*0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: mainColor,
                            ),
                            child: Center(
                              child: Text('Check out',style: TextStyle(color: Colors.white,fontSize: w*0.045,fontWeight: FontWeight.bold),),
                            ),
                          ),
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Login(true)));
                          },
                        ),
                        SizedBox(height: h*0.07,),
                      ],
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
  InputBorder form() {
    return new OutlineInputBorder(
        borderSide: BorderSide(color: (Colors.grey[200]!), width: 1),
        borderRadius: BorderRadius.circular(25)
    );
  }
  Widget tra(Widget a,Widget b){
    return lang=='العربية'?a:b;
  }
}
