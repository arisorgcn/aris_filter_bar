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

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_bar_item_value_entity.g.dart';

///
/// Filter Bar Item's value item entity
/// @author Aris Hu created at 2020-12-28
///
@JsonSerializable()
class FilterBarItemValueEntity {
  /// value item's id
  String id;

  /// value item's name
  String name;

  /// value item's value
  String value;

  FilterBarItemValueEntity({@required this.id, @required this.name, @required this.value});

  /// convert json to object
  static FilterBarItemValueEntity fromJson(Map<String, dynamic> json) => _$FilterBarItemValueEntityFromJson(json);

  /// convert object to json
  Map<String, dynamic> toJson() => _$FilterBarItemValueEntityToJson(this);

  @override
  String toString() {
    return 'FilterBarItemValueEntity{id: $id, name: $name, value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterBarItemValueEntity && runtimeType == other.runtimeType && id == other.id && value == other.value;

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}
