import 'package:flutter/material.dart';
import 'package:voucher_mobile/common.dart';
import 'package:voucher_mobile/redeem_page.dart';
import 'package:voucher_mobile/scan_panel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Voucher Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void onScanned(String code) {
    setState(() {
      _selectedIndex = 0;
    });
    debugPrint(code);
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => RedeemPage(voucherCode: code),
      ),
    );
  }

  Widget _getPanel() {
    switch(_selectedIndex) {
      case 0:
        return const Text(
          'Index 1: Business',
        );
      case 1:
        return QRScanPage(onScanned);
  }
    return Container();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Common.white,
      body: Center(
          child: _getPanel(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Common.darkBlue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.autorenew),
            label: 'Generate Voucher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan Voucher',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Common.gray,
        selectedItemColor: Common.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
