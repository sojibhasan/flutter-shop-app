

import 'package:dio/dio.dart';
import 'package:shop_k/models/user.dart';

import 'constants.dart';

List<int> favIds = [];

Future getLikes()async{
  final String url = domain+'get-ids-product-like';
  try {
    Response response = await Dio().get(url,
      options: Options(
          headers: {
            "auth-token" : auth
          }
      ),
    );
    if(response.statusCode==200){
      favIds.clear();
      if(response.data['data']==null){
      }else{
        List f = response.data['data'];
        f.forEach((e) {
          favIds.add(e);
        });
      }
    }else{
      await Future.delayed(Duration(milliseconds: 500));
      getLikes();
    }
  } catch (e) {
    print(e);
    await Future.delayed(Duration(milliseconds: 500));
    getLikes();
  }
}