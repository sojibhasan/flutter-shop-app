import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/homeItem.dart';
import 'package:shop_k/models/productsCla.dart';
import 'package:shop_k/provider/student_product.dart';
import 'package:shop_k/provider/student_provider.dart';
import 'package:shop_k/screens/student/student_info.dart';
import 'package:shop_k/screens/student/view_all.dart';
import 'package:url_launcher/url_launcher.dart';

class Student extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate(context,'student','title'),style: TextStyle(color: Colors.white,fontSize: w*0.04),),
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          elevation: 5,
          backgroundColor: mainColor,
          iconTheme: IconThemeData(color: mainColor),
        ),
        body: Container(
          width: w,
          height: h,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // if(checkPositionStudent(9))InkWell(
                //   child: Container(
                //     height: h*0.2,
                //     width: w,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: NetworkImage(getAdsPosition(9).image),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                //   focusColor: Colors.transparent,
                //   splashColor: Colors.transparent,
                //   highlightColor: Colors.transparent,
                //   onTap: ()async{
                //     Ads _ads = getAdsPositionStudent(9);
                //     if(_ads.inApp){
                //       if(_ads.type){
                //         dialog(context);
                //         await getItem(int.parse(_ads.link));
                //         Navigator.pushReplacementNamed(context, 'pro');
                //       }
                //     }
                //   },
                // ),
                if(getAds(9).isNotEmpty)SizedBox(
                  height: h*0.2,
                  child: Swiper(
                    itemCount: getAds(9).length,
                    itemBuilder: (BuildContext context, int i) {
                      Ads _ads = getAds(9)[i];
                      return InkWell(
                        child: Container(
                          height: h*0.2,
                          width: w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(_ads.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: ()async{
                          if(_ads.inApp){
                            if(_ads.type){
                              dialog(context);
                              await getItem(int.parse(_ads.link));
                              Navigator.pushReplacementNamed(context, 'pro');
                            }
                          }else{
                            await canLaunch(_ads.link) ? await launch(_ads.link) : throw 'Could not launch ${_ads.link}';
                          }
                        },
                      );
                    },
                    autoplay: true,
                    autoplayDelay: 5000,
                  ),
                ),
                SizedBox(height: h*0.01,),
                Container(
                  height: h*0.07,
                  width: w*0.9,
                  child: Row(
                    children: [
                      Text(translate(context,'student','famous'),style: TextStyle(color: Colors.black,fontSize: w*0.04),),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: h*0.02,),
                              InkWell(
                                child: Text(translate(context,'student','all'),style: TextStyle(color: mainColor,fontSize: w*0.04),),
                                onTap: ()async{
                                  dialog(context);
                                  StudentProvider st = Provider.of<StudentProvider>(context,listen: false);
                                  st.clearList();
                                  await st.getStudents();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ViewAll()));
                                },
                              ),
                              Expanded(
                                child: Divider(color: Colors.black,thickness: h*0.001,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h*0.01,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w*0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(studentHome.length>=3?3:studentHome.length, (i) {
                      StudentClass _st = studentHome[i];
                      return InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 2,
                              child: Container(
                                width: w*0.3,
                                height: h*0.17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[200],
                                  image: _st.image==null?DecorationImage(
                                    image: AssetImage('assets/logo.png'),
                                    fit: BoxFit.cover,
                                  ):DecorationImage(
                                    image: NetworkImage(_st.image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: h*0.01,),
                            Text(_st.name,style: TextStyle(fontSize: w*0.028,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        onTap: ()async{
                          dialog(context);
                          StudentItemProvider st = Provider.of<StudentItemProvider>(context,listen: false);
                          st.clearList();
                          await st.getItems(_st.id);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentInfo(studentClass: _st,)));
                        },
                      );
                    }),
                  ),
                ),
                SizedBox(height: h*0.01,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w*0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(studentHome.length>3?studentHome.length-3:0, (i) {
                      StudentClass _st = studentHome[i+3];
                      return InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 2,
                              child: Container(
                                width: w*0.3,
                                height: h*0.17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[200],
                                  image: _st.image==null?DecorationImage(
                                    image: AssetImage('assets/logo.png'),
                                    fit: BoxFit.cover,
                                  ):DecorationImage(
                                    image: NetworkImage(_st.image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: h*0.01,),
                            Text(_st.name,style: TextStyle(fontSize: w*0.028,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        onTap: ()async{
                          dialog(context);
                          StudentItemProvider st = Provider.of<StudentItemProvider>(context,listen: false);
                          st.clearList();
                          await st.getItems(_st.id);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentInfo(studentClass: _st,)));
                        },
                      );
                    }),
                  ),
                ),
                SizedBox(height: h*0.02,),
                // if(checkPositionStudent(10))InkWell(
                //   child: Container(
                //     height: h*0.2,
                //     width: w,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: NetworkImage(getAdsPosition(10).image),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                //   focusColor: Colors.transparent,
                //   splashColor: Colors.transparent,
                //   highlightColor: Colors.transparent,
                //   onTap: ()async{
                //     Ads _ads = getAdsPositionStudent(10);
                //     if(_ads.inApp){
                //       if(_ads.type){
                //         dialog(context);
                //         await getItem(int.parse(_ads.link));
                //         Navigator.pushReplacementNamed(context, 'pro');
                //       }
                //     }
                //   },
                // ),
                if(getAds(10).isNotEmpty)SizedBox(
                  height: h*0.2,
                  child: Swiper(
                    itemCount: getAds(10).length,
                    itemBuilder: (BuildContext context, int i) {
                      Ads _ads = getAds(10)[i];
                      return InkWell(
                        child: Container(
                          height: h*0.2,
                          width: w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(_ads.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: ()async{
                          if(_ads.inApp){
                            if(_ads.type){
                              dialog(context);
                              await getItem(int.parse(_ads.link));
                              Navigator.pushReplacementNamed(context, 'pro');
                            }
                          }else{
                            await canLaunch(_ads.link) ? await launch(_ads.link) : throw 'Could not launch ${_ads.link}';
                          }
                        },
                      );
                    },
                    autoplay: true,
                    autoplayDelay: 5000,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
