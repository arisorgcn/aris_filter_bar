import 'package:aris_filter_bar/aris_filter_bar.dart';

///
/// Repository for retrieving data from backend
/// @author Aris Hu created at 2020-12-28
///
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
