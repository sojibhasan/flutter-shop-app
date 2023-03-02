// import 'package:flutter/material.dart';
// import 'package:shop_k/lang/change_language.dart';
// import 'package:shop_k/models/bottomnav.dart';
// import 'package:shop_k/models/constants.dart';
// import 'package:shop_k/models/country.dart';
// import 'login.dart';
// class Country extends StatefulWidget {
//   final int select;
//   Country(this.select);
//   @override
//   _CountryState createState() => _CountryState();
// }
//
// class _CountryState extends State<Country> {
//   List<Countries> _list= countries;
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text(translate(context,'country','title'), style: TextStyle(fontSize: w * 0.05, color: Colors.black,fontWeight: FontWeight.bold),),
//           leading: widget.select==1?SizedBox():BackButton(color: Colors.black,),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: Center(
//           child: Padding(
//             padding:  EdgeInsets.only(top: h*0.007,bottom: h*0.005),
//             child: Container(
//               width: w*0.9,
//               height: h,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Column(
//                       children: List.generate(_list.length, (index) {
//                         return Column(
//                           children: [
//                             Container(
//                               width: w*0.9,
//                               height: h*0.08,
//                               child: InkWell(
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       width: w*0.1,
//                                       height: w*0.1,
//                                       decoration: BoxDecoration(
//                                           color: Colors.grey[200],
//                                           borderRadius: BorderRadius.circular(50),
//                                           image: DecorationImage(
//                                             // image: AssetImage('assets/kuwait.png'),
//                                             image: NetworkImage(_list[index].image),
//                                             fit: BoxFit.fill,
//                                           )
//                                       ),
//                                     ),
//                                     SizedBox(width: w*0.03,),
//                                     Text(translateString(_list[index].nameEn, _list[index].nameEn),style: TextStyle(fontSize: w*0.05,fontWeight: FontWeight.bold,),),
//                                     Expanded(child: SizedBox(width: 1,)),
//                                     CircleAvatar(
//                                       radius: w*0.03,
//                                       child: Icon(Icons.done,color: Colors.white,size: w*0.04,),
//                                       backgroundColor: countryId==_list[index].id?mainColor:Colors.white,
//                                     ),
//                                   ],
//                                 ),
//                                 onTap: (){
//                                   setState(() {
//                                     setCountryId(_list[index].id,_list[index].code,_list[index].number);
//                                   });
//                                 },
//                               ),
//                             ),
//                             SizedBox(height: h*0.02,),
//                             if(_list.length-1!=index)Divider(height: h*0.005,color: Colors.grey[400],),
//                             SizedBox(height: h*0.01,),
//                           ],
//                         );
//                       }),
//                     ),
//                     SizedBox(height: h*0.1,),
//                     InkWell(
//                       child: Container(
//                         height: h*0.08,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                           color: mainColor,
//                         ),
//                         child: Center(
//                           child: Text(widget.select==2?translate(context,'buttons','save'):
//                           translate(context,'buttons','next'),style: TextStyle(color: Colors.white,fontSize: w*0.045,fontWeight: FontWeight.bold),),
//                         ),
//                       ),
//                       onTap: (){
//                         if(countryId!=0){
//                           if(widget.select==1){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
//                           }
//                           if(widget.select==2){
//                             Navigator.pop(context);
//                           }
//                         }else{
//                           final snackBar = SnackBar(
//                             content: Text(translate(context,'country','choose.txt')),
//                             action: SnackBarAction(
//                               label: translate(context,'snack_bar','undo'),
//                               disabledTextColor: Colors.yellow,
//                               textColor: Colors.yellow,
//                               onPressed: () {
//                                 ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                               },
//                             ),
//                           );
//                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
