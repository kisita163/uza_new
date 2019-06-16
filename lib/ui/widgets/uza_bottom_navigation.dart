import 'package:flutter/material.dart';



class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  })  : _icon = icon,
        _color = color,
        _title = title,
        item = BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: Text(title),
          backgroundColor: color,
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
        margin: const EdgeInsets.all(4.0),
        width: iconTheme.size - 8.0,
        height: iconTheme.size - 8.0,
        decoration: BoxDecoration(
          border: Border.all(color: iconTheme.color, width: 2.0),
        ));
  }
}


class UzaBottomNavigation extends StatefulWidget {

  final int currentIndex;
  static const String routeName = '/material/bottom_navigation';

  UzaBottomNavigation({@required this.currentIndex});

  @override
  _UzaBottomNavigationState createState() => _UzaBottomNavigationState(currentIndex: currentIndex);
}

class _UzaBottomNavigationState extends State<UzaBottomNavigation>
    with TickerProviderStateMixin {
  final int currentIndex;

  _UzaBottomNavigationState({this.currentIndex});

  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.home),
        title: 'Home',
        color: Color(0xFF2979FF),
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: CustomIcon(),
        icon: CustomInactiveIcon(),
        title: 'Box',
        color: Color(0xFF2979FF),
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.cloud),
        icon: const Icon(Icons.cloud_queue),
        title: 'Cloud',
        color: Color(0xFF2979FF),
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.favorite),
        icon: const Icon(Icons.favorite_border),
        title: 'Favorites',
        color: Color(0xFF2979FF),
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.person),
        title: 'Settings',
        color: Color(0xFF2979FF),
        vsync: this,
      )
    ];

    _navigationViews[currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  /*Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }*/

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>(
              (NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          /*_navigationViews[currentIndex].controller.reverse();
          currentIndex = index;
          _navigationViews[currentIndex].controller.forward();*/
        });
      },
    );

    /*return Scaffold(
      body: ListView(

        children: <Widget>[
          const SizedBox(height: 14.0),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('ORDER FROM ONLINE STORES',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                decoration: TextDecoration.none,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans",
              ),
            ),
          ),

          const SizedBox(height: 14.0),
          Container(
            width: double.infinity,
            height: 564,
            child: MarketPlaces(),
          )
          //const SizedBox(height: 24.0),
          //Expanded(child: new Container(),),
        ],
      ),

      bottomNavigationBar: botNavBar,
    );*/
  }
}
