import 'package:flutter/material.dart';
import "package:flutter_swiper/flutter_swiper.dart";
import "package:onboarding_flow/models/walkthrough.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onboarding_flow/ui/widgets/uza_raised_button.dart';

class WalkthroughScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final List<Walkthrough> pages = [
    Walkthrough(
      icon: Icons.developer_mode,
      title: "Choose your marketplace",
      description:
          "Select your preferred marketplace from a list of multiple marketplaces",
      image: 'assets/images/marketplaces.png',
    ),
    Walkthrough(
      icon: Icons.layers,
      title: "Explore products",
      description: "Visit the product detail of the item you wish to buy.",
      image: 'assets/images/shopping.png',
    ),
    Walkthrough(
      icon: Icons.account_circle,
      title: "Order",
      description: "Order and get delivered everywhere around the world.",
      image: 'assets/images/order.png',
    ),
  ];

  WalkthroughScreen({this.prefs});

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper.children(
        autoplay: false,
        index: 0,
        loop: false,
        pagination: new SwiperPagination(
          margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
          builder: new DotSwiperPaginationBuilder(
              color: Colors.white30,
              activeColor: Colors.white,
              size: 6.5,
              activeSize: 8.0),
        ),
        control: SwiperControl(
          iconPrevious: null,
          iconNext: null,
        ),
        children: _getPages(context),
      ),
    );
  }

  List<Widget> _getPages(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.pages.length; i++) {
      Walkthrough page = widget.pages[i];
      widgets.add(
        new Container(
          color: Color(0xFF2979FF), //Color.fromRGBO(212, 20, 15, 1.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: new Image.asset(page.image, width: 200.0, height: 200.0),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
                child: Text(
                  page.title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  page.description,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: page.extraWidget,
              )
            ],
          ),
        ),
      );
    }
    widgets.add(
      new Container(
        width: double.infinity,
        color: Colors
            .white, //Color(0xFF2979FF),//Color.fromRGBO(212, 20, 15, 1.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image.asset('assets/images/order.png',
                  width: 200.0, height: 200.0),
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
                child: Text(
                  "Jump straight into the action.",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2979FF), //Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                child: CustomRaisedButton(
                  title: "Get Started",
                  textColor: Colors.white,
                  onPressed: () {
                    widget.prefs.setBool('seen', true);
                    Navigator.of(context).pushNamed("/root");
                  },
                  splashColor: Colors.black12,
                  borderColor: Colors.white,
                  borderWidth: 0,
                  color: Color(0xFF2979FF), //Color.fromRGBO(212, 20, 15, 1.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return widgets;
  }
}
