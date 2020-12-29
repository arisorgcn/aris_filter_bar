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

part 'filter_bar_item_value_model.g.dart';

///
/// @author Aris Hu created at 2020-12-28
///
@JsonSerializable()
class FilterBarItemValueModel {
  final String id;

  @JsonKey(name: "name")
  final String text;

  @JsonKey(name: "value")
  final String value;

  FilterBarItemValueModel(this.id, this.text, this.value);

  static FilterBarItemValueModel fromJson(Map<String, dynamic> json) => _$FilterBarItemValueModelFromJson(json);

  @override
  String toString() {
    return 'FilterBarItemValueModel{id: $id, text: $text, value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterBarItemValueModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          value == other.value;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ value.hashCode;
}
