import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/productsCla.dart';
import 'package:shop_k/models/user.dart';
import 'package:shop_k/provider/cart_provider.dart';
import 'package:shop_k/provider/favPro.dart';
import 'package:shop_k/screens/address/address.dart';
import 'package:shop_k/screens/cart/cart.dart';

class SecPage extends StatefulWidget {
  @override
  _SecPageState createState() => _SecPageState();
}

class _SecPageState extends State<SecPage> {
  ScrollController _controller = ScrollController();
  bool mask=false;
  bool f1=true;
  bool fi1=true,finish = false;
  void start(context)async{
    var of1 = Provider.of<FavItemProvider>(context,listen: true);
    _controller.addListener(() {
      if(_controller.position.atEdge){
        if(_controller.position.pixels!=0){
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
      if(_controller.position.pixels>400.0&&mask==false){
        setState(() {
          mask=true;
        });
        // scroll.changeShow(1, true);
      }
      if(_controller.position.pixels<400.0&&mask==true){
        setState(() {
          mask=false;
        });
        // scroll.changeShow(1, false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
          appBar: AppBar(
            elevation: 0,
            title: Text(translate(context,'page_two','title'),style: TextStyle(color: Colors.white,fontSize: w*0.04),),
            centerTitle: false,
            backgroundColor: mainColor,
            automaticallyImplyLeading: false,
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
          ),
          body: Container(
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
                      controller: _controller,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: h*0.01,),
                          Consumer<FavItemProvider>(
                            builder: (context,item,_){
                              return DropdownButton<String>(
                                isDense: true,
                                underline: SizedBox(),
                                iconEnabledColor: mainColor,
                                iconDisabledColor: mainColor,
                                iconSize: w*0.08,
                                hint: Text(translate(context,'page_two','sort')),
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
                            child: Consumer<FavItemProvider>(
                                builder: (context,item,_) {
                                  if(item.items.length==0||item.items.isEmpty){
                                    return SizedBox(
                                      width: w,
                                      height: h*0.5,
                                      child: Center(
                                        child: Text(translate(context,'empty','no_favorite'),style: TextStyle(color: mainColor,fontSize: w*0.05),),
                                      ),
                                    );
                                  }else{
                                    return Wrap(
                                      children: List.generate(item.items.length, (i) {
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
                                                      image: NetworkImage(item.items[i].image),
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
                                                      ),child: Text(translateString(item.items[i].nameEn, item.items[i].nameAr),style: TextStyle(fontSize: w*0.035),overflow: TextOverflow.fade)),
                                                      SizedBox(height: h*0.005,),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            if(item.items[i].isSale)TextSpan(text: '${item.items[i].salePrice} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                            if(!item.items[i].isSale)TextSpan(text: '${item.items[i].price} ${getCurrancy()} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                                                            if(item.items[i].isSale&&item.items[i].disPer!=null)TextSpan(text: item.items[i].disPer!+'%',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                          ],
                                                        ),
                                                      ),
                                                      if(item.items[i].isSale)Text('${item.items[i].price} ${getCurrancy()}',style: TextStyle(fontSize: w*0.035,decoration: TextDecoration.lineThrough,color: Colors.grey,),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: ()async{
                                            dialog(context);
                                            await getItem(item.items[i].id);
                                            Navigator.pushReplacementNamed(context, 'pro');
                                          },
                                        );
                                      }),
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
        ),
      ),
    );
  }
}
