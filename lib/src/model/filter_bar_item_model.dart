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

import 'filter_bar_item_entity.dart';
import 'filter_bar_item_value_model.dart';

part 'filter_bar_item_model.g.dart';

///
/// @author Aris Hu created at 2020-12-28
///
@JsonSerializable()
class FilterBarItemModel {
  /// filter item's ID
  final String id;

  /// filter's title
  final String title;

  /// filter item's value
  final List<FilterBarItemValueModel> valueItems;

  /// selected values
  List<String> values;

  /// display text on the head
  String displayText;

  /// is single select
  final bool singleSelect;

  /// whether or not the item is reset all item
  final bool resetAll;

  /// is filter bar item dropdown opened
  bool opened;

  /// is filter bar item selected
  bool selected;

  /// enable sort
  bool enableSort;

  /// 是否按正序排列
  bool sortAccent;

  /// selected value index list
  List<bool> selectedValueBool;

  FilterBarItemModel({
    this.title,
    this.id,
    this.valueItems,
    this.values = const <String>[],
    this.displayText = '',
    this.opened = false,
    this.singleSelect = false,
    this.selected = false,
    this.selectedValueBool = const <bool>[],
    this.enableSort = false,
    this.sortAccent = true,
    this.resetAll = false,
  });

  static FilterBarItemModel fromEntity(FilterBarItemEntity entity) {
    return FilterBarItemModel(
      id: entity.id,
      title: entity.title,
      valueItems: _isValueItemsEmpty(entity)
          ? null
          : entity.valueItems.map((e) => FilterBarItemValueModel.fromJson(e.toJson())).toList(),
      values: entity.values == null || entity.values.isEmpty ? <String>[] : entity.values,
      selectedValueBool: _isValueItemsEmpty(entity) ? [] : entity.valueItems.map((e) => false).toList(),
      singleSelect: entity.singleSelect,
      enableSort: entity.enableSort,
      sortAccent: entity.sortAccent,
      resetAll: entity.resetAll,
    );
  }

  static bool _isValueItemsEmpty(FilterBarItemEntity entity) => entity.valueItems == null || entity.valueItems.isEmpty;

  static FilterBarItemModel fromJson(Map<String, dynamic> json) => _$FilterBarItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterBarItemModelToJson(this);

  FilterBarItemModel copyWith({
    String id,
    String title,
    List<String> values,
    bool singleSelect,
    bool enableSort,
    bool sortAccent,
    bool resetAll,
  }) {
    return FilterBarItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      values: this.values,
      singleSelect: singleSelect ?? this.singleSelect,
      enableSort: enableSort ?? this.enableSort,
      sortAccent: sortAccent ?? this.sortAccent,
      resetAll: resetAll ?? this.resetAll,
    );
  }

  @override
  String toString() {
    return 'FilterBarItemModel{id: $id, title: $title, valueItems: $valueItems, values: $values, displayText: $displayText, singleSelect: $singleSelect, resetAll: $resetAll, opened: $opened, selected: $selected, enableSort: $enableSort, sortAccent: $sortAccent, selectedValueBool: $selectedValueBool}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterBarItemModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          valueItems == other.valueItems &&
          values == other.values &&
          displayText == other.displayText &&
          singleSelect == other.singleSelect &&
          resetAll == other.resetAll &&
          opened == other.opened &&
          selected == other.selected &&
          enableSort == other.enableSort &&
          sortAccent == other.sortAccent &&
          selectedValueBool == other.selectedValueBool;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      valueItems.hashCode ^
      values.hashCode ^
      displayText.hashCode ^
      singleSelect.hashCode ^
      resetAll.hashCode ^
      opened.hashCode ^
      selected.hashCode ^
      enableSort.hashCode ^
      sortAccent.hashCode ^
      selectedValueBool.hashCode;
}
