import 'package:aris_filter_bar/aris_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_filter_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter Bar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Filter Bar Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => FilterBarBloc(HomeFilterRepository())..add(LoadItemsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: ArisFilterBar(
            filterBarKey: Key('__filter_bar__'),
            filterBarLoadingKey: Key('__filter_bar_loading__'),
            filterBarEmptyKey: Key('__filter_bar_empty__'),
            onFilterChange: (params) {
              print('params: ${params.toString()}');
            },
            itemUnSelectedBackgroundColor: Colors.black12,
            itemSelectedBackgroundColor: Colors.red,
            itemUnSelectedStyle: TextStyle(
              color: Colors.black87,
              fontSize: 14.0,
            ),
            itemSelectedStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            accentSortSelectedIcon: FaIcon(
              FontAwesomeIcons.sortAmountUp,
              size: 18.0,
              color: Colors.white,
            ),
            accentSortUnSelectedIcon: FaIcon(
              FontAwesomeIcons.sortAmountUp,
              size: 18.0,
              color: Color(0xFF888888),
            ),
            decentSortSelectedIcon: FaIcon(
              FontAwesomeIcons.sortAmountDown,
              size: 18.0,
              color: Colors.white,
            ),
            decentSortUnSelectedIcon: FaIcon(
              FontAwesomeIcons.sortAmountDown,
              size: 18.0,
              color: Color(0xFF888888),
            ),
          ),
        ),
        body: Container(),
      ),
    );
  }
}
