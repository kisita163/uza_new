import 'package:flutter/material.dart';
import 'package:onboarding_flow/business/market.dart';
import 'package:onboarding_flow/ui/screens/market_screen.dart';

class PageSelector extends StatelessWidget {
  const PageSelector({this.logos});

  final List<Market> logos;

  void _handleArrowButtonPress(BuildContext context, int delta) {
    final TabController controller = DefaultTabController.of(context);
    if (!controller.indexIsChanging)
      controller
          .animateTo((controller.index + delta).clamp(0, logos.length - 1));
  }

  void showMarket(BuildContext context, Market market) {
    Navigator.pushNamed(
      context,
      MarketScreen.routeName,
      arguments: market,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TabController controller = DefaultTabController.of(context);
    final Color color = Colors.black87;
    return SafeArea(
      top: false,
      bottom: false,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: color,
                  onPressed: () {
                    _handleArrowButtonPress(context, -1);
                  },
                  tooltip: 'Page back',
                ),
                TabPageSelector(selectedColor: color, controller: controller),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  color: color,
                  onPressed: () {
                    _handleArrowButtonPress(context, 1);
                  },
                  tooltip: 'Page forward',
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Expanded(
            child: IconTheme(
              data: IconThemeData(
                size: 128.0,
                color: color,
              ),
              child: TabBarView(
                children: logos.map<Widget>((Market market) {
                  return GestureDetector(
                    onTap: (){
                      showMarket(context,market);
                    },
                      child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 0.0,
                      color: Colors.transparent,
                      child: Center(
                        child:  Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                                  child: Image.asset(
                                    market.asset,
                                    height: 150,
                                    width: double.infinity,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 4.0, bottom: 4.0, left: 4.0, right: 4.0),
                                child: Image.asset(
                                  market.brand,
                                  height: 50,
                                  width: double.infinity,
                                ),
                              ),
                            ]),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
