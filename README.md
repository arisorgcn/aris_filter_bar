# aris_filter_bar

Filter Bar for app bar bottom, with this you can do some filtring.Use this widge, you should add [flutter_bloc] to your pubspec.yaml

## Preview

![preview](/assets/images/aris_filter_bar.gif)

## Getting Started

### Step1 Add Dependencies to pubspec.yaml

```flutter_bloc: ^6.1.1```
```aris_filter_bar: ^1.0.0```

### Step2 Add Repository

```dart
import 'package:aris_filter_bar/aris_filter_bar.dart';

class HomeFilterRepository extends BaseFilterBarRepository {
  @override
  Future<List<FilterBarItemEntity>> loadFilterItems() {
    List<FilterBarItemEntity> records = [];
    records.add(FilterBarItemEntity(
      id: "1",
      title: 'All',
      valueItems: null,
      resetAll: true,
    ));
    records.add(
      FilterBarItemEntity(
        id: "2",
        title: 'Project',
        singleSelect: true,
        valueItems: [
          FilterBarItemValueEntity(id: "201", name: 'Hangzhou', value: '201'),
          FilterBarItemValueEntity(id: "202", name: 'Shanghai', value: '202'),
        ],
      ),
    );
    records.add(FilterBarItemEntity(
      id: "3",
      title: 'Alarm',
      singleSelect: false,
      valueItems: [
        FilterBarItemValueEntity(id: "301", name: "Highest", value: "301"),
        FilterBarItemValueEntity(id: "302", name: "High", value: "302"),
        FilterBarItemValueEntity(id: "303", name: "Medium", value: "303"),
        FilterBarItemValueEntity(id: "304", name: "Low", value: "304"),
      ],
    ));

    records.add(
      FilterBarItemEntity(
        id: "4",
        title: "Device Type",
        singleSelect: true,
        valueItems: [
          FilterBarItemValueEntity(id: "401", name: "DuoChuan", value: "401"),
          FilterBarItemValueEntity(id: "402", name: "JiaoChaDai", value: "402"),
        ],
      ),
    );

    records.add(FilterBarItemEntity(
      id: "5",
      title: "Time",
      valueItems: null,
      enableSort: true,
      sortAccent: true,
    ));

    records.add(FilterBarItemEntity(
      id: "6",
      title: "Created",
      valueItems: null,
      enableSort: true,
      sortAccent: true,
    ));

    records.add(FilterBarItemEntity(
      id: "7",
      title: "OrderNo",
      valueItems: null,
      enableSort: true,
      sortAccent: true,
    ));

    return Future.value(records).timeout(Duration(milliseconds: 3000));
  }
}
```

### Step3 Edit your main.dart

```dart
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
```

