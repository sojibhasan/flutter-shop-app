import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/country.dart';
import 'package:shop_k/models/fav.dart';
import 'package:shop_k/models/homeItem.dart';
import 'package:shop_k/models/user.dart';

import 'auth/login.dart';
import 'home/Home.dart';

class LangPage extends StatelessWidget {
  LangPage({Key? key}) : super(key: key);
  final String? lang = prefs.getString('language_code');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(translate(context,'language','language'),style: TextStyle(color: Colors.white,fontSize: w*0.04),),
        centerTitle: true,
        backgroundColor: mainColor,
        leading: lang!=null?BackButton(color: Colors.white,):SizedBox(),
      ),
      body: Center(
        child: SizedBox(
          width: w*0.9,
          height: h,
          child: Column(
            children: [
              SizedBox(height: h*0.05,),
              InkWell(
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(w*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('English',style: TextStyle(color: mainColor,fontSize: w*0.05,fontWeight: FontWeight.bold),),
                          CircleAvatar(
                            radius: w*0.03,
                            child: Icon(Icons.done,color: Colors.white,size: w*0.04,),
                            backgroundColor: lang==null?Colors.white:language=='en'?mainColor:Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: ()async{
                  dialog(context);
                  await Provider.of<AppLanguage>(context,listen: false).changeLanguage(const Locale('en'));
                  if(lang==null){
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
                    navPop(context);
                  }
                },
              ),
              SizedBox(height: h*0.02,),
              InkWell(
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(w*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Bahasa Indonesia',style: TextStyle(color: mainColor,fontSize: w*0.05,fontWeight: FontWeight.bold),),
                          CircleAvatar(
                            radius: w*0.03,
                            child: Icon(Icons.done,color: Colors.white,size: w*0.04,),
                            backgroundColor: lang==null?Colors.white:language=='id'?mainColor:Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: ()async{
                  dialog(context);
                  await Provider.of<AppLanguage>(context,listen: false).changeLanguage(const Locale('id'));
                  // navPop(context);
                  if(lang==null){
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
                    navPop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
