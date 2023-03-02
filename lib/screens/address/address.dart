import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/user.dart';
import 'package:shop_k/provider/address.dart';
import 'add_address.dart';
class Address extends StatelessWidget {
  Future deleteAddress(context,id)async{
    final String url = domain+'delete-myShipping-address';
    try {
      Response response = await Dio().post(url,
        data: {
          "shippingAddress_id": id,
        },
        options: Options(
            headers: {
              "auth-token" : auth
            }
        ),
      );
      if(response.data['status']==1){
        await Provider.of<AddressProvider>(context,listen: false).getAddress();
        return true;
      }else{
        await Future.delayed(Duration(milliseconds: 700));
        error(context);
      }
    } catch (e) {
      await Future.delayed(Duration(milliseconds: 700));
      error(context);
    }
  }
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
                  title: Text(translate(context,'address','title'), style: TextStyle(fontSize: w * 0.05, color: Colors.black,fontWeight: FontWeight.bold),),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: w*0.6,
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
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.delete,color: Colors.red,),
                                              iconSize: w*0.05,
                                              onPressed: (){
                                                dialog(context);
                                                deleteAddress(context, _list[i].id).then((value) => Navigator.pop(context));
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.edit,color: mainColor,),
                                              iconSize: w*0.05,
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(true,address: _list[i],)));
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(false)));
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
                  title: Text(translate(context,'address','title'), style: TextStyle(fontSize: w * 0.05, color: Colors.black,fontWeight: FontWeight.bold),),
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(false)));
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
