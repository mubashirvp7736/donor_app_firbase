import 'package:firebase/controller/add_provider.dart';
import 'package:firebase/controller/donor_provider.dart';
import 'package:firebase/controller/image_provider.dart';
import 'package:firebase/service/firebase_options.dart';
import 'package:firebase/view/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (context) => AddDonorProvider(),),
        ChangeNotifierProvider(create: (context) => DonorProvider(),),
        ChangeNotifierProvider(create: (context) => ImageProv(),)
       ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}