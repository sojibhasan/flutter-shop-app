import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/order.dart';
import 'order_info.dart';
class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(translate(context,'order','title'), style: TextStyle(fontSize: w * 0.05, color: Colors.black,fontWeight: FontWeight.bold),),
            leading: BackButton(color: Colors.black,),
            centerTitle: true,
            elevation: 0,
          ),
          body: orders.length==0?SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: h*0.1,),
                  Container(
                    width: w*0.5,
                    height: h*0.3,
                    child: SvgPicture.asset(
                      'assets/empty.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: h*0.07,),
                  Text(translate(context,'empty','empty'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.07,),),
                  Text(translate(context,'order','no_order'),style: TextStyle(fontSize: w*0.04,color: Colors.grey),),
                  SizedBox(height: h*0.07,),
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
                              child: Text(translate(context,'buttons','back'),style: TextStyle(color: Colors.white,fontSize: w*0.045,fontWeight: FontWeight.bold),),
                            ),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(height: h*0.07,),
                      ],
                    ),
                  )
                ],
              )
          ):
          ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context,i){
              return Center(
                child: Padding(
                  padding:  EdgeInsets.only(top: h*0.007,bottom: h*0.005),
                  child: InkWell(
                    child: Container(
                      width: w*0.9,
                      child: Column(
                        children: [
                          Container(
                            width: w*0.9,
                            height: h*0.11,
                            child: Row(
                              children: [
                                Container(
                                  width: w*0.17,
                                  height: h*0.09,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(orders[i].image),
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                ),
                                SizedBox(width: w*0.03,),
                                Expanded(
                                  child: Container(
                                    height: h*0.11,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Text(orders[i].title+' #'+orders[i].id.toString(),style: TextStyle(fontSize: w*0.03,fontWeight: FontWeight.bold,),),
                                          Text(orders[i].orderStatus,style: TextStyle(fontSize: w*0.03,color: mainColor,),),
                                          Text(orders[i].date,style: TextStyle(fontSize: w*0.03,color: Colors.grey),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   child: Row(
                                //     children: [
                                //       Icon(Icons.refresh,color: mainColor,size: w*0.05,),
                                //       SizedBox(width: 5,),
                                //       Text('اعادة الطلب',style: TextStyle(color: mainColor,fontSize: w*0.04,),),
                                //     ],
                                //   ),
                                //   onTap: (){
                                //     showDialog(
                                //       context: context,
                                //       barrierDismissible: false,
                                //       builder: (BuildContext context) {
                                //         return Opacity(
                                //           opacity: 0.7,
                                //           child: Container(
                                //             width: w,
                                //             height: h,
                                //             color: Colors.black12,
                                //             child: Center(
                                //               child: CircularProgressIndicator(color: mainColor,),
                                //             ),
                                //           ),
                                //         );
                                //       },
                                //     );
                                //     getOrder(orders[i].id, 2, context,orders[i]);
                                //   },
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: h*0.01,),
                          Divider(height: h*0.005,color: Colors.grey[300],),
                        ],
                      ),
                    ),
                    onTap: ()async{
                      dialog(context);
                      await getOrder(orders[i].id).then((value) {
                        if(value){
                          navPR(context, OrderInfo(orderClass: orders[i],));
                        }else{
                          navPop(context);
                          error(context);
                        }
                      });
                    },
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}
