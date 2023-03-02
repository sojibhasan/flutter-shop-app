
import 'package:dio/dio.dart';

import 'constants.dart';

class Countries{
  int id;
  int number;
  String nameAr;
  String nameEn;
  String code;
  String image;
  List<Area> areas;
  Countries({required this.number,required this.id, required this.nameAr, required this.nameEn,
    required this.code, required this.image,required this.areas});
}
List<Countries> countries=[];
List<Area> allArea = [];
List<int> areasId = [];
void setCountries(List country){
  countries.clear();
  country.forEach((e) {
    List<Area> _area = [];
    for(var a in e['areas']){
      _area.add(Area(id: a['id'], nameAr: a['name_ar'], nameEn: a['name_en'], price: a['shipping_price']));
      areasId.add(a['id']);
    }
    allArea.addAll(_area);
    countries.add(
      Countries(number: e['count_number_phone'],id: e['id'], nameAr: e['name_ar'], nameEn: e['name_en'],
          code: e['code_phone'], image: e['src']+'/'+e['flag'],areas: _area)
    );
  });
}
// int countryId = 0;
// late String countryCode;
// late int countryNumber;
// void setCountryId(int id,String code,int _countryNumber){
//   prefs.setInt('countryId', id);
//   prefs.setInt('countryNumber', _countryNumber);
//   prefs.setString('countryKey', code);
//   countryCode = code;
//   countryNumber = _countryNumber;
//   countryId=id;
// }
class Area{
  int id;
  String nameAr;
  String nameEn;
  num price;
  Area({required this.id, required this.nameAr, required this.nameEn, required this.price});
}
num getAreaPrice(int id){
  num? price;
  for(var e in allArea){
    if(e.id==id){
      price = e.price;
    }
  }
  return price??0;
}
Future getCountries()async{
  final String url = domain+'get-countries';
  try {
    Response response = await Dio().get(url);
    if(response.data['status']==1){
      setCountries(response.data['data']);
    }else{
      print('error');
    }
  } catch (e) {
    print(e);
  }
}