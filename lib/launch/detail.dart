import 'package:flutter/material.dart';
import 'package:space_x_new/items/launch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:space_x_new/items/rockets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:async';
import 'package:space_x_new/settings/pref_provider.dart';

class DetailLauch extends StatelessWidget {

  DetailLauch({this.launch});

  Launch launch;

  PageController _pageController = PageController(keepPage: false);

  int _counterSlide = 0;

  bool checkPage = true;

  Future<void> nextPage({Duration duration, Curve curve}) {
    return _pageController.nextPage(duration: duration, curve: curve);
  }

  Future<void> previousPage({Duration duration, Curve curve}) {
    return _pageController.previousPage(duration: duration, curve: curve);
  }

  List<String> _dataAssets = [
    'graphics/spacex_logo.jpg',
    'graphics/booster.jpg',
    'graphics/falcon_h.jpg'
  ];

  Timer _timer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    final pref = PrefProvider.of(context);

    _dataAssets.forEach(
        (url_str) => precacheImage(Image.asset(url_str).image, context));

    return StreamBuilder(
      stream: pref.blocpref.prefObserver,
        builder: (_, snapshot){
          if (snapshot.hasData){
            return _themeScaffol(context, snapshot);
          } else {
            return Container();
          }
        }
    );
  }

  Widget _themeScaffol(BuildContext context, AsyncSnapshot<bool> snapshot){

    const double _appBarHeigh = 256.0;


    return Theme(
      data: snapshot.data ? ThemeData(brightness: Brightness.dark) : _defaultTheme(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: _appBarHeigh,
              title: Text('Falcon'),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                    height: _appBarHeigh / 1,
                    width: double.infinity,
                    child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        children: launch.links.flikerImage.length != 0
                            ? sliderFliker(launch.links.flikerImage, context)
                            : _boxDecoration(context, _dataAssets))),
              ),
            ),
            _boxDetail(context),
            _coreBox(context),
          ],
        ),
      ),
    );
  }


  Future<bool> _willPopCallBack() async {
    _timer = getTimer();
    _timer.cancel();

    return true;
  }

  List<Widget> sliderFliker(List<dynamic> dataList, BuildContext context) {
    return dataList.map((data) {
      return FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          fit: BoxFit.cover,
          fadeInCurve: Curves.fastOutSlowIn,
          image: data);
    }).toList();
  }

  Timer getTimer() {
    return Timer.periodic(Duration(seconds: 4), (timer) {
      var totalPageSlide = launch.links.flikerImage.length != 0
          ? launch.links.flikerImage.length
          : _dataAssets.length;
      print(timer.tick);
      if (checkPage) {
        _counterSlide += 1;
        checkPage = _counterSlide != totalPageSlide ? true : false;
        nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      } else {
        _counterSlide -= 1;
        checkPage = _counterSlide != 0 ? false : true;
        previousPage(
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      }
    });
  }

  Widget _boxDetail(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          elevation: 5.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text('Detail',
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.title.fontSize
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      launch.detail ?? 'mission detail not describe',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.book), onPressed: null),
                    IconButton(icon: Icon(Icons.photo), onPressed: null)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ]));
  }

  Widget _coreBox(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            elevation: 5.0,
            child: Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Core',
                        style: TextStyle(fontSize: Theme.of(context).textTheme.title.fontSize),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: launch.rockets.core.length != 0
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemExtent: 100,
                            itemCount: launch.rockets.core.length,
                            itemBuilder: (_, index) {
                              return _circleCoreItem(
                                  launch.rockets.core[index]);
                            },
                          )
                        : Center(
                            child: Text('Core not found'),
                          ),
                  ))
                ],
              ),
            ),
          )),
    );
  }

  Widget _circleCoreItem(Cores coreName) {
    return Container(
        child: Column(
      children: <Widget>[
        CircleAvatar(
          child: Text(coreName.coreSerial[0]),
          radius: 30.0,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(coreName.coreSerial),
        )
      ],
    ));
  }

  List<Widget> _boxDecoration(context, List<String> assetStrings) {
    return assetStrings.map((assetUrl) {
      return DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset(assetUrl).image, fit: BoxFit.cover)));
    }).toList();
  }

  ThemeData _defaultTheme() {
    const primaryColor = Color(0xFF344945);
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: primaryColor,
    );
  }
}
