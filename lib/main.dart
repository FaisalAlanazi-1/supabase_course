import 'package:flutter/material.dart';
import 'package:supabase_course/screens/Auth.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://vdykzpyjvdoqjpnswojw.supabase.co',
    publishableKey: 'sb_publishable_DdyekQsSTBiPDMv6U_d5LQ_wHH1w0K0',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Auth(),
    );
  }
}
