
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/models/user.dart';

import 'new_item.dart';

class FavItemProvider extends ChangeNotifier{
  List<Item> items=[];
  int pageIndex=1;
  bool finish = false;
  String? sort;
  List sorts=[
    'Low price','High price','New',
  ];
  void clearList (){
    sort = null;
    items.clear();
    pageIndex = 1;
  }
  void sortList(int index){
    if(index==0){
      items.sort((a,b){
        return a.finalPrice.compareTo(b.finalPrice);
      });
    }else if(index==1){
      items.sort((a,b){
        return b.finalPrice.compareTo(a.finalPrice);
      });
    }else{
      items.sort((a,b){
        return a.id.compareTo(b.id);
      });
    }
    sort = sorts[index];
    notifyListeners();
  }
  void setItemsProvider(List list){
    if(list.isEmpty||list==[]){
      finish = true;
      notifyListeners();
    }else{
      list.forEach((e) {
        Item _item = Item(id: e['id'],finalPrice: e['in_sale']?num.parse(e['sale_price'].toString()):num.parse(e['regular_price'].toString()),image: imagePath+e['img'], nameEn: e['name_en'], nameAr: e['name_ar'],disPer: e['discount_percentage'],
            isSale: e['in_sale'], price: num.parse(e['regular_price'].toString()), salePrice: num.parse(e['sale_price'].toString()));
        items.add(_item);
      });
      pageIndex++;
      notifyListeners();
    }
  }
  Future<bool> getItems()async{
    print(auth);
    final String url = domain+'get-myProducts-likes?page=$pageIndex';
    try {
      Response response = await Dio().post(url,
        options: Options(
          headers: {
            "auth-token" : auth
          }
        ),
      );
      print(response.data);
      if(response.statusCode==200&&response.data['status']==1) {
        setItemsProvider(response.data['data']);
        return true;
      }
      if(response.statusCode==200&&response.data['status']==0) {
        setItemsProvider(response.data['data']);
        return true;
      }
      if(response.statusCode==200&&response.data['status']==false) {
        setItemsProvider([]);
        return true;
      }
      if(response.statusCode!=200){

      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
