import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/provider/student_product.dart';
import 'package:shop_k/provider/student_provider.dart';
import 'package:shop_k/screens/student/student_info.dart';

class ViewAll extends StatelessWidget {
  final ScrollController _controller = ScrollController();
  bool f1=true;
  void start(context){
    var of1 = Provider.of<StudentProvider>(context,listen: true);
    _controller.addListener(() {
      if(_controller.position.atEdge){
        if(_controller.position.pixels!=0){
          if(f1){
            if(!of1.finish){
              f1=false;
              dialog(context);
              of1.getStudents().then((value) {
                Navigator.pop(context);
                f1 = true;
              });
            }
          }
        }
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    start(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(context,'student','famous'),style: TextStyle(color: Colors.white,fontSize: w*0.04),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: BackButton(color: Colors.white),
          ),
        ],
        elevation: 5,
        backgroundColor: mainColor,
        iconTheme: IconThemeData(color: mainColor),
      ),
      body: Center(
          child: Container(
            width: w,
            height: h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Material(
                //   elevation: 5,
                //   child: Container(
                //     height: h*0.07,
                //     width: w,
                //     child: Center(
                //       child: Text('Student Section',style: TextStyle(color: mainColor,fontSize: w*0.04),),
                //     ),
                //   ),
                // ),
                SizedBox(height: h*0.01,),
                Expanded(
                  child: Container(
                    width: w*0.9,
                    child: Consumer<StudentProvider>(
                      builder: (context,st,_){
                        if(st.students.isNotEmpty){
                          return GridView.count(
                            crossAxisCount: 3,
                            scrollDirection: Axis.vertical,
                            mainAxisSpacing: w*0.02,
                            crossAxisSpacing: h*0.02,
                            childAspectRatio: 0.77,
                            children: List.generate(st.students.length, (i) {
                              StudentClass _st = st.students[i];
                              return InkWell(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: w*0.3,
                                      height: h*0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey[200],
                                        image: _st.image==null?DecorationImage(
                                          image: AssetImage('assets/logo.png'),
                                          fit: BoxFit.cover,
                                        ):DecorationImage(
                                          image: NetworkImage(_st.image!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: h*0.01,),
                                    Text(_st.name,style: TextStyle(fontSize: w*0.028,fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.fade,),
                                  ],
                                ),
                                onTap: ()async{
                                  dialog(context);
                                  StudentItemProvider st = Provider.of<StudentItemProvider>(context,listen: false);
                                  st.clearList();
                                  await st.getItems(_st.id);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context)=>StudentInfo(studentClass: _st,)));
                                },
                              );
                            }),
                          );
                        }else{
                          return Center(
                            child: Text(translate(context,'empty','no_student'),style: TextStyle(color: mainColor,fontSize: w*0.05),),
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: h*0.01,),
              ],
            ),
          ),
      ),
    );
  }
}
