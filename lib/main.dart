import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shop_k/models/constants.dart';
import 'package:shop_k/provider/address.dart';
import 'package:shop_k/provider/cart_provider.dart';
import 'package:shop_k/provider/favPro.dart';
import 'package:shop_k/provider/map.dart';
import 'package:shop_k/provider/new_item.dart';
import 'package:shop_k/provider/package_provider.dart';
import 'package:shop_k/provider/scroll_up_home.dart';
import 'package:shop_k/provider/student_product.dart';
import 'package:shop_k/provider/student_provider.dart';
import 'package:shop_k/screens/address/address.dart';
import 'package:shop_k/screens/cart/orders.dart';
import 'package:shop_k/screens/home/Home.dart';
import 'package:shop_k/screens/lang.dart';
import 'package:shop_k/screens/noti.dart';
import 'package:shop_k/screens/product_info/products.dart';
import 'package:shop_k/splach.dart';
import 'BottomNavWidget/change_pass.dart';
import 'lang/change_language.dart';
import 'lang/localizations.dart';
import 'models/bottomnav.dart';
import 'provider/best_item.dart';
import 'provider/offer_item.dart';
import 'provider/recommended_item.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: mainColor,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));
  await Firebase.initializeApp();
  await startShared();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(appLanguage: appLanguage,));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({required this.appLanguage,Key? key}) : super(key: key);
  final AppLanguage appLanguage;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NewItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: StudentItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: StudentProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ReItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: FavItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ScrollUpHome(),
        ),
        ChangeNotifierProvider.value(
          value: BestItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OfferItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: NewPackageItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: BestPackageItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: RePackageItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MapProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AddressProvider(),
        ),
      ],
      child: ChangeNotifierProvider<AppLanguage>(
        create: (_)=>appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context,lang,_){
            return AnnotatedRegion(
              value: SystemUiOverlayStyle(
                statusBarColor: mainColor,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    systemOverlayStyle: st,
                  ),
                  primaryColor: mainColor,
                  checkboxTheme:CheckboxThemeData(
                    checkColor: MaterialStateProperty.all<Color>(Colors.white),
                    fillColor: MaterialStateProperty.all<Color>(mainColor),
                  ),
                  fontFamily: 'Tajawal',
                ),
                home: Splach(),
                locale: lang.appLocal,
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('id', 'ID'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                routes: {
                  "pro":(ctx)=>Products(),
                  "noti":(ctx)=>Notifications(),
                  "home":(ctx)=>Home(),
                  "change":(ctx)=>ChangePass(),
                  "address":(ctx)=>Address(),
                  "orders":(ctx)=>Orders(),
                  "lang":(ctx)=>LangPage(),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
