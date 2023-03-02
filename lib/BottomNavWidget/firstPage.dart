import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/homeItem.dart';
import 'package:shop_k/models/productsCla.dart';
import 'package:shop_k/provider/address.dart';
import 'package:shop_k/provider/best_item.dart';
import 'package:shop_k/provider/cart_provider.dart';
import 'package:shop_k/provider/map.dart';
import 'package:shop_k/provider/new_item.dart';
import 'package:shop_k/provider/offer_item.dart';
import 'package:shop_k/provider/package_provider.dart';
import 'package:shop_k/provider/recommended_item.dart';
import 'package:shop_k/provider/student_provider.dart';
import 'package:shop_k/screens/cart/cart.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shop_k/screens/multiplePackages.dart';
import 'package:shop_k/screens/student/student.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin{
  TabController? _tabBar;
  // TabController? _tabBar2;
  ScrollController _controller = ScrollController();
  ScrollController _controller2 = ScrollController();
  ScrollController _controller3 = ScrollController();
  ScrollController _controller4 = ScrollController();
  ScrollController _controller5 = ScrollController();
  bool mask=false,mask2=false,mask3=false,mask4=false,mask5=false;
  bool f1=true,f2=true,f3=true,f4=true,f5=true;
  bool fi1=true,fi2=true,fi3=true,fi4=true,fi5=true,finish = false;
  void start(context){
    Provider.of<MapProvider>(context,listen: false).start();
    Provider.of<AddressProvider>(context,listen: false).getAddress();
    Provider.of<CartProvider>(context,listen: false).setItems();
    // ScrollUpHome scroll = Provider.of<ScrollUpHome>(context,listen: true);
    if(_tabBar==null){
      _tabBar = TabController(length: 5,vsync: this);
    }
    var of1 = Provider.of<NewItemProvider>(context,listen: true);
    var of2 = Provider.of<BestItemProvider>(context,listen: true);
    var of3 = Provider.of<ReItemProvider>(context,listen: true);
    var of4 = Provider.of<OfferItemProvider>(context,listen: true);
    _tabBar!.addListener(() async{
      if(_tabBar!.index==1){
        if(fi1){
          fi1=false;
          NewItemProvider newItem = Provider.of<NewItemProvider>(context,listen: false);
          if(newItem.items.isEmpty){
            dialog(context);
            await newItem.getItems();
            Navigator.pop(context);
          }
          fi1 = true;
        }
      }
      if(_tabBar!.index==2){
        if(fi2){
          fi2=false;
          BestItemProvider bestItem = Provider.of<BestItemProvider>(context,listen: false);
          if(bestItem.items.isEmpty){
            dialog(context);
            await bestItem.getItems();
            Navigator.pop(context);
          }
          fi2 = true;
        }
      }
      if(_tabBar!.index==3){
        if(fi3){
          fi3 = false;
          ReItemProvider reItem = Provider.of<ReItemProvider>(context,listen: false);
          if(reItem.items.isEmpty){
            dialog(context);
            await reItem.getItems();
            Navigator.pop(context);
          }
          fi3 = true;
        }
      }
      if(_tabBar!.index==4){
        if(fi4){
          fi4 = false;
          OfferItemProvider offerItem = Provider.of<OfferItemProvider>(context,listen: false);
          if(offerItem.items.isEmpty){
            dialog(context);
            await offerItem.getItems();
            Navigator.pop(context);
          }
          fi4 = true;
        }
      }
    });
    // _tabBar2 = TabController(length: 5,vsync: this);
    _controller.addListener(() {
      if(_controller.position.pixels>400.0&&mask==false){
        setState(() {
          mask=true;
        });
        // scroll.changeShow(0, true);
      }
      if(_controller.position.pixels<400.0&&mask==true){
        setState(() {
          mask=false;
        });
        // scroll.changeShow(0, false);
      }
    });
    _controller2.addListener(() {
      if(_controller2.position.atEdge){
        if(_controller2.position.pixels!=0){
          if(f1){
            if(!of1.finish){
              f1=false;
              dialog(context);
              of1.getItems().then((value) {
                Navigator.pop(context);
                f1 = true;
              });
            }
          }
        }
      }

      if(_controller2.position.pixels>400.0&&mask2==false){
        setState(() {
          mask2=true;
        });
        // scroll.changeShow(1, true);
      }
      if(_controller2.position.pixels<400.0&&mask2==true){
        setState(() {
          mask2=false;
        });
        // scroll.changeShow(1, false);
      }
    });
    _controller3.addListener(() {
      if(_controller3.position.atEdge){
        if(_controller3.position.pixels!=0){
          if(f2){
            if(!of2.finish){
              f2=false;
              dialog(context);
              of2.getItems().then((value) {
                Navigator.pop(context);
                f2 = true;
              });
            }
          }
        }
      }
      if(_controller3.position.pixels>400.0&&mask3==false){
        setState(() {
          mask3=true;
        });
        // scroll.changeShow(2, true);
      }
      if(_controller3.position.pixels<400.0&&mask3==true){
        setState(() {
          mask3=false;
        });
        // scroll.changeShow(2, false);
      }
    });
    _controller4.addListener(() {
      if(_controller4.position.atEdge){
        if(_controller4.position.pixels!=0){
          if(f4){
            if(!of3.finish){
              f4=false;
              dialog(context);
              of3.getItems().then((value) {
                Navigator.pop(context);
                f4 = true;
              });
            }
          }
        }
      }
      if(_controller4.position.pixels>400.0&&mask4==false){
        setState(() {
          mask4=true;
        });
        // scroll.changeShow(2, true);
      }
      if(_controller4.position.pixels<400.0&&mask4==true){
        setState(() {
          mask4=false;
        });
        // scroll.changeShow(2, false);
      }
    });
    _controller5.addListener(() {
      if(_controller5.position.atEdge){
        if(_controller5.position.pixels!=0){
          if(f5){
            if(!of4.finish){
              f5=false;
              dialog(context);
              of4.getItems().then((value) {
                Navigator.pop(context);
                f5 = true;
              });
            }
          }
        }
      }
      if(_controller5.position.pixels>400.0&&mask5==false){
        setState(() {
          mask5=true;
        });
        // scroll.changeShow(3, true);
      }
      if(_controller5.position.pixels<400.0&&mask5==true){
        setState(() {
          mask5=false;
        });
        // scroll.changeShow(3, false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    CartProvider cart = Provider.of<CartProvider>(context,listen: true);
    if(!finish){
      start(context);
      finish = true;
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              dialog(context);
              await getStudentsHome();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Student()));
            },
            backgroundColor: mainColor,
            child: Center(
              child: Icon(Icons.person,color: Colors.white,size: w*0.08,),
            ),
          ),
          appBar: AppBar(
            backgroundColor: mainColor,
            automaticallyImplyLeading: false,
            title: Container(
              width: w*0.1,
              height: w*0.1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            centerTitle: true,
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
              SizedBox(width: w*0.02,),
            ],
            bottom: PreferredSize(
              preferredSize: Size(w,h*0.07),
              child: Container(
                width: w,
                color: Colors.white,
                child: TabBar(
                  controller: _tabBar,
                  tabs: [
                    Tab(text: translate(context,'home','home'),),
                    Tab(text: translate(context,'home','new'),),
                    Tab(text: translate(context,'home','best'),),
                    Tab(text: translate(context,'home','recommendation'),),
                    Tab(text: translate(context,'home','offers'),),
                  ],
                  overlayColor: MaterialStateProperty.all(Colors.white),
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 3,
                  automaticIndicatorColorAdjustment: true,
                  labelColor: Color(0xff048fb8),
                  isScrollable: true,
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabBar,
            children: [
              // Container(
              //   width: w,
              //   height: h,
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         top: 0,
              //         bottom: 0,
              //         child: Container(
              //           width: w,
              //           height: h,
              //           child: ListView(
              //             controller: _controller,
              //             children: [
              //               Container(
              //                 width: w,
              //                 height: h*0.4,
              //                 child: Swiper(
              //                   itemBuilder: (BuildContext context, int index) {
              //                     return InkWell(
              //                       child: Container(
              //                         decoration: BoxDecoration(
              //                             image: DecorationImage(
              //                               image: AssetImage('assets/food${(index+1).toString()}.png'),
              //                               fit: BoxFit.fitHeight,
              //                             )
              //                         ),
              //                       ),
              //                       onTap: (){
              //                         Navigator.pushReplacementNamed(context, 'pro');
              //                       },
              //                     );
              //                   },
              //                   itemCount: 20,
              //                   autoplay: false,
              //                 ),
              //               ),
              //               SizedBox(height: h*0.04,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: Text('what about this product?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045),),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Container(
              //                 width: w,
              //                 height: h*0.32,
              //                 child: ListView.builder(
              //                   itemCount: 3,
              //                   scrollDirection: Axis.horizontal,
              //                   itemBuilder: (ctx,i){
              //                     return InkWell(
              //                       child: Padding(
              //                         padding:  EdgeInsets.only(left: w*0.025),
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.min,
              //                           children: [
              //                             Container(
              //                               width: w*0.4,
              //                               height: h*0.22,
              //                               decoration: BoxDecoration(
              //                                   image: DecorationImage(
              //                                     image: AssetImage('assets/food${i+1}.png'),
              //                                     fit: BoxFit.fitHeight,
              //                                   )
              //                               ),
              //                             ),
              //                             Container(
              //                               width: w*0.4,
              //                               child: Column(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 crossAxisAlignment: CrossAxisAlignment.start,
              //                                 children: [
              //                                   SizedBox(height: h*0.01,),
              //                                   Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                   SizedBox(height: h*0.005,),
              //                                   RichText(
              //                                     text: TextSpan(
              //                                       children: [
              //                                         TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                         TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       onTap: (){
              //                         Navigator.pushReplacementNamed(context, 'pro');
              //                       },
              //                     );
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.05,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: Text('Offers',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,color: mainColor),),
              //               ),
              //               SizedBox(height: h*0.01,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: Text('Offer for 24 hours',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.035,color: Colors.grey),),
              //               ),
              //               SizedBox(height: h*0.01,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: Column(
              //                   mainAxisSize: MainAxisSize.min,
              //                   children: [
              //                     Container(
              //                       width: w,
              //                       height: h*0.27,
              //                       decoration: BoxDecoration(
              //                         image: DecorationImage(
              //                           image: AssetImage('assets/food2.png'),
              //                           fit: BoxFit.fitHeight,
              //                         ),
              //                       ),
              //                       child: Stack(
              //                         children: [
              //                           Positioned(
              //                             top: 0,
              //                             left: 0,
              //                             child: Container(
              //                               color: mainColor,
              //                               child: Padding(
              //                                 padding:  EdgeInsets.all(w*0.025),
              //                                 child: Text('Products of today',style: TextStyle(color: Colors.white,fontSize: w*.03),),
              //                               ),
              //                             ),
              //                           ),
              //                           Positioned(
              //                             bottom: 0,
              //                             child: InkWell(
              //                               child: Container(
              //                                 width: w*0.95,
              //                                 height: h*0.05,
              //                                 color: mainColor,
              //                                 child: Center(
              //                                   child: Text('10:50:50 Remained',style: TextStyle(color: Colors.white,fontSize: w*0.03),),
              //                                 ),
              //                               ),
              //                               onTap: (){
              //                                 Navigator.pushReplacementNamed(context, 'pro');
              //                               },
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     Container(
              //                       width: w,
              //                       child: Column(
              //                         mainAxisSize: MainAxisSize.min,
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           SizedBox(height: h*0.01,),
              //                           Text('Products of day catch the offer',style: TextStyle(color: Colors.black,fontSize: w*0.035),),
              //                           SizedBox(height: h*0.01,),
              //                           RichText(
              //                             text: TextSpan(
              //                                 children: [
              //                                   TextSpan(text: '20.5 ${getCurrancy()} ',style: TextStyle(color: Colors.grey,fontSize: w*0.04,decoration: TextDecoration.lineThrough)),
              //                                   TextSpan(text: ' 15.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04,color: Colors.black)),
              //                                   TextSpan(text: ' 25%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: w*0.04,)),
              //                                 ]
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Container(
              //                 width: w,
              //                 color: Colors.grey[200],
              //                 child: Padding(
              //                   padding:  EdgeInsets.all(w*0.025),
              //                   child: Column(
              //                     mainAxisSize: MainAxisSize.min,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       InkWell(
              //                         child: Row(
              //                           children: [
              //                             Text('Offers',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,color: Colors.black),),
              //                             Directionality(
              //                               textDirection: TextDirection.rtl,
              //                               child: BackButton(
              //                                 onPressed: (){
              //
              //                                 },
              //                                 color: Colors.grey[400],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                         onTap: (){
              //                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Offers()));
              //                         },
              //                       ),
              //                       Column(
              //                         children: List.generate(3, (index)  {
              //                           return InkWell(
              //                             child: Padding(
              //                               padding:  EdgeInsets.only(bottom: h*0.02),
              //                               child: Container(
              //                                 width: w,
              //                                 child: Row(
              //                                   children: [
              //                                     Container(
              //                                       width: w*0.3,
              //                                       height: h*0.15,
              //                                       decoration: BoxDecoration(
              //                                         image: DecorationImage(
              //                                           image: AssetImage('assets/food${13+index}.png'),
              //                                           fit: BoxFit.fitHeight,
              //                                         ),
              //                                       ),
              //                                     ),
              //                                     SizedBox(width: w*0.05,),
              //                                     Column(
              //                                       crossAxisAlignment: CrossAxisAlignment.start,
              //                                       children: [
              //                                         Container(width: w*0.55,child: Text('Nutritious salad bowl',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04),)),
              //                                         SizedBox(height: h*0.02,),
              //                                         Container(width: w*0.55,child: Text('Description  ${(index+1).toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04,color: Colors.grey[400]),)),
              //                                       ],
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                             onTap: (){
              //                               Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Packages()));
              //                             },
              //                           );
              //                         }),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: InkWell(
              //                   child: Row(
              //                     children: [
              //                       Text('Very good price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045),),
              //                       Directionality(
              //                         textDirection: TextDirection.rtl,
              //                         child: BackButton(
              //                           onPressed: (){
              //
              //                           },
              //                           color: Colors.grey[400],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   onTap: (){
              //                     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Packages()));
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Container(
              //                 width: w,
              //                 height: h*0.32,
              //                 child: ListView.builder(
              //                   itemCount: 3,
              //                   scrollDirection: Axis.horizontal,
              //                   itemBuilder: (ctx,i){
              //                     return InkWell(
              //                       child: Padding(
              //                         padding:  EdgeInsets.only(left: w*0.025),
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.min,
              //                           children: [
              //                             Container(
              //                               width: w*0.4,
              //                               height: h*0.22,
              //                               decoration: BoxDecoration(
              //                                   image: DecorationImage(
              //                                     image: AssetImage('assets/food${4+i}.png'),
              //                                     fit: BoxFit.fitHeight,
              //                                   )
              //                               ),
              //                             ),
              //                             Container(
              //                               width: w*0.4,
              //                               child: Column(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 crossAxisAlignment: CrossAxisAlignment.start,
              //                                 children: [
              //                                   SizedBox(height: h*0.01,),
              //                                   Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                   SizedBox(height: h*0.005,),
              //                                   RichText(
              //                                     text: TextSpan(
              //                                       children: [
              //                                         TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                         TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       onTap: (){
              //                         Navigator.pushReplacementNamed(context, 'pro');
              //                       },
              //                     );
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Container(
              //                 width: w,
              //                 height: h*0.12,
              //                 decoration: BoxDecoration(
              //                     image: DecorationImage(
              //                       image: AssetImage('assets/food8.png'),
              //                       fit: BoxFit.fitWidth,
              //                     )
              //                 ),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: Text('Recommendation',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045),),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Container(
              //                 width: w,
              //                 child: DefaultTabController(
              //                   length: 5,
              //                   child: Column(
              //                     children: [
              //                       TabBar(
              //                         controller: _tabBar2,
              //                         tabs: [
              //                           Tab(text: 'Section',),
              //                           Tab(text: 'Section',),
              //                           Tab(text: 'Section',),
              //                           Tab(text: 'Section',),
              //                           Tab(text: 'Section',),
              //                         ],
              //                         overlayColor: MaterialStateProperty.all(Colors.white),
              //                         unselectedLabelColor: Colors.grey,
              //                         indicatorWeight: 3,
              //                         automaticIndicatorColorAdjustment: true,
              //                         labelColor: Color(0xff048fb8),
              //                         isScrollable: true,
              //                       ),
              //                       SizedBox(height: h*0.015,),
              //                       Container(
              //                         width: w,
              //                         height: h*0.79,
              //                         child: TabBarView(
              //                           controller: _tabBar2,
              //                           children: [
              //                             Container(
              //                               width:w,
              //                               child: Padding(
              //                                 padding:  EdgeInsets.all(w*0.015),
              //                                 child: Column(
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   children: [
              //                                     Wrap(
              //                                       children: List.generate(6, (i) {
              //                                         return InkWell(
              //                                           child: Padding(
              //                                             padding:  EdgeInsets.only(bottom: h*0.03,right: w*0.022),
              //                                             child: Column(
              //                                               mainAxisSize: MainAxisSize.min,
              //                                               children: [
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   height: h*0.2,
              //                                                   decoration: BoxDecoration(
              //                                                       image: DecorationImage(
              //                                                         image: AssetImage('assets/food${i+6}.png'),
              //                                                         fit: BoxFit.fitHeight,
              //                                                       )
              //                                                   ),
              //                                                 ),
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   child: Column(
              //                                                     mainAxisSize: MainAxisSize.min,
              //                                                     crossAxisAlignment: CrossAxisAlignment.start,
              //                                                     children: [
              //                                                       SizedBox(height: h*0.01,),
              //                                                       Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                                       SizedBox(height: h*0.005,),
              //                                                       RichText(
              //                                                         text: TextSpan(
              //                                                           children: [
              //                                                             TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                                             TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                                           ],
              //                                                         ),
              //                                                       ),
              //                                                       Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                                     ],
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                           onTap: (){
              //                                             Navigator.pushReplacementNamed(context, 'pro');
              //                                           },
              //                                         );
              //                                       }),
              //                                     ),
              //                                     SizedBox(height: h*0.01,),
              //                                     InkWell(
              //                                       child: Container(
              //                                         width: w*0.9,
              //                                         height: h*0.09,
              //                                         color: Colors.grey[200],
              //                                         child: Center(
              //                                           child: Row(
              //                                             mainAxisAlignment: MainAxisAlignment.center,
              //                                             children: [
              //                                               Text('See All',style: TextStyle(fontSize: w*0.035),),
              //                                               Directionality(
              //                                                 textDirection: TextDirection.rtl,
              //                                                 child: BackButton(
              //                                                   onPressed: (){
              //
              //                                                   },
              //                                                   color: Colors.grey[400],
              //                                                 ),
              //                                               ),
              //                                             ],
              //                                           ),
              //                                         ),
              //                                       ),
              //                                       onTap: (){
              //                                         Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages()));
              //                                       },
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                             Container(
              //                               width:w,
              //                               child: Padding(
              //                                 padding:  EdgeInsets.all(w*0.015),
              //                                 child: Column(
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   children: [
              //                                     Wrap(
              //                                       children: List.generate(6, (i) {
              //                                         return InkWell(
              //                                           child: Padding(
              //                                             padding:  EdgeInsets.only(bottom: h*0.03,right: w*0.022),
              //                                             child: Column(
              //                                               mainAxisSize: MainAxisSize.min,
              //                                               children: [
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   height: h*0.2,
              //                                                   decoration: BoxDecoration(
              //                                                       image: DecorationImage(
              //                                                         image: AssetImage('assets/food${i+6}.png'),
              //                                                         fit: BoxFit.fitHeight,
              //                                                       )
              //                                                   ),
              //                                                 ),
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   child: Column(
              //                                                     mainAxisSize: MainAxisSize.min,
              //                                                     crossAxisAlignment: CrossAxisAlignment.start,
              //                                                     children: [
              //                                                       SizedBox(height: h*0.01,),
              //                                                       Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                                       SizedBox(height: h*0.005,),
              //                                                       RichText(
              //                                                         text: TextSpan(
              //                                                           children: [
              //                                                             TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                                             TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                                           ],
              //                                                         ),
              //                                                       ),
              //                                                       Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                                     ],
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                           onTap: (){
              //                                             Navigator.pushReplacementNamed(context, 'pro');
              //                                           },
              //                                         );
              //                                       }),
              //                                     ),
              //                                     SizedBox(height: h*0.01,),
              //                                     InkWell(
              //                                       child: Container(
              //                                         width: w*0.9,
              //                                         height: h*0.09,
              //                                         color: Colors.grey[200],
              //                                         child: Center(
              //                                           child: Row(
              //                                             mainAxisAlignment: MainAxisAlignment.center,
              //                                             children: [
              //                                               Text('See All',style: TextStyle(fontSize: w*0.035),),
              //                                               Directionality(
              //                                                 textDirection: TextDirection.rtl,
              //                                                 child: BackButton(
              //                                                   onPressed: (){
              //
              //                                                   },
              //                                                   color: Colors.grey[400],
              //                                                 ),
              //                                               ),
              //                                             ],
              //                                           ),
              //                                         ),
              //                                       ),
              //                                       onTap: (){
              //                                         Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages()));
              //                                       },
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                             Container(
              //                               width:w,
              //                               child: Padding(
              //                                 padding:  EdgeInsets.all(w*0.015),
              //                                 child: Column(
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   children: [
              //                                     Wrap(
              //                                       children: List.generate(6, (i) {
              //                                         return InkWell(
              //                                           child: Padding(
              //                                             padding:  EdgeInsets.only(bottom: h*0.03,right: w*0.022),
              //                                             child: Column(
              //                                               mainAxisSize: MainAxisSize.min,
              //                                               children: [
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   height: h*0.2,
              //                                                   decoration: BoxDecoration(
              //                                                       image: DecorationImage(
              //                                                         image: AssetImage('assets/food${i+6}.png'),
              //                                                         fit: BoxFit.fitHeight,
              //                                                       )
              //                                                   ),
              //                                                 ),
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   child: Column(
              //                                                     mainAxisSize: MainAxisSize.min,
              //                                                     crossAxisAlignment: CrossAxisAlignment.start,
              //                                                     children: [
              //                                                       SizedBox(height: h*0.01,),
              //                                                       Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                                       SizedBox(height: h*0.005,),
              //                                                       RichText(
              //                                                         text: TextSpan(
              //                                                           children: [
              //                                                             TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                                             TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                                           ],
              //                                                         ),
              //                                                       ),
              //                                                       Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                                     ],
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                           onTap: (){
              //                                             Navigator.pushReplacementNamed(context, 'pro');
              //                                           },
              //                                         );
              //                                       }),
              //                                     ),
              //                                     SizedBox(height: h*0.01,),
              //                                     InkWell(
              //                                       child: Container(
              //                                         width: w*0.9,
              //                                         height: h*0.09,
              //                                         color: Colors.grey[200],
              //                                         child: Center(
              //                                           child: Row(
              //                                             mainAxisAlignment: MainAxisAlignment.center,
              //                                             children: [
              //                                               Text('See All',style: TextStyle(fontSize: w*0.035),),
              //                                               Directionality(
              //                                                 textDirection: TextDirection.rtl,
              //                                                 child: BackButton(
              //                                                   onPressed: (){
              //
              //                                                   },
              //                                                   color: Colors.grey[400],
              //                                                 ),
              //                                               ),
              //                                             ],
              //                                           ),
              //                                         ),
              //                                       ),
              //                                       onTap: (){
              //                                         Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages()));
              //                                       },
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                             Container(
              //                               width:w,
              //                               child: Padding(
              //                                 padding:  EdgeInsets.all(w*0.015),
              //                                 child: Column(
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   children: [
              //                                     Wrap(
              //                                       children: List.generate(6, (i) {
              //                                         return InkWell(
              //                                           child: Padding(
              //                                             padding:  EdgeInsets.only(bottom: h*0.03,right: w*0.022),
              //                                             child: Column(
              //                                               mainAxisSize: MainAxisSize.min,
              //                                               children: [
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   height: h*0.2,
              //                                                   decoration: BoxDecoration(
              //                                                       image: DecorationImage(
              //                                                         image: AssetImage('assets/food${i+6}.png'),
              //                                                         fit: BoxFit.fitHeight,
              //                                                       )
              //                                                   ),
              //                                                 ),
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   child: Column(
              //                                                     mainAxisSize: MainAxisSize.min,
              //                                                     crossAxisAlignment: CrossAxisAlignment.start,
              //                                                     children: [
              //                                                       SizedBox(height: h*0.01,),
              //                                                       Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                                       SizedBox(height: h*0.005,),
              //                                                       RichText(
              //                                                         text: TextSpan(
              //                                                           children: [
              //                                                             TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                                             TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                                           ],
              //                                                         ),
              //                                                       ),
              //                                                       Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                                     ],
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                           onTap: (){
              //                                             Navigator.pushReplacementNamed(context, 'pro');
              //                                           },
              //                                         );
              //                                       }),
              //                                     ),
              //                                     SizedBox(height: h*0.01,),
              //                                     InkWell(
              //                                       child: Container(
              //                                         width: w*0.9,
              //                                         height: h*0.09,
              //                                         color: Colors.grey[200],
              //                                         child: Center(
              //                                           child: Row(
              //                                             mainAxisAlignment: MainAxisAlignment.center,
              //                                             children: [
              //                                               Text('See All',style: TextStyle(fontSize: w*0.035),),
              //                                               Directionality(
              //                                                 textDirection: TextDirection.rtl,
              //                                                 child: BackButton(
              //                                                   onPressed: (){
              //
              //                                                   },
              //                                                   color: Colors.grey[400],
              //                                                 ),
              //                                               ),
              //                                             ],
              //                                           ),
              //                                         ),
              //                                       ),
              //                                       onTap: (){
              //                                         Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages()));
              //                                       },
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                             Container(
              //                               width:w,
              //                               child: Padding(
              //                                 padding:  EdgeInsets.all(w*0.015),
              //                                 child: Column(
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   children: [
              //                                     Wrap(
              //                                       children: List.generate(6, (i) {
              //                                         return InkWell(
              //                                           child: Padding(
              //                                             padding:  EdgeInsets.only(bottom: h*0.03,right: w*0.022),
              //                                             child: Column(
              //                                               mainAxisSize: MainAxisSize.min,
              //                                               children: [
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   height: h*0.2,
              //                                                   decoration: BoxDecoration(
              //                                                       image: DecorationImage(
              //                                                         image: AssetImage('assets/food${i+6}.png'),
              //                                                         fit: BoxFit.fitHeight,
              //                                                       )
              //                                                   ),
              //                                                 ),
              //                                                 Container(
              //                                                   width: w*0.3,
              //                                                   child: Column(
              //                                                     mainAxisSize: MainAxisSize.min,
              //                                                     crossAxisAlignment: CrossAxisAlignment.start,
              //                                                     children: [
              //                                                       SizedBox(height: h*0.01,),
              //                                                       Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                                       SizedBox(height: h*0.005,),
              //                                                       RichText(
              //                                                         text: TextSpan(
              //                                                           children: [
              //                                                             TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                                             TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                                           ],
              //                                                         ),
              //                                                       ),
              //                                                       Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                                     ],
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                           onTap: (){
              //                                             Navigator.pushReplacementNamed(context, 'pro');
              //                                           },
              //                                         );
              //                                       }),
              //                                     ),
              //                                     SizedBox(height: h*0.01,),
              //                                     InkWell(
              //                                       child: Container(
              //                                         width: w*0.9,
              //                                         height: h*0.09,
              //                                         color: Colors.grey[200],
              //                                         child: Center(
              //                                           child: Row(
              //                                             mainAxisAlignment: MainAxisAlignment.center,
              //                                             children: [
              //                                               Text('See All',style: TextStyle(fontSize: w*0.035),),
              //                                               Directionality(
              //                                                 textDirection: TextDirection.rtl,
              //                                                 child: BackButton(
              //                                                   onPressed: (){
              //
              //                                                   },
              //                                                   color: Colors.grey[400],
              //                                                 ),
              //                                               ),
              //                                             ],
              //                                           ),
              //                                         ),
              //                                       ),
              //                                       onTap: (){
              //                                         Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages()));
              //                                       },
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Container(
              //                 width: w,
              //                 height: h*0.1,
              //                 color: Color(0xfff4e7df),
              //                 child: Center(
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       Text('See All Offers Daily',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04,color: Colors.red[900]),),
              //                       Text('Don`t miss it',style: TextStyle(fontSize: w*0.04,color: Colors.red[900]),),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: InkWell(
              //                   child: Row(
              //                     children: [
              //                       Text('Very good price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045),),
              //                       Directionality(
              //                         textDirection: TextDirection.rtl,
              //                         child: BackButton(
              //                           onPressed: (){
              //
              //                           },
              //                           color: Colors.grey[400],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   onTap: (){
              //                     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Packages()));
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Container(
              //                 width: w,
              //                 height: h*0.32,
              //                 child: ListView.builder(
              //                   itemCount: 5,
              //                   scrollDirection: Axis.horizontal,
              //                   itemBuilder: (ctx,i){
              //                     return InkWell(
              //                       child: Padding(
              //                         padding:  EdgeInsets.only(left: w*0.025),
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.min,
              //                           children: [
              //                             Container(
              //                               width: w*0.4,
              //                               height: h*0.22,
              //                               decoration: BoxDecoration(
              //                                   image: DecorationImage(
              //                                     image: AssetImage('assets/food${5+i}.png'),
              //                                     fit: BoxFit.fitHeight,
              //                                   )
              //                               ),
              //                             ),
              //                             Container(
              //                               width: w*0.4,
              //                               child: Column(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 crossAxisAlignment: CrossAxisAlignment.start,
              //                                 children: [
              //                                   SizedBox(height: h*0.01,),
              //                                   Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                   SizedBox(height: h*0.005,),
              //                                   RichText(
              //                                     text: TextSpan(
              //                                       children: [
              //                                         TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                         TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       onTap: (){
              //                         Navigator.pushReplacementNamed(context, 'pro');
              //                       },
              //                     );
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: InkWell(
              //                   child: Row(
              //                     children: [
              //                       Text('Very good price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045),),
              //                       Directionality(
              //                         textDirection: TextDirection.rtl,
              //                         child: BackButton(
              //                           onPressed: (){
              //
              //                           },
              //                           color: Colors.grey[400],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   onTap: (){
              //                     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Packages()));
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Container(
              //                 width: w,
              //                 height: h*0.32,
              //                 child: ListView.builder(
              //                   itemCount: 7,
              //                   scrollDirection: Axis.horizontal,
              //                   itemBuilder: (ctx,i){
              //                     return InkWell(
              //                       child: Padding(
              //                         padding:  EdgeInsets.only(left: w*0.025),
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.min,
              //                           children: [
              //                             Container(
              //                               width: w*0.4,
              //                               height: h*0.22,
              //                               decoration: BoxDecoration(
              //                                   image: DecorationImage(
              //                                     image: AssetImage('assets/food${12+i}.png'),
              //                                     fit: BoxFit.fitHeight,
              //                                   )
              //                               ),
              //                             ),
              //                             Container(
              //                               width: w*0.4,
              //                               child: Column(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 crossAxisAlignment: CrossAxisAlignment.start,
              //                                 children: [
              //                                   SizedBox(height: h*0.01,),
              //                                   Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                   SizedBox(height: h*0.005,),
              //                                   RichText(
              //                                     text: TextSpan(
              //                                       children: [
              //                                         TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                         TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       onTap: (){
              //                         Navigator.pushReplacementNamed(context, 'pro');
              //                       },
              //                     );
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: InkWell(
              //                   child: Row(
              //                     children: [
              //                       Text('Very good price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045),),
              //                       Directionality(
              //                         textDirection: TextDirection.rtl,
              //                         child: BackButton(
              //                           onPressed: (){
              //
              //                           },
              //                           color: Colors.grey[400],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   onTap: (){
              //                     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Packages()));
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Container(
              //                 width: w,
              //                 height: h*0.32,
              //                 child: ListView.builder(
              //                   itemCount: 5,
              //                   scrollDirection: Axis.horizontal,
              //                   itemBuilder: (ctx,i){
              //                     return Padding(
              //                       padding:  EdgeInsets.only(left: w*0.025),
              //                       child: Column(
              //                         mainAxisSize: MainAxisSize.min,
              //                         children: [
              //                           Container(
              //                             width: w*0.4,
              //                             height: h*0.22,
              //                             decoration: BoxDecoration(
              //                                 image: DecorationImage(
              //                                   image: AssetImage('assets/food${14+i}.png'),
              //                                   fit: BoxFit.fitHeight,
              //                                 )
              //                             ),
              //                           ),
              //                           Container(
              //                             width: w*0.4,
              //                             child: Column(
              //                               mainAxisSize: MainAxisSize.min,
              //                               crossAxisAlignment: CrossAxisAlignment.start,
              //                               children: [
              //                                 SizedBox(height: h*0.01,),
              //                                 Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                 SizedBox(height: h*0.005,),
              //                                 RichText(
              //                                   text: TextSpan(
              //                                     children: [
              //                                       TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                       TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                     ],
              //                                   ),
              //                                 ),
              //                                 Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                               ],
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     );
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: InkWell(
              //                   child: Row(
              //                     children: [
              //                       Text('Very good price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045),),
              //                       Directionality(
              //                         textDirection: TextDirection.rtl,
              //                         child: BackButton(
              //                           onPressed: (){
              //
              //                           },
              //                           color: Colors.grey[400],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   onTap: (){
              //                     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Packages()));
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Container(
              //                 width: w,
              //                 height: h*0.32,
              //                 child: ListView.builder(
              //                   itemCount: 7,
              //                   scrollDirection: Axis.horizontal,
              //                   itemBuilder: (ctx,i){
              //                     return InkWell(
              //                       child: Padding(
              //                         padding:  EdgeInsets.only(left: w*0.025),
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.min,
              //                           children: [
              //                             Container(
              //                               width: w*0.4,
              //                               height: h*0.22,
              //                               decoration: BoxDecoration(
              //                                   image: DecorationImage(
              //                                     image: AssetImage('assets/food${3+i}.png'),
              //                                     fit: BoxFit.fitHeight,
              //                                   )
              //                               ),
              //                             ),
              //                             Container(
              //                               width: w*0.4,
              //                               child: Column(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 crossAxisAlignment: CrossAxisAlignment.start,
              //                                 children: [
              //                                   SizedBox(height: h*0.01,),
              //                                   Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                   SizedBox(height: h*0.005,),
              //                                   RichText(
              //                                     text: TextSpan(
              //                                       children: [
              //                                         TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                         TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     );
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.03,),
              //               Padding(
              //                 padding:  EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: InkWell(
              //                   child: Row(
              //                     children: [
              //                       Text('Very good price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045),),
              //                       Directionality(
              //                         textDirection: TextDirection.rtl,
              //                         child: BackButton(
              //                           onPressed: (){
              //
              //                           },
              //                           color: Colors.grey[400],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   onTap: (){
              //                     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Packages()));
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Container(
              //                 width: w,
              //                 height: h*0.3,
              //                 child: ListView.builder(
              //                   itemCount: 8,
              //                   scrollDirection: Axis.horizontal,
              //                   itemBuilder: (ctx,i){
              //                     return InkWell(
              //                       child: Padding(
              //                         padding:  EdgeInsets.only(left: w*0.025),
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.min,
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           children: [
              //                             Container(
              //                               width: w*0.6,
              //                               height: h*0.2,
              //                               decoration: BoxDecoration(
              //                                   image: DecorationImage(
              //                                     image: AssetImage('assets/food${6+i}.png'),
              //                                     fit: BoxFit.fitHeight,
              //                                   )
              //                               ),
              //                             ),
              //                             SizedBox(height: h*0.01,),
              //                             Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                             // Container(
              //                             //   width: w*0.4,
              //                             //   child: Column(
              //                             //     mainAxisSize: MainAxisSize.min,
              //                             //     crossAxisAlignment: CrossAxisAlignment.start,
              //                             //     children: [
              //                             //       SizedBox(height: h*0.01,),
              //                             //       Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                             //       SizedBox(height: h*0.005,),
              //                             //       RichText(
              //                             //         text: TextSpan(
              //                             //           children: [
              //                             //             TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                             //             TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                             //           ],
              //                             //         ),
              //                             //       ),
              //                             //       Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                             //     ],
              //                             //   ),
              //                             // ),
              //                           ],
              //                         ),
              //                       ),
              //                       onTap: (){
              //                         Navigator.pushReplacementNamed(context, 'pro');
              //                       },
              //                     );
              //                   },
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Container(
              //                 width: w,
              //                 height: h*0.12,
              //                 decoration: BoxDecoration(
              //                     image: DecorationImage(
              //                       image: AssetImage('assets/food6.png'),
              //                       fit: BoxFit.fitWidth,
              //                     )
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: Container(
              //                   width: w,
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text('Some Information',style: TextStyle(color: Colors.red,fontSize: w*0.035),),
              //                       Text('Some Information',style: TextStyle(color: Colors.grey,fontSize: w*0.035),),
              //                       Text('Some Information',style: TextStyle(color: Colors.grey,fontSize: w*0.035),),
              //                       Text('Some Information',style: TextStyle(color: Colors.grey,fontSize: w*0.035),),
              //                       Text('Some Information',style: TextStyle(color: Colors.grey,fontSize: w*0.035),),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(horizontal: w*0.025),
              //                 child: Container(
              //                   child: Row(
              //                     children: [
              //                       CircleAvatar(
              //                         radius: w*0.04,
              //                         backgroundColor: Colors.red,
              //                       ),
              //                       SizedBox(width: w*0.02,),
              //                       CircleAvatar(
              //                         radius: w*0.04,
              //                         backgroundColor: Colors.lightBlueAccent,
              //                       ),
              //                       SizedBox(width: w*0.02,),
              //                       CircleAvatar(
              //                         radius: w*0.04,
              //                         backgroundColor: Colors.greenAccent,
              //                       ),
              //                       SizedBox(width: w*0.02,),
              //                       CircleAvatar(
              //                         radius: w*0.04,
              //                         backgroundColor: Colors.greenAccent,
              //                       ),
              //                       SizedBox(width: w*0.02,),
              //                       CircleAvatar(
              //                         radius: w*0.04,
              //                         backgroundColor: Colors.red,
              //                       ),
              //                       SizedBox(width: w*0.02,),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(height: h*0.02,),
              //             ],
              //           ),
              //         ),
              //       ),
              //       mask?Positioned(
              //         bottom: h*0.03,
              //         right: w*0.08,
              //         child: CircleAvatar(
              //           radius: w*0.06,
              //           backgroundColor: mainColor.withOpacity(0.7),
              //           child: InkWell(
              //             child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.white,)),
              //             onTap: (){
              //               _controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.bounceOut);
              //             },
              //           ),
              //         ),
              //       ):
              //       SizedBox(),
              //     ],
              //   ),
              // ),
              Container(
                width: w,
                height: h,
                child: Stack(
                  children: [
                    Container(
                      width: w,
                      height: h,
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(slider.isNotEmpty)Container(
                              width: w,
                              height: h*0.4,
                              child: Swiper(
                                itemBuilder: (BuildContext context, int i) {
                                  return InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                          image: DecorationImage(
                                            image: NetworkImage(slider[i].image),
                                            fit: BoxFit.fitWidth,
                                          ),
                                      ),
                                    ),
                                    focusColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    // overlayColor: ,
                                    onTap: ()async{
                                      if(slider[i].inApp){
                                        if(slider[i].type){
                                          dialog(context);
                                          await getItem(int.parse(slider[i].link));
                                          Navigator.pushReplacementNamed(context, 'pro');
                                        }else{
                                          dialog(context);
                                          Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                          Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                          Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                          await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(slider[i].link));
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(slider[i].link),)));
                                        }
                                      }else{
                                        await canLaunch(slider[i].link) ? await launch(slider[i].link) : throw 'Could not launch ${slider[i].link}';
                                      }
                                    },
                                  );
                                },
                                itemCount: slider.length,
                                autoplay: true,
                                autoplayDelay: 5000,
                              ),
                            ),
                            SizedBox(height: h*0.01,),
                            if(offerEnd.isNotEmpty)Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: w*0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(translate(context,'home','title1'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,fontFamily: 'Tajawal'),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h*0.01,),
                                Container(
                                  width: w,
                                  height: h*0.38,
                                  child: ListView.builder(
                                    itemCount: offerEnd.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx,i){
                                      return InkWell(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: w*0.025),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: w*0.4,
                                                height: h*0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    image: DecorationImage(
                                                      image: NetworkImage(offerEnd[i].image),
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                ),
                                              ),
                                              Container(
                                                width: w*0.4,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: h*0.01,),
                                                    Container(constraints: BoxConstraints(
                                                      maxHeight: h*0.07,
                                                    ),child: Text(translateString(offerEnd[i].nameEn, offerEnd[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                    SizedBox(height: h*0.005,),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          if(offerEnd[i].isSale)TextSpan(text: '${offerEnd[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(!offerEnd[i].isSale)TextSpan(text: '${offerEnd[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(offerEnd[i].isSale&&offerEnd[i].disPer!=null)TextSpan(text: offerEnd[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                        ],
                                                      ),
                                                    ),
                                                    if(offerEnd[i].isSale)Text('${offerEnd[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: ()async{
                                          dialog(context);
                                          await getItem(offerEnd[i].id);
                                          Navigator.pushReplacementNamed(context, 'pro');
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // if(checkPosition(1))SizedBox(height: h*0.01,),
                            // if(checkPosition(1))InkWell(
                            //   child: Container(
                            //     width: w,
                            //     height: h*0.15,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: NetworkImage(getAdsPosition(1).image),
                            //           fit: BoxFit.fitWidth,
                            //         ),
                            //     ),
                            //   ),
                            //   focusColor: Colors.transparent,
                            //   splashColor: Colors.transparent,
                            //   highlightColor: Colors.transparent,
                            //   onTap: ()async{
                            //     Ads _ads = getAdsPosition(1);
                            //     if(_ads.inApp){
                            //       if(_ads.type){
                            //         dialog(context);
                            //         await getItem(int.parse(_ads.link));
                            //         Navigator.pushReplacementNamed(context, 'pro');
                            //       }else{
                            //         dialog(context);
                            //         Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                            //         await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
                            //       }
                            //     }
                            //   },
                            // ),
                            if(getAds(1).isNotEmpty)SizedBox(height: h*0.01,),
                            if(getAds(1).isNotEmpty)SizedBox(
                              height: h*0.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.025),
                                child: Swiper(
                                  itemCount: getAds(1).length,
                                  itemBuilder: (BuildContext context, int i) {
                                    Ads _ads = getAds(1)[i];
                                    return InkWell(
                                      child: Container(
                                        width: w*0.95,
                                        height: h*0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(_ads.image),
                                            fit: BoxFit.fitWidth,
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
                                          }else{
                                            dialog(context);
                                            Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                            await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
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
                            ),
                            SizedBox(height: h*0.01,),
                            if(newItem.isNotEmpty)Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: w*0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(translate(context,'home','title2'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,fontFamily: 'Tajawal'),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h*0.01,),
                                Container(
                                  width: w,
                                  height: h*0.38,
                                  child: ListView.builder(
                                    itemCount: newItem.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx,i){
                                      return InkWell(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: w*0.025),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: w*0.4,
                                                height: h*0.25,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  image: DecorationImage(
                                                    image: NetworkImage(newItem[i].image),
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: w*0.4,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: h*0.01,),
                                                    Container(constraints: BoxConstraints(
                                                      maxHeight: h*0.07,
                                                    ),child: Text(translateString(newItem[i].nameEn,newItem[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                    SizedBox(height: h*0.005,),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          if(newItem[i].isSale)TextSpan(text: '${newItem[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(!newItem[i].isSale)TextSpan(text: '${newItem[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(newItem[i].isSale&&newItem[i].disPer!=null)TextSpan(text: newItem[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                        ],
                                                      ),
                                                    ),
                                                    if(newItem[i].isSale)Text('${newItem[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: ()async{
                                          dialog(context);
                                          await getItem(newItem[i].id);
                                          Navigator.pushReplacementNamed(context, 'pro');
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // if(checkPosition(2))SizedBox(height: h*0.01,),
                            // if(checkPosition(2))InkWell(
                            //   child: Container(
                            //     width: w,
                            //     height: h*0.15,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: NetworkImage(getAdsPosition(2).image),
                            //           fit: BoxFit.fitWidth,
                            //         )
                            //     ),
                            //   ),
                            //   focusColor: Colors.transparent,
                            //   splashColor: Colors.transparent,
                            //   highlightColor: Colors.transparent,
                            //   onTap: ()async{
                            //     Ads _ads = getAdsPosition(2);
                            //     if(_ads.inApp){
                            //       if(_ads.type){
                            //         dialog(context);
                            //         await getItem(int.parse(_ads.link));
                            //         Navigator.pushReplacementNamed(context, 'pro');
                            //       }else{
                            //         dialog(context);
                            //         Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                            //         await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
                            //       }
                            //     }
                            //   },
                            // ),
                            if(getAds(2).isNotEmpty)SizedBox(height: h*0.01,),
                            if(getAds(2).isNotEmpty)SizedBox(
                              height: h*0.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.025),
                                child: Swiper(
                                  itemCount: getAds(2).length,
                                  itemBuilder: (BuildContext context, int i) {
                                    Ads _ads = getAds(2)[i];
                                    return InkWell(
                                      child: Container(
                                        width: w*0.95,
                                        height: h*0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(_ads.image),
                                            fit: BoxFit.fitWidth,
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
                                          }else{
                                            dialog(context);
                                            Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                            await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
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
                            ),
                            SizedBox(height: h*0.01,),
                            if(bestItem.isNotEmpty)Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: w*0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(translate(context,'home','title3'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,fontFamily: 'Tajawal'),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h*0.01,),
                                Container(
                                  width: w,
                                  height: h*0.38,
                                  child: ListView.builder(
                                    itemCount: bestItem.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx,i){
                                      return InkWell(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: w*0.025),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: w*0.4,
                                                height: h*0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    image: DecorationImage(
                                                      image: NetworkImage(bestItem[i].image),
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                ),
                                              ),
                                              Container(
                                                width: w*0.4,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: h*0.01,),
                                                    Container(constraints: BoxConstraints(
                                                      maxHeight: h*0.07,
                                                    ),child: Text(translateString(bestItem[i].nameEn,bestItem[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                    SizedBox(height: h*0.005,),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          if(bestItem[i].isSale)TextSpan(text: '${bestItem[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(!bestItem[i].isSale)TextSpan(text: '${bestItem[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(bestItem[i].isSale&&bestItem[i].disPer!=null)TextSpan(text: bestItem[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                        ],
                                                      ),
                                                    ),
                                                    if(bestItem[i].isSale)Text('${bestItem[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: ()async{
                                          dialog(context);
                                          await getItem(bestItem[i].id);
                                          Navigator.pushReplacementNamed(context, 'pro');
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // if(checkPosition(3))SizedBox(height: h*0.01,),
                            // if(checkPosition(3))InkWell(
                            //   child: Container(
                            //     width: w,
                            //     height: h*0.15,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: NetworkImage(getAdsPosition(3).image),
                            //           fit: BoxFit.fitWidth,
                            //         )
                            //     ),
                            //   ),
                            //   focusColor: Colors.transparent,
                            //   splashColor: Colors.transparent,
                            //   highlightColor: Colors.transparent,
                            //   onTap: ()async{
                            //     Ads _ads = getAdsPosition(3);
                            //     if(_ads.inApp){
                            //       if(_ads.type){
                            //         dialog(context);
                            //         await getItem(int.parse(_ads.link));
                            //         Navigator.pushReplacementNamed(context, 'pro');
                            //       }else{
                            //         dialog(context);
                            //         Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                            //         await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
                            //       }
                            //     }
                            //   },
                            // ),
                            if(getAds(3).isNotEmpty)SizedBox(height: h*0.01,),
                            if(getAds(3).isNotEmpty)SizedBox(
                              height: h*0.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.025),
                                child: Swiper(
                                  itemCount: getAds(3).length,
                                  itemBuilder: (BuildContext context, int i) {
                                    Ads _ads = getAds(3)[i];
                                    return InkWell(
                                      child: Container(
                                        width: w*0.95,
                                        height: h*0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(_ads.image),
                                            fit: BoxFit.fitWidth,
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
                                          }else{
                                            dialog(context);
                                            Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                            await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
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
                            ),
                            SizedBox(height: h*0.01,),
                            if(reItem.isNotEmpty)Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: w*0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(translate(context,'home','title4'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,fontFamily: 'Tajawal'),),
                                      // InkWell(
                                      //   child: Container(
                                      //     child: Row(
                                      //       children: [
                                      //         Text('See All',style: TextStyle(fontSize: w*0.035,color: mainColor),),
                                      //         Directionality(
                                      //           textDirection: TextDirection.rtl,
                                      //           child: BackButton(
                                      //             onPressed: (){
                                      //
                                      //             },
                                      //             color: mainColor,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      //   onTap: (){
                                      //     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Packages()));
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h*0.01,),
                                Container(
                                  width: w,
                                  height: h*0.38,
                                  child: ListView.builder(
                                    itemCount: reItem.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx,i){
                                      return InkWell(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: w*0.025),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: w*0.4,
                                                height: h*0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    image: DecorationImage(
                                                      image: NetworkImage(reItem[i].image),
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                ),
                                              ),
                                              Container(
                                                width: w*0.4,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: h*0.01,),
                                                    Container(constraints: BoxConstraints(
                                                      maxHeight: h*0.07,
                                                    ),child: Text(translateString(reItem[i].nameEn,reItem[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                    SizedBox(height: h*0.005,),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          if(reItem[i].isSale)TextSpan(text: '${reItem[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(!reItem[i].isSale)TextSpan(text: '${reItem[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(reItem[i].isSale&&reItem[i].disPer!=null)TextSpan(text: reItem[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                        ],
                                                      ),
                                                    ),
                                                    if(reItem[i].isSale)Text('${reItem[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: ()async{
                                          dialog(context);
                                          await getItem(reItem[i].id);
                                          Navigator.pushReplacementNamed(context, 'pro');
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // if(checkPosition(4))SizedBox(height: h*0.01,),
                            // if(checkPosition(4))InkWell(
                            //   child: Container(
                            //     width: w,
                            //     height: h*0.15,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: NetworkImage(getAdsPosition(4).image),
                            //           fit: BoxFit.fitWidth,
                            //         )
                            //     ),
                            //   ),
                            //   focusColor: Colors.transparent,
                            //   splashColor: Colors.transparent,
                            //   highlightColor: Colors.transparent,
                            //   onTap: ()async{
                            //     Ads _ads = getAdsPosition(4);
                            //     if(_ads.inApp){
                            //       if(_ads.type){
                            //         dialog(context);
                            //         await getItem(int.parse(_ads.link));
                            //         Navigator.pushReplacementNamed(context, 'pro');
                            //       }else{
                            //         dialog(context);
                            //         Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                            //         await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
                            //       }
                            //     }
                            //   },
                            // ),
                            if(getAds(4).isNotEmpty)SizedBox(height: h*0.01,),
                            if(getAds(4).isNotEmpty)SizedBox(
                              height: h*0.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.025),
                                child: Swiper(
                                  itemCount: getAds(4).length,
                                  itemBuilder: (BuildContext context, int i) {
                                    Ads _ads = getAds(4)[i];
                                    return InkWell(
                                      child: Container(
                                        width: w*0.95,
                                        height: h*0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(_ads.image),
                                            fit: BoxFit.fitWidth,
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
                                          }else{
                                            dialog(context);
                                            Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                            await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
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
                            ),
                            SizedBox(height: h*0.01,),
                            if(bestDis.isNotEmpty)Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: w*0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(translate(context,'home','title5'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,fontFamily: 'Tajawal'),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h*0.01,),
                                Container(
                                  width: w,
                                  height: h*0.38,
                                  child: ListView.builder(
                                    itemCount: bestDis.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx,i){
                                      return InkWell(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: w*0.025),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: w*0.4,
                                                height: h*0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    image: DecorationImage(
                                                      image: NetworkImage(bestDis[i].image),
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                ),
                                              ),
                                              Container(
                                                width: w*0.4,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: h*0.01,),
                                                    Container(constraints: BoxConstraints(
                                                      maxHeight: h*0.07,
                                                    ),child: Text(translateString(bestDis[i].nameEn,bestDis[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                    SizedBox(height: h*0.005,),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          if(bestDis[i].isSale)TextSpan(text: '${bestDis[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(!bestDis[i].isSale)TextSpan(text: '${bestDis[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(bestDis[i].isSale&&bestDis[i].disPer!=null)TextSpan(text: bestDis[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                        ],
                                                      ),
                                                    ),
                                                    if(bestDis[i].isSale)Text('${bestDis[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: ()async{
                                          dialog(context);
                                          await getItem(bestDis[i].id);
                                          Navigator.pushReplacementNamed(context, 'pro');
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // if(checkPosition(5))SizedBox(height: h*0.01,),
                            // if(checkPosition(5))InkWell(
                            //   child: Container(
                            //     width: w,
                            //     height: h*0.15,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: NetworkImage(getAdsPosition(5).image),
                            //           fit: BoxFit.fitWidth,
                            //         )
                            //     ),
                            //   ),
                            //   focusColor: Colors.transparent,
                            //   splashColor: Colors.transparent,
                            //   highlightColor: Colors.transparent,
                            //   onTap: ()async{
                            //     Ads _ads = getAdsPosition(5);
                            //     if(_ads.inApp){
                            //       if(_ads.type){
                            //         dialog(context);
                            //         await getItem(int.parse(_ads.link));
                            //         Navigator.pushReplacementNamed(context, 'pro');
                            //       }else{
                            //         dialog(context);
                            //         Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                            //         await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
                            //       }
                            //     }
                            //   },
                            // ),
                            if(getAds(5).isNotEmpty)SizedBox(height: h*0.01,),
                            if(getAds(5).isNotEmpty)SizedBox(
                              height: h*0.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.025),
                                child: Swiper(
                                  itemCount: getAds(5).length,
                                  itemBuilder: (BuildContext context, int i) {
                                    Ads _ads = getAds(5)[i];
                                    return InkWell(
                                      child: Container(
                                        width: w*0.95,
                                        height: h*0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(_ads.image),
                                            fit: BoxFit.fitWidth,
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
                                          }else{
                                            dialog(context);
                                            Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                            await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
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
                            ),
                            SizedBox(height: h*0.01,),
                            if(bestPrice.isNotEmpty)Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: w*0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(translate(context,'home','title6'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,fontFamily: 'Tajawal'),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h*0.01,),
                                Container(
                                  width: w,
                                  height: h*0.38,
                                  child: ListView.builder(
                                    itemCount: bestPrice.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx,i){
                                      return InkWell(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: w*0.025),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: w*0.4,
                                                height: h*0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    image: DecorationImage(
                                                      image: NetworkImage(bestPrice[i].image),
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                ),
                                              ),
                                              Container(
                                                width: w*0.4,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: h*0.01,),
                                                    Container(constraints: BoxConstraints(
                                                      maxHeight: h*0.07,
                                                    ),child: Text(translateString(bestPrice[i].nameEn,bestPrice[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                    SizedBox(height: h*0.005,),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          if(bestPrice[i].isSale)TextSpan(text: '${bestPrice[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(!bestPrice[i].isSale)TextSpan(text: '${bestPrice[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(bestPrice[i].isSale&&bestPrice[i].disPer!=null)TextSpan(text: bestPrice[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                        ],
                                                      ),
                                                    ),
                                                    if(bestPrice[i].isSale)Text('${bestPrice[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: ()async{
                                          dialog(context);
                                          await getItem(bestPrice[i].id);
                                          Navigator.pushReplacementNamed(context, 'pro');
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // if(checkPosition(6))SizedBox(height: h*0.01,),
                            // if(checkPosition(6))InkWell(
                            //   child: Container(
                            //     width: w,
                            //     height: h*0.15,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: NetworkImage(getAdsPosition(6).image),
                            //           fit: BoxFit.fitWidth,
                            //         )
                            //     ),
                            //   ),
                            //   focusColor: Colors.transparent,
                            //   splashColor: Colors.transparent,
                            //   highlightColor: Colors.transparent,
                            //   onTap: ()async{
                            //     Ads _ads = getAdsPosition(6);
                            //     if(_ads.inApp){
                            //       if(_ads.type){
                            //         dialog(context);
                            //         await getItem(int.parse(_ads.link));
                            //         Navigator.pushReplacementNamed(context, 'pro');
                            //       }else{
                            //         dialog(context);
                            //         Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                            //         await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
                            //       }
                            //     }
                            //   },
                            // ),
                            if(getAds(6).isNotEmpty)SizedBox(height: h*0.01,),
                            if(getAds(6).isNotEmpty)SizedBox(
                              height: h*0.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.025),
                                child: Swiper(
                                  itemCount: getAds(6).length,
                                  itemBuilder: (BuildContext context, int i) {
                                    Ads _ads = getAds(6)[i];
                                    return InkWell(
                                      child: Container(
                                        width: w*0.95,
                                        height: h*0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(_ads.image),
                                            fit: BoxFit.fitWidth,
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
                                          }else{
                                            dialog(context);
                                            Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                            await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
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
                            ),
                            SizedBox(height: h*0.01,),
                            if(topLikes.isNotEmpty)Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: w*0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(translate(context,'home','title7'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,fontFamily: 'Tajawal'),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h*0.01,),
                                Container(
                                  width: w,
                                  height: h*0.38,
                                  child: ListView.builder(
                                    itemCount: topLikes.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx,i){
                                      return InkWell(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: w*0.025),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: w*0.4,
                                                height: h*0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    image: DecorationImage(
                                                      image: NetworkImage(topLikes[i].image),
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                ),
                                              ),
                                              Container(
                                                width: w*0.4,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: h*0.01,),
                                                    Container(constraints: BoxConstraints(
                                                      maxHeight: h*0.07,
                                                    ),child: Text(translateString(topLikes[i].nameEn,topLikes[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                    SizedBox(height: h*0.005,),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          if(topLikes[i].isSale)TextSpan(text: '${topLikes[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(!topLikes[i].isSale)TextSpan(text: '${topLikes[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(topLikes[i].isSale&&topLikes[i].disPer!=null)TextSpan(text: topLikes[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                        ],
                                                      ),
                                                    ),
                                                    if(topLikes[i].isSale)Text('${topLikes[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: ()async{
                                          dialog(context);
                                          await getItem(topLikes[i].id);
                                          Navigator.pushReplacementNamed(context, 'pro');
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // if(checkPosition(7))SizedBox(height: h*0.01,),
                            // if(checkPosition(7))InkWell(
                            //   child: Container(
                            //     width: w,
                            //     height: h*0.15,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: NetworkImage(getAdsPosition(7).image),
                            //           fit: BoxFit.fitWidth,
                            //         )
                            //     ),
                            //   ),
                            //   focusColor: Colors.transparent,
                            //   splashColor: Colors.transparent,
                            //   highlightColor: Colors.transparent,
                            //   onTap: ()async{
                            //     Ads _ads = getAdsPosition(7);
                            //     if(_ads.inApp){
                            //       if(_ads.type){
                            //         dialog(context);
                            //         await getItem(int.parse(_ads.link));
                            //         Navigator.pushReplacementNamed(context, 'pro');
                            //       }else{
                            //         dialog(context);
                            //         Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                            //         await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
                            //       }
                            //     }
                            //   },
                            // ),
                            if(getAds(7).isNotEmpty)SizedBox(height: h*0.01,),
                            if(getAds(7).isNotEmpty)SizedBox(
                              height: h*0.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.025),
                                child: Swiper(
                                  itemCount: getAds(7).length,
                                  itemBuilder: (BuildContext context, int i) {
                                    Ads _ads = getAds(7)[i];
                                    return InkWell(
                                      child: Container(
                                        width: w*0.95,
                                        height: h*0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(_ads.image),
                                            fit: BoxFit.fitWidth,
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
                                          }else{
                                            dialog(context);
                                            Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                            await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
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
                            ),
                            SizedBox(height: h*0.01,),
                            if(topRate.isNotEmpty)Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: w*0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(translate(context,'home','title8'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.045,fontFamily: 'Tajawal'),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h*0.01,),
                                Container(
                                  width: w,
                                  height: h*0.38,
                                  child: ListView.builder(
                                    itemCount: topRate.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx,i){
                                      return InkWell(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: w*0.025),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: w*0.4,
                                                height: h*0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    image: DecorationImage(
                                                      image: NetworkImage(topRate[i].image),
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                ),
                                              ),
                                              Container(
                                                width: w*0.4,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: h*0.01,),
                                                    Container(constraints: BoxConstraints(
                                                      maxHeight: h*0.07,
                                                    ),child: Text(translateString(topRate[i].nameEn,topRate[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                    SizedBox(height: h*0.005,),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          if(topRate[i].isSale)TextSpan(text: '${topRate[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(!topRate[i].isSale)TextSpan(text: '${topRate[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                          if(topRate[i].isSale&&topRate[i].disPer!=null)TextSpan(text: topRate[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                        ],
                                                      ),
                                                    ),
                                                    if(topRate[i].isSale)Text('${topRate[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: ()async{
                                          dialog(context);
                                          await getItem(topRate[i].id);
                                          Navigator.pushReplacementNamed(context, 'pro');
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // if(checkPosition(8))SizedBox(height: h*0.01,),
                            // if(checkPosition(8))InkWell(
                            //   child: Container(
                            //     width: w,
                            //     height: h*0.15,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: NetworkImage(getAdsPosition(8).image),
                            //           fit: BoxFit.fitWidth,
                            //         )
                            //     ),
                            //   ),
                            //   focusColor: Colors.transparent,
                            //   splashColor: Colors.transparent,
                            //   highlightColor: Colors.transparent,
                            //   onTap: ()async{
                            //     Ads _ads = getAdsPosition(8);
                            //     if(_ads.inApp){
                            //       if(_ads.type){
                            //         dialog(context);
                            //         await getItem(int.parse(_ads.link));
                            //         Navigator.pushReplacementNamed(context, 'pro');
                            //       }else{
                            //         dialog(context);
                            //         Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                            //         Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                            //         await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
                            //       }
                            //     }
                            //   },
                            // ),
                            if(getAds(8).isNotEmpty)SizedBox(height: h*0.01,),
                            if(getAds(8).isNotEmpty)SizedBox(
                              height: h*0.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.025),
                                child: Swiper(
                                  itemCount: getAds(8).length,
                                  itemBuilder: (BuildContext context, int i) {
                                    Ads _ads = getAds(8)[i];
                                    return InkWell(
                                      child: Container(
                                        width: w*0.95,
                                        height: h*0.2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(_ads.image),
                                            fit: BoxFit.fitWidth,
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
                                          }else{
                                            dialog(context);
                                            Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                            Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                            await Provider.of<RePackageItemProvider>(context,listen: false).getItems(int.parse(_ads.link));
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: int.parse(_ads.link),)));
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
                            ),
                            SizedBox(height: h*0.01,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: w*0.025),
                              child: Container(
                                width: w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(translate(context,'home','contact'),style: TextStyle(color: Colors.red,fontSize: w*0.035),),
                                    for(var e in homeInfo)
                                      Text(e.title,style: TextStyle(color: Colors.grey,fontSize: w*0.035),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: h*0.02,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: w*0.025),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(icons.length, (i) {
                                    return InkWell(
                                      child: CircleAvatar(
                                        radius: w*0.04,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(icons[i].image),
                                      ),
                                      onTap: ()async{
                                        await canLaunch(icons[i].link) ? await launch(icons[i].link) : throw 'Could not launch ${icons[i].link}';
                                      },
                                    );
                                  }),
                                ),
                              ),
                            ),
                            SizedBox(height: h*0.15,),
                          ],
                        ),
                      ),
                    ),
                    mask?Positioned(
                      bottom: h*0.03,
                      right: w*0.08,
                      child: CircleAvatar(
                        radius: w*0.06,
                        backgroundColor: mainColor.withOpacity(0.7),
                        child: InkWell(
                          child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.white,)),
                          onTap: (){
                            _controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                          },
                        ),
                      ),
                    ):
                    SizedBox(),
                  ],
                ),
              ),
              // Container(
              //   width: w,
              //   height: h,
              //   child: Stack(
              //     children: [
              //       Container(
              //         width: w,
              //         height: h,
              //         child: Padding(
              //           padding: EdgeInsets.all(w*0.025),
              //           child: SingleChildScrollView(
              //             controller: _controller,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 SizedBox(height: h*0.01,),
              //                 DropdownButton<String>(
              //                   isDense: true,
              //                   underline: SizedBox(),
              //                   iconEnabledColor: mainColor,
              //                   iconDisabledColor: mainColor,
              //                   iconSize: w*0.08,
              //                   hint: Text('Sort'),
              //                   items: List.generate(sorts.length, (index) {
              //                     return DropdownMenuItem(
              //                       value: sorts[index],
              //                       child: Text(sorts[index],style: TextStyle(color: Colors.grey[600],),),
              //                     );
              //                   }),
              //                   onChanged: (val){
              //                     setState(() {
              //                       sort=val! ;
              //                     });
              //                   },
              //                   value: sort,
              //                 ),
              //                 SizedBox(height: h*0.01,),
              //                 Container(
              //                   width: w,
              //                   child: Wrap(
              //                     children: List.generate(20, (i) {
              //                       return InkWell(
              //                         child: Padding(
              //                           padding:  EdgeInsets.only(right: w*0.025,bottom: h*0.02),
              //                           child: Column(
              //                             mainAxisSize: MainAxisSize.min,
              //                             children: [
              //                               Container(
              //                                 width: w*0.45,
              //                                 height: h*0.22,
              //                                 decoration: BoxDecoration(
              //                                     image: DecorationImage(
              //                                       image: AssetImage('assets/food${i+1}.png'),
              //                                       fit: BoxFit.fitHeight,
              //                                     )
              //                                 ),
              //                                 child: Padding(
              //                                   padding:  EdgeInsets.all(w*0.015),
              //                                   child: Align(
              //                                     alignment: Alignment.bottomLeft,
              //                                     child: CircleAvatar(
              //                                       backgroundColor: mainColor,
              //                                       radius: w*.05,
              //                                       child: Center(
              //                                         child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: w*0.05,),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                               Container(
              //                                 width: w*0.45,
              //                                 child: Column(
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   crossAxisAlignment: CrossAxisAlignment.start,
              //                                   children: [
              //                                     SizedBox(height: h*0.01,),
              //                                     Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                     SizedBox(height: h*0.005,),
              //                                     RichText(
              //                                       text: TextSpan(
              //                                         children: [
              //                                           TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                           TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                         ],
              //                                       ),
              //                                     ),
              //                                     Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         onTap: (){
              //                           Navigator.pushReplacementNamed(context, 'pro');
              //                         },
              //                       );
              //                     }),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       mask?Positioned(
              //         bottom: h*0.03,
              //         right: w*0.08,
              //         child: CircleAvatar(
              //           radius: w*0.06,
              //           backgroundColor: mainColor.withOpacity(0.7),
              //           child: InkWell(
              //             child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.white,)),
              //             onTap: (){
              //               _controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInBack);
              //             },
              //           ),
              //         ),
              //       ):
              //       SizedBox(),
              //     ],
              //   ),
              // ),
              Container(
                width: w,
                height: h,
                child: Stack(
                  children: [
                    Container(
                      width: w,
                      height: h,
                      child: Padding(
                        padding: EdgeInsets.all(w*0.025),
                        child: SingleChildScrollView(
                          controller: _controller2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: h*0.01,),
                              Consumer<NewItemProvider>(
                                builder: (context,newItem,_){
                                  return DropdownButton<String>(
                                    isDense: true,
                                    underline: SizedBox(),
                                    iconEnabledColor: mainColor,
                                    iconDisabledColor: mainColor,
                                    iconSize: w*0.08,
                                    hint: Text(translate(context,'home','sort')),
                                    items: List.generate(newItem.sorts.length, (index) {
                                      return DropdownMenuItem(
                                        value: newItem.sorts[index],
                                        child: Text(newItem.sorts[index],style: TextStyle(color: Colors.grey[600],),),
                                        onTap: (){
                                          newItem.sortList(index);
                                        },
                                      );
                                    }),
                                    onChanged: (val){

                                    },
                                    value: newItem.sort,
                                  );
                                },
                              ),
                              SizedBox(height: h*0.01,),
                              Container(
                                width: w,
                                child: Consumer<NewItemProvider>(
                                    builder: (context,newItem,_) {
                                      return Wrap(
                                        children: List.generate(newItem.items.length, (i) {
                                          return InkWell(
                                            child: Padding(
                                              padding:  EdgeInsets.only(right: w*0.025,bottom: h*0.02),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: w*0.45,
                                                    height: h*0.28,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      image: DecorationImage(
                                                        image: NetworkImage(newItem.items[i].image),
                                                        // image: AssetImage('assets/food${i+1}.png'),
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:  EdgeInsets.all(w*0.015),
                                                      child: Align(
                                                        alignment: Alignment.bottomLeft,
                                                        child: CircleAvatar(
                                                          backgroundColor: mainColor,
                                                          radius: w*.05,
                                                          child: Center(
                                                            child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: w*0.05,),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: w*0.45,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: h*0.01,),
                                                        Container(constraints: BoxConstraints(
                                                          maxHeight: h*0.07,
                                                        ),child: Text(translateString(newItem.items[i].nameEn,newItem.items[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                        SizedBox(height: h*0.005,),
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              if(newItem.items[i].isSale)TextSpan(text: '${newItem.items[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                              if(!newItem.items[i].isSale)TextSpan(text: '${newItem.items[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                              if(newItem.items[i].isSale&&newItem.items[i].disPer!=null)TextSpan(text: newItem.items[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                            ],
                                                          ),
                                                        ),
                                                        if(newItem.items[i].isSale)Text('${newItem.items[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: ()async{
                                              dialog(context);
                                              await getItem(newItem.items[i].id);
                                              Navigator.pushReplacementNamed(context, 'pro');
                                            },
                                          );
                                        }),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    mask2?Positioned(
                      bottom: h*0.03,
                      right: w*0.08,
                      child: CircleAvatar(
                        radius: w*0.06,
                        backgroundColor: mainColor.withOpacity(0.7),
                        child: InkWell(
                          child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.white,)),
                          onTap: (){
                            _controller2.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                          },
                        ),
                      ),
                    ):
                    SizedBox(),
                  ],
                ),
              ),
              Container(
                width: w,
                height: h,
                child: Stack(
                  children: [
                    Container(
                      width: w,
                      height: h,
                      child: Padding(
                        padding: EdgeInsets.all(w*0.025),
                        child: SingleChildScrollView(
                          controller: _controller3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: h*0.01,),
                              Consumer<BestItemProvider>(
                                builder: (context,item,_){
                                  return DropdownButton<String>(
                                    isDense: true,
                                    underline: SizedBox(),
                                    iconEnabledColor: mainColor,
                                    iconDisabledColor: mainColor,
                                    iconSize: w*0.08,
                                    hint: Text(translate(context,'home','sort')),
                                    items: List.generate(item.sorts.length, (index) {
                                      return DropdownMenuItem(
                                        value: item.sorts[index],
                                        child: Text(item.sorts[index],style: TextStyle(color: Colors.grey[600],),),
                                        onTap: (){
                                          item.sortList(index);
                                        },
                                      );
                                    }),
                                    onChanged: (val){

                                    },
                                    value: item.sort,
                                  );
                                },
                              ),
                              SizedBox(height: h*0.01,),
                              Container(
                                width: w,
                                child: Consumer<BestItemProvider>(
                                    builder: (context,bestItem,_) {
                                      return Wrap(
                                        children: List.generate(bestItem.items.length, (i) {
                                          return InkWell(
                                            child: Padding(
                                              padding:  EdgeInsets.only(right: w*0.025,bottom: h*0.02),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: w*0.45,
                                                    height: h*0.28,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      image: DecorationImage(
                                                        image: NetworkImage(bestItem.items[i].image),
                                                        // image: AssetImage('assets/food${i+1}.png'),
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:  EdgeInsets.all(w*0.015),
                                                      child: Align(
                                                        alignment: Alignment.bottomLeft,
                                                        child: CircleAvatar(
                                                          backgroundColor: mainColor,
                                                          radius: w*.05,
                                                          child: Center(
                                                            child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: w*0.05,),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: w*0.45,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: h*0.01,),
                                                        Container(constraints: BoxConstraints(
                                                          maxHeight: h*0.07,
                                                        ),child: Text(translateString(bestItem.items[i].nameEn,bestItem.items[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                        SizedBox(height: h*0.005,),
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              if(bestItem.items[i].isSale)TextSpan(text: '${bestItem.items[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                              if(!bestItem.items[i].isSale)TextSpan(text: '${bestItem.items[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                              if(bestItem.items[i].isSale&&bestItem.items[i].disPer!=null)TextSpan(text: bestItem.items[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                            ],
                                                          ),
                                                        ),
                                                        if(bestItem.items[i].isSale)Text('${bestItem.items[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: ()async{
                                              dialog(context);
                                              await getItem(bestItem.items[i].id);
                                              Navigator.pushReplacementNamed(context, 'pro');
                                            },
                                          );
                                        }),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    mask3?Positioned(
                      bottom: h*0.03,
                      right: w*0.08,
                      child: CircleAvatar(
                        radius: w*0.06,
                        backgroundColor: mainColor.withOpacity(0.7),
                        child: InkWell(
                          child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.white,)),
                          onTap: (){
                            _controller3.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                          },
                        ),
                      ),
                    ):
                    SizedBox(),
                  ],
                ),
              ),
              Container(
                width: w,
                height: h,
                child: Stack(
                  children: [
                    Container(
                      width: w,
                      height: h,
                      child: Padding(
                        padding: EdgeInsets.all(w*0.025),
                        child: SingleChildScrollView(
                          controller: _controller4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: h*0.01,),
                              Consumer<ReItemProvider>(
                                builder: (context,item,_){
                                  return DropdownButton<String>(
                                    isDense: true,
                                    underline: SizedBox(),
                                    iconEnabledColor: mainColor,
                                    iconDisabledColor: mainColor,
                                    iconSize: w*0.08,
                                    hint: Text(translate(context,'home','sort')),
                                    items: List.generate(item.sorts.length, (index) {
                                      return DropdownMenuItem(
                                        value: item.sorts[index],
                                        child: Text(item.sorts[index],style: TextStyle(color: Colors.grey[600],),),
                                        onTap: (){
                                          item.sortList(index);
                                        },
                                      );
                                    }),
                                    onChanged: (val){

                                    },
                                    value: item.sort,
                                  );
                                },
                              ),
                              SizedBox(height: h*0.01,),
                              Container(
                                width: w,
                                child: Consumer<ReItemProvider>(
                                    builder: (context,reItem,_) {
                                      return Wrap(
                                        children: List.generate(reItem.items.length, (i) {
                                          return InkWell(
                                            child: Padding(
                                              padding:  EdgeInsets.only(right: w*0.025,bottom: h*0.02),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: w*0.45,
                                                    height: h*0.28,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      image: DecorationImage(
                                                        image: NetworkImage(reItem.items[i].image),
                                                        // image: AssetImage('assets/food${i+1}.png'),
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:  EdgeInsets.all(w*0.015),
                                                      child: Align(
                                                        alignment: Alignment.bottomLeft,
                                                        child: CircleAvatar(
                                                          backgroundColor: mainColor,
                                                          radius: w*.05,
                                                          child: Center(
                                                            child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: w*0.05,),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: w*0.45,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: h*0.01,),
                                                        Container(constraints: BoxConstraints(
                                                          maxHeight: h*0.07,
                                                        ),child: Text(translateString(reItem.items[i].nameEn,reItem.items[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                        SizedBox(height: h*0.005,),
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              if(reItem.items[i].isSale)TextSpan(text: '${reItem.items[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                              if(!reItem.items[i].isSale)TextSpan(text: '${reItem.items[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                              if(reItem.items[i].isSale&&reItem.items[i].disPer!=null)TextSpan(text: reItem.items[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                            ],
                                                          ),
                                                        ),
                                                        if(reItem.items[i].isSale)Text('${reItem.items[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: ()async{
                                              dialog(context);
                                              await getItem(reItem.items[i].id);
                                              Navigator.pushReplacementNamed(context, 'pro');
                                            },
                                          );
                                        }),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    mask4?Positioned(
                      bottom: h*0.03,
                      right: w*0.08,
                      child: CircleAvatar(
                        radius: w*0.06,
                        backgroundColor: mainColor.withOpacity(0.7),
                        child: InkWell(
                          child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.white,)),
                          onTap: (){
                            _controller4.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                          },
                        ),
                      ),
                    ):
                    SizedBox(),
                  ],
                ),
              ),
              // Container(
              //   width: w,
              //   height: h,
              //   child: Stack(
              //     children: [
              //       Container(
              //         width: w,
              //         height: h,
              //         child: SingleChildScrollView(
              //           controller: _controller4,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               InkWell(
              //                 child: Container(
              //                   width: w,
              //                   height: h*.17,
              //                   decoration: BoxDecoration(
              //                     image: DecorationImage(
              //                       image: AssetImage('assets/food18.png'),
              //                       fit: BoxFit.fitWidth,
              //                     ),
              //                   ),
              //                 ),
              //                 onTap: (){
              //                   Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages()));
              //                 },
              //               ),
              //               SizedBox(height: h*0.01,),
              //               Padding(
              //                 padding: EdgeInsets.only(left: w*0.025),
              //                 child: DropdownButton<String>(
              //                   isDense: true,
              //                   underline: SizedBox(),
              //                   iconEnabledColor: mainColor,
              //                   iconDisabledColor: mainColor,
              //                   iconSize: w*0.08,
              //                   hint: Text('Sort'),
              //                   items: List.generate(sorts.length, (index) {
              //                     return DropdownMenuItem(
              //                       value: sorts[index],
              //                       child: Text(sorts[index],style: TextStyle(color: Colors.grey[600],),),
              //                     );
              //                   }),
              //                   onChanged: (val){
              //                     setState(() {
              //                       sort=val! ;
              //                     });
              //                   },
              //                   value: sort,
              //                 ),
              //               ),
              //               SizedBox(height: h*0.01,),
              //               Padding(
              //                 padding: EdgeInsets.only(left: w*0.025),
              //                 child: Container(
              //                   width: w,
              //                   child: Wrap(
              //                     children: List.generate(20, (i) {
              //                       return InkWell(
              //                         child: Padding(
              //                           padding:  EdgeInsets.only(right: w*0.0375,bottom: h*0.02),
              //                           child: Column(
              //                             mainAxisSize: MainAxisSize.min,
              //                             children: [
              //                               Container(
              //                                 width: w*0.45,
              //                                 height: h*0.22,
              //                                 decoration: BoxDecoration(
              //                                     image: DecorationImage(
              //                                       image: AssetImage('assets/food${i+1}.png'),
              //                                       fit: BoxFit.fitHeight,
              //                                     )
              //                                 ),
              //                                 child: Padding(
              //                                   padding:  EdgeInsets.all(w*0.015),
              //                                   child: Align(
              //                                     alignment: Alignment.bottomLeft,
              //                                     child: CircleAvatar(
              //                                       backgroundColor: mainColor,
              //                                       radius: w*.05,
              //                                       child: Center(
              //                                         child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: w*0.05,),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                               Container(
              //                                 width: w*0.45,
              //                                 child: Column(
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   crossAxisAlignment: CrossAxisAlignment.start,
              //                                   children: [
              //                                     SizedBox(height: h*0.01,),
              //                                     Text('Product '+(i+1).toString(),style: TextStyle(fontSize: w*0.035),),
              //                                     SizedBox(height: h*0.005,),
              //                                     RichText(
              //                                       text: TextSpan(
              //                                         children: [
              //                                           TextSpan(text: '12.5 ${getCurrancy()}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              //                                           TextSpan(text: '10%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              //                                         ],
              //                                       ),
              //                                     ),
              //                                     Text('14.5 ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         onTap: (){
              //                           Navigator.pushReplacementNamed(context, 'pro');
              //                         },
              //                       );
              //                     }),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       mask4?Positioned(
              //         bottom: h*0.03,
              //         right: w*0.08,
              //         child: CircleAvatar(
              //           radius: w*0.06,
              //           backgroundColor: mainColor.withOpacity(0.7),
              //           child: InkWell(
              //             child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.white,)),
              //             onTap: (){
              //               _controller4.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInBack);
              //             },
              //           ),
              //         ),
              //       ):
              //       SizedBox(),
              //     ],
              //   ),
              // ),
              // Container(
              //   width: w,
              //   height: h,
              //   child: ListView.builder(
              //     itemCount: 20,
              //     itemBuilder: (ctx,i){
              //       return InkWell(
              //         child: Padding(
              //           padding:  EdgeInsets.only(bottom: h*0.03),
              //           child: Container(
              //             width: w,
              //             height: h*.21,
              //             decoration: BoxDecoration(
              //               image: DecorationImage(
              //                 image: AssetImage('assets/food${i+1}.png'),
              //                 fit: BoxFit.fitWidth,
              //               ),
              //             ),
              //           ),
              //         ),
              //         onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages()));
              //         },
              //       );
              //     },
              //   ),
              // ),
              Container(
                width: w,
                height: h,
                child: Stack(
                  children: [
                    Container(
                      width: w,
                      height: h,
                      child: Padding(
                        padding: EdgeInsets.all(w*0.025),
                        child: SingleChildScrollView(
                          controller: _controller5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: h*0.01,),
                              Consumer<OfferItemProvider>(
                                builder: (context,item,_){
                                  return DropdownButton<String>(
                                    isDense: true,
                                    underline: SizedBox(),
                                    iconEnabledColor: mainColor,
                                    iconDisabledColor: mainColor,
                                    iconSize: w*0.08,
                                    hint: Text(translate(context,'home','sort')),
                                    items: List.generate(item.sorts.length, (index) {
                                      return DropdownMenuItem(
                                        value: item.sorts[index],
                                        child: Text(item.sorts[index],style: TextStyle(color: Colors.grey[600],),),
                                        onTap: (){
                                          item.sortList(index);
                                        },
                                      );
                                    }),
                                    onChanged: (val){

                                    },
                                    value: item.sort,
                                  );
                                },
                              ),
                              SizedBox(height: h*0.01,),
                              Container(
                                width: w,
                                child: Consumer<OfferItemProvider>(
                                    builder: (context,offerItem,_) {
                                      return Wrap(
                                        children: List.generate(offerItem.items.length, (i) {
                                          return InkWell(
                                            child: Padding(
                                              padding:  EdgeInsets.only(right: w*0.025,bottom: h*0.02),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: w*0.45,
                                                    height: h*0.28,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      image: DecorationImage(
                                                        image: NetworkImage(offerItem.items[i].image),
                                                        // image: AssetImage('assets/food${i+1}.png'),
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:  EdgeInsets.all(w*0.015),
                                                      child: Align(
                                                        alignment: Alignment.bottomLeft,
                                                        child: CircleAvatar(
                                                          backgroundColor: mainColor,
                                                          radius: w*.05,
                                                          child: Center(
                                                            child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: w*0.05,),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: w*0.45,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: h*0.01,),
                                                        Container(constraints: BoxConstraints(
                                                          maxHeight: h*0.07,
                                                        ),child: Text(translateString(offerItem.items[i].nameEn,offerItem.items[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                        SizedBox(height: h*0.005,),
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              if(offerItem.items[i].isSale)TextSpan(text: '${offerItem.items[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                              if(!offerItem.items[i].isSale)TextSpan(text: '${offerItem.items[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                              if(offerItem.items[i].isSale&&offerItem.items[i].disPer!=null)TextSpan(text: offerItem.items[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                            ],
                                                          ),
                                                        ),
                                                        if(offerItem.items[i].isSale)Text('${offerItem.items[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: ()async{
                                              dialog(context);
                                              await getItem(offerItem.items[i].id);
                                              Navigator.pushReplacementNamed(context, 'pro');
                                            },
                                          );
                                        }),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    mask5?Positioned(
                      bottom: h*0.03,
                      right: w*0.08,
                      child: CircleAvatar(
                        radius: w*0.06,
                        backgroundColor: mainColor.withOpacity(0.7),
                        child: InkWell(
                          child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.white,)),
                          onTap: (){
                            _controller5.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                          },
                        ),
                      ),
                    ):
                    SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //   return Scaffold(
    //     floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    //     floatingActionButton: Visibility(
    //       visible: selected,
    //       child: FloatingActionButton(
    //         onPressed: (){
    //           showDialog(
    //             context: context,
    //             barrierDismissible: true,
    //             builder: (BuildContext context) {
    //               return  AlertDialog(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(25),
    //                 ),
    //                 titlePadding: EdgeInsets.zero,
    //                 backgroundColor: Colors.grey[200]!.withOpacity(0.85),
    //                 insetPadding: EdgeInsets.symmetric(horizontal: w*0.035,vertical: h*0.23),
    //                 title: Padding(
    //                   padding: EdgeInsets.only(top: h*0.01,bottom: h*0.02),
    //                   child: Column(
    //                     children: [
    //                       CircleAvatar(
    //                         radius: w*0.12,
    //                         backgroundColor: Colors.white,
    //                         child: Padding(
    //                           padding: EdgeInsets.all(5),
    //                           child: CircleAvatar(
    //                             radius: w*0.1,
    //                             backgroundImage: AssetImage('assets/ko1.png'),
    //                           ),
    //                         ),
    //                       ),
    //                       SizedBox(height: h*0.02,),
    //                       Text('Cha Eun-woo',style: TextStyle(color: mainColor,fontSize: w*0.05),),
    //                     ],
    //                   ),
    //                 ),
    //                 contentPadding: EdgeInsets.symmetric(horizontal:w*0.06),
    //                 content: Container(
    //                   width: w*0.95,
    //                   child:  Column(
    //                     children: [
    //                       row(w, 'assets/facebook.svg', 'assets/inst.svg', 'chaeunwooofficial', 'chaeunwooofficial'),
    //                       SizedBox(height: h*0.03,),
    //                       row(w, 'assets/twitter.svg', 'assets/link.svg', 'chaeunwooofficial', 'chaeunwooofficial'),
    //                       SizedBox(height: h*0.03,),
    //                       row(w, 'assets/tele.svg', 'assets/email.svg', '+8227411433', 'test@gmail.com'),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             },
    //           );
    //         },
    //         backgroundColor: mainColor,
    //         child: Center(
    //           child: Icon(Icons.call,color: Colors.white,size: w*0.08,),
    //         ),
    //       ),
    //     ),
    //     appBar: AppBar(
    //       backgroundColor: mainColor,
    //       leading: InkWell(
    //         child: Padding(
    //           padding: EdgeInsets.all(7),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10),
    //               color: Color(0xff617bba),
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.all(0),
    //               child: Icon(Icons.sort,color: Colors.white,size: w*0.05,),
    //             ),
    //           ),
    //         ),
    //         onTap: (){
    //
    //         },
    //       ),
    //       title: Container(
    //         width: w*0.1,
    //         height: w*0.1,
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage('assets/logo.png'),
    //             fit: BoxFit.cover,
    //           )
    //         ),
    //       ),
    //       centerTitle: true,
    //       actions: [
    //         Padding(
    //           padding: EdgeInsets.symmetric(vertical: w*0.01),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10),
    //               color: Color(0xff617bba),
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.all(5),
    //               // child: Icon(Icons.search,color: Colors.white,size: w*0.05,),
    //               child: Badge(
    //                 badgeColor: mainColor,
    //                 child: IconButton(
    //                   icon: Icon(Icons.shopping_cart,color: Colors.white,),
    //                   padding: EdgeInsets.zero,
    //                   focusColor: Colors.white,
    //                   onPressed: (){
    //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
    //                   },
    //                 ),
    //                 animationDuration: Duration(seconds: 2,),
    //                 badgeContent: Text(counter.toString(),style: TextStyle(color: Colors.white,fontSize: w*0.03,),),
    //                 position: BadgePosition.topStart(start: w*0.007),
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(width: w*0.02,),
    //       ],
    //     ),
    //     body: Center(
    //       child: SingleChildScrollView(
    //         controller: _controller,
    //         child: selected?another(w, h):main(w,h),
    //       ),
    //     ),
    //   );
    // }
    // Widget main(w,h){
    //   return Container(
    //     width: w,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Material(
    //           elevation: 5,
    //           child: Container(
    //             height: h*0.07,
    //             width: w,
    //             child: Center(
    //               child: Text('Student Section',style: TextStyle(color: mainColor,fontSize: w*0.04),),
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: h*0.01,),
    //         Container(
    //           height: h*0.2,
    //           width: w,
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage('assets/ma.png'),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: h*0.01,),
    //         Container(
    //           height: h*0.07,
    //           width: w*0.9,
    //           child: Row(
    //             children: [
    //               Text('Famous students',style: TextStyle(color: Colors.black,fontSize: w*0.04),),
    //               Expanded(
    //                 child: Container(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       SizedBox(height: h*0.02,),
    //                       InkWell(
    //                         child: Text('View all',style: TextStyle(color: mainColor,fontSize: w*0.04),),
    //                         onTap: (){
    //                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAll()));
    //                         },
    //                       ),
    //                       Expanded(
    //                         child: Divider(color: Colors.black,thickness: h*0.001,),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: h*0.01,),
    //         Container(
    //           width: w*0.95,
    //           height: h*0.44,
    //           child: GridView.count(
    //             crossAxisCount: 3,
    //             scrollDirection: Axis.vertical,
    //             mainAxisSpacing: h*0.01,
    //             crossAxisSpacing: w*0.02,
    //             childAspectRatio: 0.79,
    //             children: List.generate(6, (i) {
    //               return InkWell(
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     Container(
    //                       width: w*0.32,
    //                       height: h*0.17,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(5),
    //                         color: Colors.grey[200],
    //                         image: DecorationImage(
    //                           image: AssetImage('assets/ko${i.toString()}.png'),
    //                           fit: BoxFit.cover,
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(height: h*0.01,),
    //                     Text('Student`s name',style: TextStyle(fontSize: w*0.028,fontWeight: FontWeight.bold),),
    //                   ],
    //                 ),
    //                 onTap: (){
    //                   //Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentInfo()));
    //                   _controller.jumpTo(0);
    //                   setState(() {
    //                     selected=true;
    //                   });
    //                 },
    //               );
    //             }),
    //           ),
    //         ),
    //         SizedBox(height: h*0.01,),
    //         Container(
    //           height: h*0.2,
    //           width: w,
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage('assets/ma2.png'),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    // Widget another(w,h){
    //   return WillPopScope(
    //     onWillPop: ()async{
    //       _controller.jumpTo(0);
    //       _counter = List.generate(6, (i) => 0);
    //       _fav = List.generate(6, (i) => false);
    //       counter = 0;
    //       setState(() {
    //         selected = false;
    //       });
    //       return false;
    //     },
    //     child: Container(
    //       width: w,
    //       height: h,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Material(
    //             elevation: 5,
    //             child: Container(
    //               height: h*0.07,
    //               width: w,
    //               child: Row(
    //                 children: [
    //                   Expanded(child: SizedBox(width: 1,),flex: 10,),
    //                   Text('Student name',style: TextStyle(color: mainColor,fontSize: w*0.04),),
    //                   Expanded(child: SizedBox(width: 1,),flex: 5,),
    //                   Directionality(
    //                     textDirection: TextDirection.rtl,
    //                     child: BackButton(
    //                       color: mainColor,
    //                       onPressed: (){
    //                         _controller.animateTo(0, duration: Duration.zero, curve: Curves.ease);
    //                         _counter = List.generate(6, (i) => 0);
    //                         _fav = List.generate(6, (i) => false);
    //                         counter = 0;
    //                         setState(() {
    //                           selected = false;
    //                         });
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: h*0.01,),
    //           Container(
    //             height: h*0.2,
    //             width: w,
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                 image: AssetImage('assets/ko2.png'),
    //                 fit: BoxFit.fill,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: h*0.01,),
    //           Material(
    //             elevation: 1,
    //             child: Container(
    //               width: w,
    //               height: h*0.08,
    //               child: Row(
    //                 children: [
    //                   Expanded(
    //                     child: Container(
    //                       height: h*0.08,
    //                       child: Center(
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Icon(Icons.filter_alt,color: mainColor,size: w*0.07,),
    //                             Text('Filter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.05,color: Colors.black),),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     height: h*0.08,
    //                     width: w*0.003,
    //                     color: Colors.grey[300],
    //                   ),
    //                   Expanded(
    //                     child: Container(
    //                       height: h*0.08,
    //                       child: Center(
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Icon(Icons.sort,color: mainColor,size: w*0.07,),
    //                             Text('Sort by',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.05,color: Colors.black),),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: h*0.015,),
    //           Expanded(
    //             child: Container(
    //               width: w*0.95,
    //               child: GridView.count(
    //                 crossAxisCount: 2,
    //                 scrollDirection: Axis.vertical,
    //                 mainAxisSpacing: h*0.03,
    //                 crossAxisSpacing: w*0.02,
    //                 childAspectRatio: 0.65,
    //                 children: List.generate(6, (i) {
    //                   return InkWell(
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(20),
    //                         border: Border.all(color: Colors.grey),
    //                       ),
    //                       child: Column(
    //                         children: [
    //                           Hero(
    //                             tag: 'aassets/food${(i+1)}.png',
    //                             child: Container(
    //                               height: h*0.15,
    //                               decoration: BoxDecoration(
    //                                   borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
    //                                   image: DecorationImage(
    //                                     image: AssetImage('assets/food${(i+1)}.png'),
    //                                     fit: BoxFit.cover,
    //                                   )
    //                               ),
    //                             ),
    //                           ),
    //                           Padding(
    //                             padding: EdgeInsets.symmetric(vertical: h*0.01,horizontal: w*0.02),
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Row(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     Text('SECRET KEY',style: TextStyle(color: Color(0xff136ef9),fontSize: w*0.03,fontWeight: FontWeight.bold),),
    //                                     Text(' ${getCurrancy()} 23.00',style: TextStyle(color: Color(0xff136ef9),fontSize: w*0.03,fontWeight: FontWeight.bold),),
    //                                   ],
    //                                 ),
    //                                 SizedBox(height: h*0.01,),
    //                                 Text('Secret key black Out pure \nMinimizing Pack. Remove black head',style: TextStyle(fontSize: w*0.02,fontWeight: FontWeight.bold,color: Colors.grey),),
    //                               ],
    //                             ),
    //                           ),
    //                           Expanded(child: SizedBox(height: 1,)),
    //                           Container(
    //                             child: Row(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 SizedBox(width: w*0.02,),
    //                                 InkWell(
    //                                   child: CircleAvatar(
    //                                     backgroundColor: mainColor,
    //                                     radius: w*0.045,
    //                                     child: Icon(Icons.add,color:Colors.white,size: w*0.04,),
    //                                   ),
    //                                   onTap: (){
    //                                     setState(() {
    //                                       _counter[i]++;
    //                                       int counter2 = 0;
    //                                       _counter.forEach((e) {
    //                                         if(e>0){
    //                                           counter2++;
    //                                         }
    //                                       });
    //                                       counter = counter2;
    //                                     });
    //                                   },
    //                                 ),
    //                                 SizedBox(width: w*0.02,),
    //                                 Container(
    //                                     width: w*0.15,
    //                                     height: h*0.05,
    //                                     decoration: BoxDecoration(
    //                                       borderRadius: BorderRadius.circular(50),
    //                                       border: Border.all(color: mainColor,width: 1),
    //                                       color: Colors.white,
    //                                     ),
    //                                     child: Center(child: Text('${_counter[i]}',style: TextStyle(color: mainColor,fontSize: w*0.04,),))
    //                                 ),
    //                                 SizedBox(width: w*0.02,),
    //                                 InkWell(
    //                                   child: CircleAvatar(
    //                                     backgroundColor: mainColor,
    //                                     radius: w*0.045,
    //                                     child: Icon(Icons.remove,color:Colors.white,size: w*0.04,),
    //                                   ),
    //                                   onTap: (){
    //                                     if(_counter[i]>0){
    //                                       setState(() {
    //                                         _counter[i]--;
    //                                         int counter2 = 0;
    //                                         _counter.forEach((e) {
    //                                           if(e>0){
    //                                             counter2++;
    //                                           }
    //                                         });
    //                                         counter = counter2;
    //                                       });
    //                                     }
    //                                   },
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(height: h*0.015,),
    //                           Container(
    //                             height: h*0.07,
    //                             decoration: BoxDecoration(
    //                               borderRadius:  BorderRadius.only(bottomRight: Radius.circular(18),bottomLeft: Radius.circular(18)),
    //                               color: Colors.grey,
    //                             ),
    //                             child: Row(
    //                               children: [
    //                                 Expanded(
    //                                   child: InkWell(
    //                                     child: Container(
    //                                       height: h*0.07,
    //                                       decoration: BoxDecoration(
    //                                         borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(18)),
    //                                         color: mainColor,
    //                                       ),
    //                                       child: Center(
    //                                         child: Text('BUY NOW',style: TextStyle(color: Colors.white,fontSize: w*0.035),),
    //                                       ),
    //                                     ),
    //                                     onTap: (){
    //                                       setState(() {
    //                                         _counter[i] = 0;
    //                                         int counter2 = 0;
    //                                         _counter.forEach((e) {
    //                                           if(e>0){
    //                                             counter2++;
    //                                           }
    //                                         });
    //                                         counter = counter2;
    //                                       });
    //                                     },
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   height: h*0.07,
    //                                   width: w*0.15,
    //                                   decoration: BoxDecoration(
    //                                     borderRadius:  BorderRadius.only(bottomRight: Radius.circular(18)),
    //                                     color: Colors.grey[200],
    //                                   ),
    //                                   child: Center(
    //                                     child: IconButton(
    //                                       icon: Icon(_fav[i]?Icons.favorite:Icons.favorite_border,color: mainColor,size: w*0.07,),
    //                                       padding: EdgeInsets.zero,
    //                                       onPressed: (){
    //                                         setState(() {
    //                                           _fav[i] = !_fav[i];
    //                                         });
    //                                       },
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     onTap: (){
    //                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopInfo(img:'assets/food${(i+1)}.png')));
    //                     },
    //                   );
    //                 }),
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   );
    // }
    // Widget row(w,svg1,svg2,text1,text2){
    //   return Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       CircleAvatar(
    //         radius: w*0.05,
    //         backgroundColor: Colors.white,
    //         child: SvgPicture.asset(svg1),
    //       ),
    //       SizedBox(width: w*0.02,),
    //       Expanded(child: Text(text1,style: TextStyle(color: mainColor,fontSize: w*0.025),),),
    //       CircleAvatar(
    //         radius: w*0.05,
    //         backgroundColor: Colors.white,
    //         child: SvgPicture.asset(svg2),
    //       ),
    //       SizedBox(width: w*0.02,),
    //       Expanded(child: Text(text2,style: TextStyle(color: mainColor,fontSize: w*0.025),),),
    //     ],
    //   );
    // }
  }
}
