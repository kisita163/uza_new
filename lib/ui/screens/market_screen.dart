import 'package:flutter/material.dart';
import 'package:onboarding_flow/business/market.dart';
import 'package:onboarding_flow/ui/widgets/uza_bottom_navigation.dart';
import 'package:onboarding_flow/ui/widgets/uza_webview.dart';


class MarketScreen extends StatefulWidget {

  static const routeName = '/market';

  @override
  State<StatefulWidget> createState() => new _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {

  @override
  Widget build(BuildContext context) {

    final Market market = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Container(
          //margin: const EdgeInsets.only(top: 25.0), //TODO status bar height
          child : UzaWebView(market),
      ),
      bottomNavigationBar: UzaBottomNavigation(
        currentIndex: 0,
      ),
    );
  }
}
