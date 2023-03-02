import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/productsCla.dart';
import 'package:shop_k/models/user.dart';
import 'package:shop_k/provider/cart_provider.dart';
import 'package:shop_k/provider/package_provider.dart';
import 'address/address.dart';
import 'cart/cart.dart';
class MultiplePackages extends StatefulWidget {
  final int? id;
  MultiplePackages({this.id});
  @override
  _MultiplePackagesState createState() => _MultiplePackagesState();
}

class _MultiplePackagesState extends State<MultiplePackages> with TickerProviderStateMixin{
  ScrollController _controller = ScrollController();
  ScrollController _controller2 = ScrollController();
  ScrollController _controller3 = ScrollController();
  TabController? _tabBar;
  bool mask=false,mask2=false,mask3=false;
  bool f1=true,f2=true,f3=true;
  bool fi1=true,fi2=true;
  bool finish = false;
  void start(context){
    var of2 = Provider.of<NewPackageItemProvider>(context,listen: true);
    var of3 = Provider.of<BestPackageItemProvider>(context,listen: true);
    var of1 = Provider.of<RePackageItemProvider>(context,listen: true);
    if(_tabBar==null){
      _tabBar = TabController(length: 3,vsync: this);
    }
    _tabBar!.addListener(() async{
      if(_tabBar!.index==1){
        if(fi1){
          fi1=false;
          NewPackageItemProvider newItem = Provider.of<NewPackageItemProvider>(context,listen: false);
          if(newItem.items.isEmpty){
            dialog(context);
            await newItem.getItems(widget.id);
            Navigator.pop(context);
          }
          fi1 = true;
        }
      }
      if(_tabBar!.index==2){
        if(fi2){
          fi2 = false;
          BestPackageItemProvider bestItem = Provider.of<BestPackageItemProvider>(context,listen: false);
          if(bestItem.items.isEmpty){
            dialog(context);
            await bestItem.getItems(widget.id);
            Navigator.pop(context);
          }
          fi2 = true;
        }
      }
    });
    _controller.addListener(() {
      if(_controller.position.atEdge){
        if(_controller.position.pixels!=0){
          if(f1){
            if(!of1.finish){
              f1=false;
              dialog(context);
              of1.getItems(widget.id).then((value) {
                Navigator.pop(context);
                f1 = true;
              });
            }
          }
        }
      }
      if(_controller.position.pixels>400.0&&mask==false){
        setState(() {
          mask=true;
        });
      }
      if(_controller.position.pixels<400.0&&mask==true){
        setState(() {
          mask=false;
        });
      }
    });
    _controller2.addListener(() {
      if(_controller2.position.atEdge){
        if(_controller2.position.pixels!=0){
          if(f2){
            if(!of2.finish){
              f2=false;
              dialog(context);
              of2.getItems(widget.id).then((value) {
                Navigator.pop(context);
                f2 = true;
              });
            }
          }
        }
      }
      if(_controller2.position.pixels>400.0&&mask2==false){
        setState(() {
          mask2=true;
        });
      }
      if(_controller2.position.pixels<400.0&&mask2==true){
        setState(() {
          mask2=false;
        });
      }
    });
    _controller3.addListener(() {
      if(_controller3.position.atEdge){
        if(_controller3.position.pixels!=0){
          if(f3){
            if(!of2.finish){
              f3=false;
              dialog(context);
              of3.getItems(widget.id).then((value) {
                Navigator.pop(context);
                f3 = true;
              });
            }
          }
        }
      }
      if(_controller3.position.pixels>400.0&&mask==false){
        setState(() {
          mask3=true;
        });
      }
      if(_controller3.position.pixels<400.0&&mask3==true){
        setState(() {
          mask3=false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    if(!finish){
      start(context);
      finish = true ;
    }
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    CartProvider cart = Provider.of<CartProvider>(context,listen: true);
    return  Directionality(
      textDirection: TextDirection.ltr,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(translate(context,'multiple','title'),style: TextStyle(color: Colors.white,fontSize: w*0.04),),
            centerTitle: false,
            backgroundColor: mainColor,
            leading: BackButton(color: Colors.white,),
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
              if(login)SizedBox(width: w*0.05,),
              if(login)IconButton(
                icon: Icon(Icons.location_on_outlined),
                iconSize: w*0.06,
                color: Colors.white,
                padding: EdgeInsets.zero,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Address()));
                },
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
                    Tab(text: translate(context,'multiple','tab1'),),
                    Tab(text: translate(context,'multiple','tab2'),),
                    Tab(text: translate(context,'multiple','tab3'),),
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
                            Consumer<RePackageItemProvider>(
                              builder: (context,ads,_){
                                if(ads.ads!=null){
                                  return Column(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: w,
                                          height: h*.17,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(ads.ads!.image),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        focusColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: ()async{
                                          if(ads.ads!.inApp){
                                            if(ads.ads!.type){
                                              dialog(context);
                                              await getItem(int.parse(ads.ads!.link));
                                              Navigator.pushReplacementNamed(context, 'pro');
                                            }
                                          }
                                        },
                                      ),
                                      SizedBox(height: h*0.01,),
                                    ],
                                  );
                                }else{
                                  return SizedBox();
                                }
                              },
                            ),
                            SizedBox(height: h*0.01,),
                            Consumer<RePackageItemProvider>(
                              builder: (context,item,_){
                                if(item.items.isNotEmpty){
                                  return DropdownButton<String>(
                                    isDense: true,
                                    underline: SizedBox(),
                                    iconEnabledColor: mainColor,
                                    iconDisabledColor: mainColor,
                                    iconSize: w*0.08,
                                    hint: Text(translate(context,'multiple','sort')),
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
                                }else{
                                  return SizedBox();
                                }
                              },
                            ),
                            SizedBox(height: h*0.01,),
                            Padding(
                              padding: EdgeInsets.only(left: w*0.025),
                              child: Container(
                                width: w,
                                child: Consumer<RePackageItemProvider>(
                                    builder: (context,re,_) {
                                      if(re.items.isNotEmpty){
                                        return Wrap(
                                          children: List.generate(re.items.length, (i) {
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
                                                          image: NetworkImage(re.items[i].image),
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
                                                          Text(translateString(re.items[i].nameEn, re.items[i].nameAr),style: TextStyle(fontSize: w*0.035),),
                                                          SizedBox(height: h*0.005,),
                                                          RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                if(re.items[i].isSale)TextSpan(text: '${re.items[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                                if(!re.items[i].isSale)TextSpan(text: '${re.items[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                                if(re.items[i].isSale&&re.items[i].disPer!=null)TextSpan(text: re.items[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                              ],
                                                            ),
                                                          ),
                                                          if(re.items[i].isSale)Text('${re.items[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: ()async{
                                                dialog(context);
                                                await getItem(re.items[i].id);
                                                Navigator.pushReplacementNamed(context, 'pro');
                                              },
                                            );
                                          }),
                                        );
                                      }else{
                                        return Center(
                                          child: Text(re.finish?'There are no products yet':'',style: TextStyle(color: mainColor,fontSize: w*0.05),),
                                        );
                                      }
                                    }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    mask?Positioned(
                      bottom: h*0.03,
                      left: w*0.08,
                      child: CircleAvatar(
                        radius: w*0.06,
                        backgroundColor: Colors.white,
                        child: InkWell(
                          child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.grey,)),
                          onTap: (){
                            _controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.bounceOut);
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
                      child: SingleChildScrollView(
                        controller: _controller2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<NewPackageItemProvider>(
                              builder: (context,ads,_){
                                if(ads.ads!=null){
                                  return Column(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: w,
                                          height: h*.17,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(ads.ads!.image),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        focusColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: ()async{
                                          if(ads.ads!.inApp){
                                            if(ads.ads!.type){
                                              dialog(context);
                                              await getItem(int.parse(ads.ads!.link));
                                              Navigator.pushReplacementNamed(context, 'pro');
                                            }
                                          }
                                        },
                                      ),
                                      SizedBox(height: h*0.01,),
                                    ],
                                  );
                                }else{
                                  return SizedBox();
                                }
                              },
                            ),
                            Consumer<NewPackageItemProvider>(
                              builder: (context,item,_){
                                if(item.items.isNotEmpty){
                                  return DropdownButton<String>(
                                    isDense: true,
                                    underline: SizedBox(),
                                    iconEnabledColor: mainColor,
                                    iconDisabledColor: mainColor,
                                    iconSize: w*0.08,
                                    hint: Text(translate(context,'multiple','sort')),
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
                                }else{
                                  return SizedBox();
                                }
                              },
                            ),
                            SizedBox(height: h*0.01,),
                            Padding(
                              padding: EdgeInsets.only(left: w*0.025),
                              child: Container(
                                width: w,
                                child: Consumer<NewPackageItemProvider>(
                                    builder: (context,newItem,_) {
                                      if(newItem.items.isNotEmpty){
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
                                                          Text(translateString(newItem.items[i].nameEn, newItem.items[i].nameAr),style: TextStyle(fontSize: w*0.035),),
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
                                      }else{
                                        return Center(
                                          child: Text(newItem.finish?'There are no products yet':'',style: TextStyle(color: mainColor,fontSize: w*0.05),),
                                        );
                                      }
                                    }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    mask2?Positioned(
                      bottom: h*0.03,
                      left: w*0.08,
                      child: CircleAvatar(
                        radius: w*0.06,
                        backgroundColor: Colors.white,
                        child: InkWell(
                          child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.grey,)),
                          onTap: (){
                            _controller2.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.bounceOut);
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
                      child: SingleChildScrollView(
                        controller: _controller3,
                        child: Padding(
                          padding: EdgeInsets.only(left: w*0.025),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<BestPackageItemProvider>(
                                builder: (context,ads,_){
                                  if(ads.ads!=null){
                                    return Column(
                                      children: [
                                        InkWell(
                                          child: Container(
                                            width: w,
                                            height: h*.17,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(ads.ads!.image),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                          focusColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: ()async{
                                            if(ads.ads!.inApp){
                                              if(ads.ads!.type){
                                                dialog(context);
                                                await getItem(int.parse(ads.ads!.link));
                                                Navigator.pushReplacementNamed(context, 'pro');
                                              }
                                            }
                                          },
                                        ),
                                        SizedBox(height: h*0.01,),
                                      ],
                                    );
                                  }else{
                                    return SizedBox();
                                  }
                                },
                              ),
                              Consumer<BestPackageItemProvider>(
                                builder: (context,item,_){
                                  if(item.items.isNotEmpty){
                                    return DropdownButton<String>(
                                      isDense: true,
                                      underline: SizedBox(),
                                      iconEnabledColor: mainColor,
                                      iconDisabledColor: mainColor,
                                      iconSize: w*0.08,
                                      hint: Text(translate(context,'multiple','sort')),
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
                                  }else{
                                    return SizedBox();
                                  }
                                },
                              ),
                              SizedBox(height: h*0.01,),
                              Container(
                                width: w,
                                child: Consumer<BestPackageItemProvider>(
                                    builder: (context,bestItem,_) {
                                      if(bestItem.items.isNotEmpty){
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
                                                          Text(translateString(bestItem.items[i].nameEn, bestItem.items[i].nameAr),style: TextStyle(fontSize: w*0.035),),
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
                                      }else{
                                        return Center(
                                          child: Text(bestItem.finish?'There are no products yet':'',style: TextStyle(color: mainColor,fontSize: w*0.05),),
                                        );
                                      }
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
                      left: w*0.08,
                      child: CircleAvatar(
                        radius: w*0.06,
                        backgroundColor: Colors.white,
                        child: InkWell(
                          child: Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.grey,)),
                          onTap: (){
                            _controller3.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.bounceOut);
                          },
                        ),
                      ),
                    ):
                    SizedBox(),
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

