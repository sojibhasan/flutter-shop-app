
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_k/models/constants.dart';

import 'new_item.dart';

class OfferItemProvider extends ChangeNotifier{
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
  Future getItems()async{
    final String url = domain+'get-offer-products?page=$pageIndex';
    try {
      Response response = await Dio().get(url);
      if(response.data['status']==1) {
        setItemsProvider(response.data['data']);
      }
      if(response.statusCode!=200){
        await Future.delayed(Duration(milliseconds: 700));
        getItems();
      }
    } catch (e) {
      print(e);
      await Future.delayed(Duration(milliseconds: 700));
      getItems();
    }
  }
}
