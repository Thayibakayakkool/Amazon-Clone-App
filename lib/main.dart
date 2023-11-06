import 'package:amazon_app/layout/screen_layout.dart';
//import 'package:amazon_app/model/product_model.dart';
import 'package:amazon_app/providers/user_detalis_provider.dart';
//import 'package:amazon_app/screens/product_screen.dart';
//import 'package:amazon_app/screens/result_screen.dart';
//import 'package:amazon_app/screens/sell_screen.dart';
import 'package:amazon_app/screens/sign_in_screen.dart';
import 'package:amazon_app/utils/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDiw00rc-IpwtMfRrcJXwnaYBGA4TWmXhE",
            authDomain: "app-d73d4.firebaseapp.com",
            projectId: "app-d73d4",
            storageBucket: "app-d73d4.appspot.com",
            messagingSenderId: "989567241198",
            appId: "1:989567241198:web:0a0b241122ce85fd681cff"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserDetailsProvider())
      ],
      child: MaterialApp(
        title: 'Amazon Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.orange,
              ));
            } else if (user.hasData) {
             return const ScreenLayout();
            } else {
              return const SignInScreen();
            }
          },
        ),
        //const ScreenLayout(),
      ),
    );
  }
}
