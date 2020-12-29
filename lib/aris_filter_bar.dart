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

library aris_filter_bar;

import 'package:aris_filter_bar/src/blocs/filter_bar_bloc.dart';
import 'package:aris_filter_bar/src/model/filter_bar_item_entity.dart';
import 'package:aris_filter_bar/src/model/filter_bar_item_model.dart';
import 'package:aris_filter_bar/src/model/filter_bar_item_value_model.dart';
import 'package:aris_filter_bar/src/widget/widget_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_select/smart_select.dart';

import 'src/model/filter_bar_selected_params.dart';

export 'src/blocs/filter_bar_bloc.dart';
export 'src/model/filter_bar_item_entity.dart';
export 'src/model/filter_bar_item_value_entity.dart';
export 'src/model/filter_bar_selected_params.dart';
export 'src/repository/filter_bar_repository.dart';

/// Filter bar
/// @author Aris Hu created at 2020-12-24
///
class ArisFilterBar extends StatefulWidget with PreferredSizeWidget {
  final Key filterBarKey;
  final Key filterBarLoadingKey;
  final Key filterBarEmptyKey;
  final OnFilterBarChange onFilterChange;

  /// filter bar height
  final double filterBarHeight;

  /// filter bar item's width
  final double filterItemWidth;

  /// filter bar item's height
  final double filterItemHeight;

  final Color filterBarBackgroundColor;

  final Color itemUnSelectedBackgroundColor;
  final Color itemSelectedBackgroundColor;

  final TextStyle itemUnSelectedStyle;
  final TextStyle itemSelectedStyle;

  /// accent sort icon
  final Widget accentSortUnSelectedIcon;
  final Widget accentSortSelectedIcon;

  /// decent sort icon
  final Widget decentSortUnSelectedIcon;
  final Widget decentSortSelectedIcon;

  final S2ModalType singleModalType;
  final S2ModalType multiModalType;
  final S2ChoiceType singleChoiceType;
  final S2ChoiceType multiChoiceType;

  ArisFilterBar({
    @required this.filterBarKey,
    @required this.filterBarLoadingKey,
    @required this.filterBarEmptyKey,
    this.onFilterChange,
    this.accentSortUnSelectedIcon,
    this.accentSortSelectedIcon,
    this.decentSortUnSelectedIcon,
    this.decentSortSelectedIcon,
    this.filterBarHeight = 50.0,
    this.filterItemWidth = 116.0,
    this.filterItemHeight = 44.0,
    this.filterBarBackgroundColor,
    this.itemUnSelectedBackgroundColor,
    this.itemSelectedBackgroundColor,
    this.itemUnSelectedStyle,
    this.itemSelectedStyle,
    this.singleModalType = S2ModalType.bottomSheet,
    this.multiModalType = S2ModalType.popupDialog,
    this.singleChoiceType = S2ChoiceType.radios,
    this.multiChoiceType = S2ChoiceType.chips,
  });

  @override
  _ArisFilterBarState createState() => _ArisFilterBarState();

  @override
  Size get preferredSize => Size.fromHeight(filterBarHeight);
}

class _ArisFilterBarState extends State<ArisFilterBar> {
  FilterBarSelectedParams filterParams;

  @override
  void initState() {
    super.initState();
    filterParams = FilterBarSelectedParams(filterValuesMap: {}, resetAll: false);
  }

  @override
  void dispose() {
    filterParams = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 44.0,
      decoration: BoxDecoration(
        color: widget.filterBarBackgroundColor ?? Colors.white,
      ),
      child: BlocBuilder<FilterBarBloc, FilterBarState>(
        builder: (ctx, state) {
          if (state is FilterBarLoading) {
            return LoadingIndicator(key: widget.filterBarLoadingKey);
          } else if (state is FilterBarLoaded) {
            final filterBarItems = state.filterItems;
            return _buildFilterBar(filterBarItems);
          } else {
            return SizedBox.shrink(key: widget.filterBarEmptyKey);
          }
        },
      ),
    );
  }

  Widget _buildFilterBar(List<FilterBarItemModel> filterItems) {
    return _buildFilterItems(filterItems);
  }

  bool isItemSingle(FilterBarItemModel item) => item.valueItems == null || item.valueItems.isEmpty;

  Widget _buildFilterItems(List<FilterBarItemModel> filterItems) {
    // final itemWithValueItemCount = filterItems.where((e) => !isItemSingle(e)).length;
    final itemWidth = widget
        .filterItemWidth; //(MediaQuery.of(context).size.width - 16 * itemWithValueItemCount) / filterItems.length;
    final itemHeight = widget.filterItemHeight;
    List<Widget> widgets = [];
    filterItems.forEach((item) {
      if (isItemSingle(item)) {
        widgets.add(
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            width: itemWidth,
            height: itemHeight * 0.8,
            decoration: BoxDecoration(
                color: !item.selected
                    ? widget.itemUnSelectedBackgroundColor ?? Color.fromRGBO(204, 204, 204, 0.4)
                    : widget.itemSelectedBackgroundColor ?? Colors.blueAccent.withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(60.0)),
                border: Border()),
            child: _buildSingleFilterItem(item, filterItems),
          ),
        );
      } else {
        widgets.add(Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: itemWidth,
          height: itemHeight * 0.8,
          decoration: BoxDecoration(
              color: !item.selected
                  ? widget.itemUnSelectedBackgroundColor ?? Color.fromRGBO(204, 204, 204, 0.4)
                  : widget.itemSelectedBackgroundColor ?? Colors.blueAccent.withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(60.0)),
              border: Border()),
          child: _buildPopupSelectFilterItem(item, filterItems),
        ));
      }
    });
    return Scrollbar(
      thickness: 0.1,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: widgets,
        ),
      ),
    );
  }

  Widget _buildSingleFilterItem(FilterBarItemModel item, List<FilterBarItemModel> items) {
    ThemeData themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: () {
            _selectCurrentItem(items, item);
            _fireFilterChange();
          },
          padding: EdgeInsets.zero,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        margin: EdgeInsets.only(right: 18.0),
                        child: Text(
                          item.title,
                          style: !item.selected
                              ? widget.itemUnSelectedStyle ?? themeData.textTheme.subtitle1.copyWith()
                              : widget.itemSelectedStyle ??
                                  themeData.textTheme.subtitle1.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      if (item.enableSort)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(width: 8.0),
                            if (item.sortAccent)
                              !item.selected
                                  ? widget.accentSortUnSelectedIcon ??
                                      Icon(
                                        Icons.south,
                                        size: 16.0,
                                        color: Color(0xFF888888),
                                      )
                                  : widget.accentSortSelectedIcon ??
                                      Icon(
                                        Icons.south,
                                        size: 16.0,
                                        color: Color(0xFF333333),
                                      )
                            else
                              !item.selected
                                  ? (widget.decentSortUnSelectedIcon ??
                                      Icon(
                                        Icons.north,
                                        size: 16.0,
                                        color: Color(0xFF888888),
                                      ))
                                  : (widget.decentSortSelectedIcon ??
                                      Icon(
                                        Icons.north,
                                        size: 16.0,
                                        color: Color(0xFF333333),
                                      ))
                          ],
                        ),
                    ],
                  ),
                ),
                fit: FlexFit.loose,
                flex: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPopupSelectFilterItem(FilterBarItemModel item, List<FilterBarItemModel> items) {
    return item.singleSelect ? _buildSingleSelectItem(item, items) : _buildMultiSelectItem(item, items);
  }

  /// build popup single select item
  Widget _buildSingleSelectItem(FilterBarItemModel item, List<FilterBarItemModel> items) {
    return SmartSelect<String>.single(
      title: item.title,
      placeholder: '',
      value: (item.values == null || item.values.isEmpty) ? null : item.values[0],
      onChange: (state) {
        // print('************values = ${state.value} **************');
        if (item.values != null && state.value != null) {
          if (item.values.isNotEmpty) {
            if (item.values.elementAt(0) != state.value) {
              // 只有当值改变时, 才会触发
              setState(() {
                item.values[0] = state.value;
              });
              Future.delayed(Duration(milliseconds: 20), () {
                _selectCurrentItem(items, item);
                _fireFilterChange();
              });
            }
          } else {
            setState(() {
              item.values = [state.value];
            });
            Future.delayed(Duration(milliseconds: 20), () {
              _selectCurrentItem(items, item);
              _fireFilterChange();
            });
          }
        } else {
          setState(() {
            item.values = [];
          });
        }
      },
      // choiceGrouped: true,
      choiceItems: S2Choice.listFrom<String, FilterBarItemValueModel>(
        source: item.valueItems,
        value: (index, valueItem) => valueItem.value,
        title: (index, valueItem) => valueItem.text,
      ),
      choiceType: widget.singleChoiceType,
      modalType: widget.singleModalType,
      modalHeader: true,
      tileBuilder: (context, state) {
        return Center(
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            onPressed: () {
              if (!item.selected) {
                _selectCurrentItem(items, item);
              }
              state.showModal();
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 16.0),
                          child: Text(
                            item.values == null || item.values.isEmpty
                                ? item.title
                                : (item.values.isNotEmpty)
                                    ? item.valueItems.firstWhere((e) => e.value == item.values.elementAt(0)).text
                                    : item.title,
                            maxLines: 1,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: !item.selected
                                ? widget.itemUnSelectedStyle ??
                                    TextStyle(fontWeight: FontWeight.normal, color: Color(0xFF333333))
                                : widget.itemSelectedStyle ??
                                    TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            !item.selected
                                ? Icon(
                                    Icons.arrow_drop_down,
                                    size: 18,
                                    color: widget.itemUnSelectedStyle?.color ?? Color(0xFF888888),
                                  )
                                : Icon(
                                    Icons.arrow_drop_down,
                                    size: 18,
                                    color: widget.itemSelectedStyle?.color ?? Color(0xFF333333),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// build popup multi select item
  Widget _buildMultiSelectItem(FilterBarItemModel item, List<FilterBarItemModel> items) {
    return SmartSelect<String>.multiple(
      title: item.title,
      placeholder: '',
      value: item.values,
      onChange: (state) {
        // print('************values = ${state.value} **************');
        if (item.values.join('') != state.value.join('')) {
          // 只有当值改变时, 才会触发
          setState(() {
            item.values = state.value;
          });
          Future.delayed(Duration(milliseconds: 20), () {
            _selectCurrentItem(items, item);
            _fireFilterChange();
          });
        }
      },
      choiceItems: S2Choice.listFrom<String, FilterBarItemValueModel>(
        source: item.valueItems,
        value: (index, valueItem) => valueItem.value,
        title: (index, valueItem) => valueItem.text,
      ),
      choiceType: widget.multiChoiceType,
      modalType: widget.multiModalType,
      tileBuilder: (context, state) => Center(
        child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          onPressed: () {
            if (!item.selected) {
              _selectCurrentItem(items, item);
            }
            state.showModal();
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 10.0),
                        child: Text(
                          item.values == null || item.values.isEmpty
                              ? item.title
                              : item.valueItems
                                  .where((e) => item.values.contains(e.value))
                                  .map((e) => e.text)
                                  .toList()
                                  .join(','),
                          maxLines: 1,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: !item.selected
                              ? widget.itemUnSelectedStyle ??
                                  TextStyle(fontWeight: FontWeight.normal, color: Color(0xFF333333))
                              : widget.itemSelectedStyle ??
                                  TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          !item.selected
                              ? Icon(
                                  Icons.arrow_drop_down,
                                  size: 18,
                                  color: widget.itemUnSelectedStyle?.color ?? Color(0xFF888888),
                                )
                              : Icon(
                                  Icons.arrow_drop_down,
                                  size: 18,
                                  color: widget.itemSelectedStyle?.color ?? Color(0xFF333333),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fireFilterChange() {
    Future.delayed(Duration(milliseconds: 1000), () {
      widget.onFilterChange(filterParams);
    });
  }

  void _selectCurrentItem(List<FilterBarItemModel> items, FilterBarItemModel item) {
    setState(() {
      if (item.enableSort && item.selected) {
        item.sortAccent = !item.sortAccent;
      }
      items.forEach((e) {
        e.selected = false;
      });
      item.selected = true;
    });

    if (item.resetAll) {
      filterParams.resetAll = true;
    } else {
      filterParams.resetAll = false;
      final itemKey = item.id;
      if (item.values != null && filterParams.filterValuesMap.containsKey(itemKey)) {
        filterParams.filterValuesMap
            .update(itemKey, (value) => FilterBarItemEntity.fromModel(item.copyWith()).toJson());
      } else {
        filterParams.filterValuesMap
            .putIfAbsent(itemKey, () => FilterBarItemEntity.fromModel(item.copyWith()).toJson());
      }

      print('filterParams: ${filterParams.filterValuesMap.toString()}');
    }
  }
}

/// filter回调接口
typedef OnFilterBarChange = void Function(FilterBarSelectedParams);
