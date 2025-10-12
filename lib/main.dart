// import 'package:flutter/material.dart';
// import 'modules/perangkat_desa/pd_main.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Perangkat Desa App',
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color.fromARGB(255,242,246,255),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: const PerangkatDesaMain(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perangkat Desa App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 242, 246, 255),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/pd',
    );
  }
}

