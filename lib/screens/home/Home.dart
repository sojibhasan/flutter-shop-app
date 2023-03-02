import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/BottomNavWidget/profile.dart';
import 'package:shop_k/BottomNavWidget/firstPage.dart';
import 'package:shop_k/BottomNavWidget/pageFour.dart';
import 'package:shop_k/BottomNavWidget/secoundPage.dart';
import 'package:shop_k/BottomNavWidget/thirdPage.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/cat.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/user.dart';
import 'package:shop_k/provider/favPro.dart';
import 'package:shop_k/screens/auth/login.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<BottomNav> _items = language=='en'?[
    BottomNav(Icons.home_outlined,Icons.home_outlined,0,'Home'),
    BottomNav(Icons.favorite,Icons.favorite_border,1,'Favorite'),
    BottomNav(Icons.menu,Icons.menu,2,'Categories'),
    BottomNav(Icons.search,Icons.search,3,'Search'),
    BottomNav(Icons.person,Icons.person_outline,4,'Profile'),
  ]:[
  BottomNav(Icons.home_outlined,Icons.home_outlined,0,'Rumah'),
  BottomNav(Icons.favorite,Icons.favorite_border,1,'Favorit'),
  BottomNav(Icons.menu,Icons.menu,2,'Kategori'),
  BottomNav(Icons.search,Icons.search,3,'Mencari'),
  BottomNav(Icons.person,Icons.person_outline,4,'Profil'),
  ];
  List<Widget> bottomWidget = [
    FirstPage(),
    SecPage(),
    ThirdPage(),
    PageFour(),
    Profile(),
  ];
  int currentIndex=0;
  Future<bool> getCat(context)async{
    final String url = domain+'get-parent-categories';
    try{
      Response response = await Dio().get(url);
      if(response.data['status']==1){
        await setCat(response.data['data']);
        return true;
      }else{
        return false;
      }
    }catch(e){
      print(e);
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: mainColor,
          ),
          child: BottomNavigationBar(
            backgroundColor: Color(0xff3a5aa9),
            items: List.generate(_items.length, (index) {
              return BottomNavigationBarItem(
                activeIcon:Icon(_items[index].iconSelect,size: w*0.07,),
                icon: Icon(_items[index].iconNotSelect,size:w*0.07 ,),
                label: _items[index].title,
              );
            }),
            onTap: (val)async{
              if(val!=currentIndex){
                if(val==2||val==3){
                  dialog(context);
                  await getCat(context).then((value) {
                    if(value){
                      Navigator.pop(context);
                      setState(() {
                        currentIndex=val;
                      });
                    }else{
                      Navigator.pop(context);
                      error(context);
                    }
                  });
                }
                if(val==0||val==4){
                  setState(() {
                    currentIndex=val;
                  });
                }
                if(val==1){
                  if(userId!=0){
                    dialog(context);
                    FavItemProvider fav = Provider.of<FavItemProvider>(context,listen: false);
                    fav.clearList();
                    await fav.getItems().then((value) {
                      if(value){
                        Navigator.pop(context);
                        setState(() {
                          currentIndex=val;
                        });
                      }else{
                        Navigator.pop(context);
                        error(context);
                      }
                    });
                  }else{
                    final snackBar = SnackBar(
                      content: Text(translate(context,'snack_bar','login')),
                      action: SnackBarAction(
                        label: translate(context,'buttons','login'),
                        disabledTextColor: Colors.yellow,
                        textColor: Colors.yellow,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()),(route)=>false);
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              }
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: currentIndex,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedLabelStyle: TextStyle(color: Colors.white,fontSize: w*0.03),
            unselectedLabelStyle: TextStyle(color: Colors.white,fontSize: w*0.03),
          ),
        ),
        body: SafeArea(
          child: bottomWidget[currentIndex],
        ),
      ),
    );
  }
}
