import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onboarding_flow/ui/widgets/uza_bottom_navigation.dart';
import 'package:onboarding_flow/ui/widgets/uza_page_selector.dart';
import 'package:onboarding_flow/business/market.dart';

class MainScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;

  MainScreen({this.firebaseUser});

  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {

  List<Market> logos = <Market>[
    Market(
        asset: 'assets/images/uza_tv.png',
        brand: 'assets/images/aliexpress_logo.png',
        url: 'https://www.aliexpress.be',
    name: 'AliExpress'),

    Market(
        asset: 'assets/images/uza_shoes.png',
        brand: 'assets/images/zalando_logo.png',
        url:'https://www.zalando.be',
    name:'Zalando'),
    Market(
        asset: 'assets/images/uza_sac.png',
        brand: 'assets/images/ebay_logo.png',
        url:'https://www.ebay.be',
      name: 'Ebay',
    ),
    Market(
        asset: 'assets/images/uza_phone.png',
        brand: 'assets/images/amazon_logo.png',
        url:'https://www.amazon.fr',
    name: 'Amazon'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: logos.length,
        child: PageSelector(logos: logos),
      ),
      bottomNavigationBar: UzaBottomNavigation(
        currentIndex: 0,
      ),
    );
  }
}
