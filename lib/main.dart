import 'package:denomination/app/screens/homepage/homepagescreen.dart';
import 'package:denomination/app/screens/homepage/provider/homepageprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
        data: data.copyWith(
        textScaler: const TextScaler.linear(
          1,
        ),
      ),
      child: ScreenUtilInit(
          minTextAdapt: true,
        splitScreenMode: true,
         designSize: Size(
      
          data.size.width,
          data.size.height,
        ),
        child: MultiProvider(
          providers: [
           ChangeNotifierProvider(
                      create: (BuildContext context) =>
                         HomepageProvider()),
          ],
          child: MaterialApp(
            // title: 'Flutter Demo',
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
              
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const HomepageScreen(),
          ),
        ),
      ),
    );
  }
}
