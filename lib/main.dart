import 'package:flutter/material.dart';
import 'package:tenewallet/Wallet/wallet.dart';
import 'package:tenewallet/Setting/setting.dart';
import 'package:tenewallet/Market/market.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(new SystemUiOverlayStyle(
    statusBarColor: Colors.lightBlue[800]
  ));
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController mainPageController;
  int currentPage = 0;

  List<Widget> pages = [ WalletPage(), MarketPage(), SettingPage()];

  @override
  void initState() {
    super.initState();
    mainPageController = new PageController(
      initialPage: currentPage,
      keepPage: true
    );
  }

  changePage(int page) {
    setState(() {
      currentPage = page;
      mainPageController.jumpToPage(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          WalletPage(),
          MarketPage(),
          SettingPage()
        ],
        controller: mainPageController,
        onPageChanged: changePage,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: currentPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: new Text("Wallet")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: new Text("Market")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: new Text("Setting")
          )
        ],
        onTap: changePage,
        fixedColor: Colors.lightBlue[800],

      ),
    );
  }
}
