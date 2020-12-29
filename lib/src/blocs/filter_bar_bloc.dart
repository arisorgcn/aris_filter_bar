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

import 'dart:async';

import 'package:aris_filter_bar/src/model/filter_bar_item_entity.dart';
import 'package:aris_filter_bar/src/model/filter_bar_item_model.dart';
import 'package:aris_filter_bar/src/repository/filter_bar_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_bar_event.dart';

part 'filter_bar_state.dart';

///
/// Filter bar bloc
/// @author Aris Hu created at 2020-12-28
///
class FilterBarBloc extends Bloc<FilterBarEvent, FilterBarState> {
  final BaseFilterBarRepository filterBarRepository;

  FilterBarBloc(this.filterBarRepository) : super(FilterBarLoading());

  @override
  Stream<FilterBarState> mapEventToState(
    FilterBarEvent event,
  ) async* {
    if (event is LoadItemsEvent) {
      yield* _mapLoadFilterItemsToState();
    }
  }

  Stream<FilterBarState> _mapLoadFilterItemsToState() async* {
    try {
      final List<FilterBarItemEntity> filterItems = await filterBarRepository.loadFilterItems();
      yield FilterBarLoaded(filterItems: filterItems.map((e) => FilterBarItemModel.fromEntity(e)).toList());
    } catch (e) {
      yield FilterBarNotLoaded();
    }
  }
}
