import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortableTable<T> extends StatefulWidget {
  final List<T> items;
  final List<SortableTableColumn<T>> columns;

  const SortableTable({
    super.key,
    required this.items,
    required this.columns,
  });

  @override
  _SortableTableState<T> createState() => _SortableTableState<T>();
}

class _SortableTableState<T> extends State<SortableTable<T>> {
  late List<T> sortedItems;
  int? sortColumnIndex;
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    sortedItems = widget.items;
  }

  void onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
      sortedItems = widget.columns[columnIndex].onSort(sortedItems, ascending);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderRow(),
        SizedBox(height: 6.h),
        ..._buildDataRows(),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      children: widget.columns
          .asMap()
          .map((index, column) {
            final isSelected = index == sortColumnIndex;
            return MapEntry(
              index,
              column.headerBuilder(
                context,
                isSelected ? isAscending : null,
                () => onSort(index, isSelected ? !isAscending : true),
              ),
            );
          })
          .values
          .toList(),
    );
  }

  List<Widget> _buildDataRows() {
    return sortedItems.map((item) {
      return Column(
        children: [
          Row(
            children: widget.columns.map((column) => column.dataBuilder(context, item)).toList(),
          ),
          SizedBox(height: 6.h),
        ],
      );
    }).toList();
  }
}

class SortableTableColumn<T> {
  final Widget Function(BuildContext, bool? isAscending, VoidCallback onSort) headerBuilder;
  final Widget Function(BuildContext, T) dataBuilder;
  final List<T> Function(List<T>, bool ascending) onSort;

  SortableTableColumn({
    required this.headerBuilder,
    required this.dataBuilder,
    required this.onSort,
  });
}
