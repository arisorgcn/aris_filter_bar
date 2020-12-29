// MIT License
//
// Copyright (c) 2020 aris.org.cn
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:json_annotation/json_annotation.dart';

import 'filter_bar_item_model.dart';
import 'filter_bar_item_value_entity.dart';

part 'filter_bar_item_entity.g.dart';

///
/// Filter Bar Item entity
/// @author Aris Hu created at 2020-12-28
///
@JsonSerializable()
class FilterBarItemEntity {
  /// filter item's ID
  final String id;

  /// filter's title
  final String title;

  /// whether or not the item is reset-all item
  final bool resetAll;

  /// 是不是单选
  final bool singleSelect;

  /// filter values
  final List<String> values;

  /// filter item's value
  final List<FilterBarItemValueEntity> valueItems;

  /// enable sort
  final bool enableSort;

  /// sort asc
  final bool sortAccent;

  FilterBarItemEntity({
    this.id,
    this.title,
    this.values,
    this.valueItems,
    this.singleSelect = false,
    this.enableSort = false,
    this.sortAccent = true,
    this.resetAll = false,
  });

  /// convert json to object
  static FilterBarItemEntity fromJson(Map<String, dynamic> json) => _$FilterBarItemEntityFromJson(json);

  /// convert object to json
  Map<String, dynamic> toJson() => _$FilterBarItemEntityToJson(this);

  /// convert model to entity
  static FilterBarItemEntity fromModel(FilterBarItemModel model) {
    return FilterBarItemEntity(
      id: model.id,
      title: model.title,
      values: model.values,
      singleSelect: model.singleSelect,
      resetAll: model.resetAll,
      enableSort: model.enableSort,
      sortAccent: model.sortAccent,
    );
  }

  @override
  String toString() {
    return 'FilterBarItemEntity{id: $id, title: $title, resetAll: $resetAll, singleSelect: $singleSelect, values: $values, valueItems: $valueItems, enableSort: $enableSort, sortAccent: $sortAccent}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterBarItemEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          resetAll == other.resetAll &&
          singleSelect == other.singleSelect &&
          values == other.values &&
          valueItems == other.valueItems &&
          enableSort == other.enableSort &&
          sortAccent == other.sortAccent;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      resetAll.hashCode ^
      singleSelect.hashCode ^
      values.hashCode ^
      valueItems.hashCode ^
      enableSort.hashCode ^
      sortAccent.hashCode;
}
