import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shop_k/lang/change_language.dart';
import 'package:shop_k/models/bottomnav.dart';
import 'package:shop_k/models/constants.dart';


class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  List<String> _hint = language=='en'?[
  'Full name','E-mail','phone number','Title','Message'
  ]:[
  'Nama lengkap','Surel','nomor telepon','Judul','Pesan'
  ];
  String getText(int index){
    return _listEd[index].text;
  }
  Future register()async{
    final String url = domain+'contact?name=${getText(0)}&email=${getText(1)}&phone=${getText(2)}&title=${getText(3)}&message=${getText(4)}';
    try {
      Response response = await Dio().post(url);
      if(response.data['status']==0){
        String data ='';
        if(language=='ar'){
          response.data['message'].forEach((e){
            data += e + '\n';
          });
        }else{
          response.data['message'].forEach((e){
            data += e + '\n';
          });
        }
        final snackBar = SnackBar(
          content: Text(data),
          action: SnackBarAction(
            label: translate(context,'snack_bar','undo'),
            disabledTextColor: Colors.yellow,
            textColor: Colors.yellow,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _btnController.stop();
      }
      if(response.statusCode==200){
        _btnController.stop();
        alertSuccessData(context, translate(context,'contact_us','success'));
      }
    } catch (e) {
      print('e');
      print(e);
      _btnController.error();
      await Future.delayed(const Duration(seconds: 2));
      _btnController.stop();
    }
  }
  List<FocusNode> _listFocus = List<FocusNode>.generate(5, (_) => new FocusNode()) ;
  List<TextEditingController> _listEd = List<TextEditingController>.generate(5, (_) => new TextEditingController()) ;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            systemOverlayStyle: st,
            title: Text(translate(context,'page_five','contacts'), style: TextStyle(fontSize: w * 0.05, color: mainColor,fontWeight: FontWeight.bold),),
            actions: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: BackButton(color: mainColor,),
              ),
            ],
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
          ),
          body: Center(
            child: Container(
              width: w*0.9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: List.generate(_listFocus.length, (index) {
                        return Column(
                          children: [
                            SizedBox(height: h*0.03,),
                            TextFormField(
                              cursorColor: Colors.black,
                              controller: _listEd[index],
                              focusNode: _listFocus[index],
                              textInputAction: index==4?TextInputAction.newline:TextInputAction.next,
                              keyboardType: index==1?TextInputType.emailAddress:index==4?TextInputType.multiline:TextInputType.text,
                              inputFormatters:index!=1?null:[
                                FilteringTextInputFormatter.allow(RegExp(r"[0-9 a-z  @ .]")),
                              ],
                              maxLines: index!=4?1:6,
                              onEditingComplete: (){
                                _listFocus[index].unfocus();
                                if(index<_listEd.length-1){
                                  FocusScope.of(context).requestFocus(_listFocus[index+1]);
                                }
                              },
                              validator: (value){
                                if(index==1){
                                  if (value!.length<4||!value.endsWith('.com')||'@'.allMatches(value).length!=1){
                                    return translate(context,'validation','valid_email');
                                  }
                                }
                                if(index!=1){
                                  if (value!.isEmpty) {
                                    return translate(context,'validation','field');
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: form(),
                                enabledBorder: form(),
                                errorBorder: form(),
                                focusedErrorBorder: form(),
                                hintText: _hint[index],
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: h*.04,),
                    RoundedLoadingButton(
                      child: Container(
                        width: w*0.9,
                        height: h*0.07,
                        child: Center(child: Text(translate(context,'buttons','send'),style: TextStyle(color: Colors.white,fontSize: w*0.05),)),
                      ),
                      controller: _btnController,
                      successColor: mainColor,
                      color: mainColor,
                      disabledColor: mainColor,
                      errorColor: Colors.red,
                      onPressed: ()async{
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (_formKey.currentState!.validate()){
                          register();
                        }else{
                          _btnController.error();
                          await Future.delayed(Duration(seconds: 2));
                          _btnController.stop();
                        }
                      },
                    ),
                    SizedBox(height: h*.05,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  InputBorder form() {
    return new OutlineInputBorder(
      borderSide: BorderSide(color: mainColor, width: 1.5),
      borderRadius: BorderRadius.circular(15),
    );
  }
}

