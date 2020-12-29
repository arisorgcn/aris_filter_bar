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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_bar_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterBarItemModel _$FilterBarItemModelFromJson(Map<String, dynamic> json) {
  return FilterBarItemModel(
    title: json['title'] as String,
    id: json['id'] as String,
    valueItems: (json['valueItems'] as List)
        ?.map((e) => e == null ? null : FilterBarItemValueModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    values: (json['values'] as List)?.map((e) => e as String)?.toList(),
    displayText: json['displayText'] as String,
    opened: json['opened'] as bool,
    singleSelect: json['singleSelect'] as bool,
    selected: json['selected'] as bool,
    selectedValueBool: (json['selectedValueBool'] as List)?.map((e) => e as bool)?.toList(),
    enableSort: json['enableSort'] as bool,
    sortAccent: json['sortAccent'] as bool,
    resetAll: json['resetAll'] as bool,
  );
}

Map<String, dynamic> _$FilterBarItemModelToJson(FilterBarItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'valueItems': instance.valueItems,
      'values': instance.values,
      'displayText': instance.displayText,
      'singleSelect': instance.singleSelect,
      'resetAll': instance.resetAll,
      'opened': instance.opened,
      'selected': instance.selected,
      'enableSort': instance.enableSort,
      'sortAccent': instance.sortAccent,
      'selectedValueBool': instance.selectedValueBool,
    };
