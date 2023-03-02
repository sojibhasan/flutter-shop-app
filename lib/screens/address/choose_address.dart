import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/country.dart';
import 'package:shop_k/provider/address.dart';
import 'add_address.dart';

class ChooseAddress extends StatefulWidget {
  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
        builder: (context,ad,child) {
          List<AddressClass> _list = ad.address;
          if(_list.length>0){
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(translate(context,'choose_address','title'), style: TextStyle(fontSize: w * 0.05, color: Colors.black,fontWeight: FontWeight.bold),),
                  leading: BackButton(color: Colors.black,),
                  centerTitle: true,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding:  EdgeInsets.only(top: h*0.007,bottom: h*0.005),
                      child: Container(
                        width: w*0.9,
                        child: Column(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(_list.length, (i) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: w*0.8,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                Text(_list[i].title,style: TextStyle(fontSize: w*0.032,fontWeight: FontWeight.bold,),),
                                                Text(_list[i].address,style: TextStyle(fontSize: w*0.032,color: Colors.grey,),),
                                                Text(_list[i].phone1,style: TextStyle(fontSize: w*0.032,color: Colors.grey),),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: w*0.1,
                                            child: CircleAvatar(
                                              radius: w*0.03,
                                              child: Icon(Icons.done,color: Colors.white,size: w*0.04,),
                                              backgroundColor: ad.addressCart==_list[i]?mainColor:Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: (){
                                        if(areasId.contains(_list[i].areaId)){
                                          setState(() {
                                            ad.setAddressModel(_list[i]);
                                          });
                                          navPop(context);
                                        }else{
                                          final snackBar = SnackBar(
                                            content: Text(translate(context,'snack_bar','area')),
                                            action: SnackBarAction(
                                              label: translate(context,'snack_bar','area_button'),
                                              disabledTextColor: Colors.yellow,
                                              textColor: Colors.yellow,
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(true,address: _list[i],)));
                                              },
                                            ),
                                            duration: Duration(seconds: 2),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                      },
                                    ),
                                    SizedBox(height: h*0.01,),
                                    Divider(height: h*0.005,color: Colors.grey[300],),
                                    SizedBox(height: h*0.01,),
                                  ],
                                );
                              }),
                            ),
                            SizedBox(height: h*0.09,),
                            InkWell(
                              child: Container(
                                height: h*0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: mainColor,
                                ),
                                child: Center(
                                  child: Text(translate(context,'buttons','add_address'),style: TextStyle(color: Colors.white,fontSize: w*0.045,fontWeight: FontWeight.bold),),
                                ),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(false,inCart: true,)));
                              },
                            ),
                            SizedBox(height: h*0.1,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }else{
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text('Locations', style: TextStyle(fontSize: w * 0.05, color: Colors.black,fontWeight: FontWeight.bold),),
                  leading: BackButton(color: mainColor,),
                  centerTitle: true,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: h*0.1,),
                        Container(
                          width: w*0.5,
                          height: h*0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/nolocation.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(translate(context,'empty','empty'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.07,),),
                        Text(translate(context,'empty','no_address'),style: TextStyle(fontSize: w*0.04,color: Colors.grey),),
                        SizedBox(height: h*0.15,),
                        Padding(
                          padding:  EdgeInsets.only(left: w*0.05,right: w*0.05,),
                          child: Column(
                            children: [
                              InkWell(
                                child: Container(
                                  height: h*0.08,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: mainColor,
                                  ),
                                  child: Center(
                                    child: Text(translate(context,'buttons','add_address'),style: TextStyle(color: Colors.white,fontSize: w*0.045,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(false,inCart: true,)));
                                },
                              ),
                              SizedBox(height: h*0.07,),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ),
            );
          }
        }
    );
  }
}
