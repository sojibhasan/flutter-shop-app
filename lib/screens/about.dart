import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/info.dart';

class AboutUs extends StatelessWidget {
  final title;
  AboutUs(this.title);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(title, style: TextStyle(fontSize: w * 0.05, color: Colors.black,fontWeight: FontWeight.bold),),
          leading: BackButton(color: Colors.black,),
          centerTitle: true,
          elevation: 0,
        ),
        body: info.isEmpty?Center(
          child: Text(translate(context,'empty','empty'),style: TextStyle(color: mainColor,fontSize: w*0.05),),
        ):
        SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(right: w*.05,left: w*0.05,top: h*0.01),
            child: Container(
              width: w*0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for(var e in info)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: mainColor,
                              radius: w*0.02,
                            ),
                            SizedBox(width: w*.05,),
                            Container(
                              width: w*0.75,
                              child: Text(e.name,
                                style: TextStyle(color: mainColor,fontSize: w*0.05,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h*0.01,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: mainColor,
                              radius: w*0.02,
                            ),
                            SizedBox(width: w*.05,),
                            Container(
                              width: w*0.75,
                              child: Text(translateString(e.desEn, e.desAr),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h*0.03,),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
