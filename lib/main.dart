import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopipi_mobile_v2/provider/authProvider.dart';
import 'package:shopipi_mobile_v2/provider/categoryProvider.dart';
import 'package:shopipi_mobile_v2/route.dart';
import 'package:shopipi_mobile_v2/screens/navbar.dart';
import 'package:shopipi_mobile_v2/webSocketService.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WebSocketService().connect();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: const MyApp(),
    ),
  );

  // Ngắt kết nối socket khi ứng dụng đóng
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      // You can activate or deactivate the WebSocket based on auth state here
      // if (authProvider.isAuthenticated) {
      //   client.activate();
      // } else {
      //   client.deactivate();
      // }

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Navbar(),
        initialRoute: '/',
        onGenerateRoute: generateRoute,
      );
    });
  }
}
