import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/cat.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/user.dart';
import 'package:shop_k/provider/cart_provider.dart';
import 'package:shop_k/provider/package_provider.dart';
import 'package:shop_k/screens/address/address.dart';
import 'package:shop_k/screens/cart/cart.dart';
import 'package:shop_k/screens/multiplePackages.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  int selected=-1;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    CartProvider cart = Provider.of<CartProvider>(context,listen: true);
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(translate(context,'page_three','title'),style: TextStyle(color: Colors.white,fontSize: w*0.04),),
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
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (ctx,index){
                return Padding(
                  padding: EdgeInsets.only(bottom: h*0.05),
                  child: Container(
                    width: w,
                    child: ExpansionPanelList(
                      expandedHeaderPadding: EdgeInsets.only(top: 0,bottom: 0),
                      expansionCallback: (i,ex){
                        if(selected==i){
                          setState(() {
                            selected=-1;
                          });
                        }else{
                          setState(() {
                            selected=i;
                          });
                        }
                      },
                      children: List.generate(categories.length, (i)  {
                        return ExpansionPanel(
                            headerBuilder: (context,bool isExpanded){
                              return InkWell(
                                onTap: (){
                                  if(selected==i){
                                    setState(() {
                                      selected=-1;
                                    });
                                  }else{
                                    setState(() {
                                      selected=i;
                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: w*2.5/100,),
                                    // Icon(Icons.menu,color: Colors.black,size: w*0.06,),
                                    SizedBox(
                                      width: w*0.1,
                                      height: w*0.1,
                                      // child: Image.network(categories[i].image,fit: BoxFit.cover,),
                                      child: SvgPicture.network(categories[i].image),
                                    ),
                                    SizedBox(width: w*2.5/100,),
                                    Text(translateString(categories[i].nameEn, categories[i].nameAr),style: TextStyle(color: Colors.black,fontSize: w*0.04),),
                                  ],
                                ),
                              );
                            },
                            body:  Container(
                              width: w,
                              color: categories[i].subCategories.length!=0?Colors.grey[200]:Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.05),
                                child: categories[i].subCategories.length!=0?Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(categories[i].subCategories.length, (index) {
                                    return InkWell(
                                      child: Container(
                                        width: w,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: h*0.01,horizontal: w*0.01),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: w*0.1,
                                                height: w*0.1,
                                                child: SvgPicture.network(categories[i].subCategories[index].image),
                                              ),
                                              SizedBox(width: w*2.5/100,),
                                              Text(translateString(categories[i].subCategories[index].nameEn,
                                                  categories[i].subCategories[index].nameAr),style: TextStyle(color: Colors.black,fontSize: w*0.04,),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: ()async{
                                        dialog(context);
                                        Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                        Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                        Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                        await Provider.of<RePackageItemProvider>(context,listen: false).getItems(categories[i].subCategories[index].id);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: categories[i].subCategories[index].id,)));
                                      },
                                      highlightColor: Colors.grey,
                                      splashColor: Colors.grey,
                                      focusColor: Colors.grey,
                                      hoverColor: Colors.grey,
                                      overlayColor: MaterialStateProperty.all(Colors.grey),
                                    );
                                  }),
                                ):Center(
                                  child: Text(translate(context,'empty','no_products'),style: TextStyle(color: mainColor,fontSize: w*0.05),),
                                ),
                              ),
                            ),
                            isExpanded:selected!=i?false:true
                        );
                      }),
                      elevation: 0,
                    ),
                  ),
                );
              },
            ),
          )
        ),
      ),
    );
  }
}
