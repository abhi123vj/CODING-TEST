import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/provider/insta_provider.dart';
import 'package:instagram/views/comments_views.dart';
import 'package:instagram/views/home_view.dart';
import 'package:instagram/views/saved_view.dart';
import 'package:instagram/views/unknown_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      
      providers: [ChangeNotifierProvider(create: (_) => InstaProvider())],
      child: GetMaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: textColor), // 1
      ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
       unknownRoute: GetPage(name: '/notfound', page: () => UnknownPage()),
      getPages: [
        GetPage(name: '/', page: () => HomeView()),
        GetPage(name: '/saved', page: () => SavedViews()),
                GetPage(name: '/cmnts', page: () => Comments()),

        // GetPage(
        //   name: '/home',
        //   page: () => HomeView(),
        //   transition: Transition.zoom  
        // ),
      ],
      ),
    );
  }
}