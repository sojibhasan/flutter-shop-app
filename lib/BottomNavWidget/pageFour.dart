import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class PageFour extends StatefulWidget {
  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    CartProvider cart = Provider.of<CartProvider>(context,listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(translate(context,'page_four','title'),style: TextStyle(color: Colors.white,fontSize: w*0.04),),
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
      body: Center(
        child: Container(
          width: w,
          height: h,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(w*0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.search,
                    onEditingComplete: (){
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      focusedBorder: form(),
                      enabledBorder: form(),
                      errorBorder: form(),
                      focusedErrorBorder: form(),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.search,color:Colors.grey),
                      hintText: translate(context,'inputs','find_product'),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (val){
                      List<SubCategories> _subCat = [];
                      if(val.isEmpty || val == ''){
                        setState(() {
                          sub = allSub;
                        });
                      }else{
                        allSub.forEach((e) {
                          if(e.nameEn.toLowerCase().contains(val)||e.nameAr.toUpperCase().contains(val)){
                            _subCat.add(e);
                          }
                        });
                        setState(() {
                          sub = _subCat;
                        });
                      }
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: h*0.03,),
                  Text(translate(context,'page_four','sub_title'),style: TextStyle(color: Colors.grey[400],fontSize: w*0.035),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(sub.length, (index) {
                      SubCategories _sub = sub[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: h*0.01),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w*0.1,
                                    height: w*0.1,
                                    child: SvgPicture.network(_sub.image),
                                  ),
                                  SizedBox(width: w*2.5/100,),
                                  Text(translateString(_sub.nameEn, _sub.nameAr),style: TextStyle(color: mainColor,fontSize: w*0.04),),
                                ],
                              ),
                            ),
                            onTap: ()async{
                              dialog(context);
                              Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                              Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                              Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                              await Provider.of<RePackageItemProvider>(context,listen: false).getItems(_sub.id);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MultiplePackages(id: _sub.id,)));
                            },
                          ),
                          Divider(color: Colors.grey[200],thickness: h*0.002,),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  InputBorder form(){
    return new OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]!),
      borderRadius: BorderRadius.circular(5),
    );
  }
}
