import 'package:ecommerce/app/home/presentation/pages/home_page.dart';
import 'package:ecommerce/app/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'form_product/presentation/pages/form_product_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = GoRouter(routes: [
      GoRoute(
          path: "/login",
          builder: (_, __) => LoginPage(),
          name: "login",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool isAuth = prefs.getBool("login") ?? false;
            if (isAuth) {
              return "/";
            }
            return null;
          }),
      GoRoute(
          path: "/",
          builder: (_, __) => HomePage(),
          name: "home",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool isAuth = prefs.getBool("login") ?? false;
            if (!isAuth) {
              return "/login";
            }
            return null;
          }),
      GoRoute(
          path: "/form-product",
          builder: (_, __) => FormProductPage(),
          name: "form-product"),
    ]);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
    );
  }
}
