import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_svg/svg.dart';

class FilterDropdown extends StatefulWidget {
  const FilterDropdown({Key? key}) : super(key: key);

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  String? selectedValue;
  final List<String> items = [
    'Unpaid',
    'Paid',
    'Pending',
    'Expired',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Row(
        children: [
          SvgPicture.asset('assets/icons/filter.svg'),
          const SizedBox(width: 10),
          Text(
            selectedValue ?? 'Filters',
            style: TypographyConstant.button3.merge(const TextStyle(color: Colors.black)),
          ),
        ],
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Row(
            children: [
              Text(item),
              item == selectedValue
                  ? const SizedBox(
                      width: 8,
                    )
                  : const SizedBox.shrink(),
              item == selectedValue
                  ? const Icon(Icons.close_outlined, size: 20, color: Colors.red)
                  : const SizedBox.shrink()
            ],
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue == selectedValue) {
          return setState(() {
            selectedValue = null;
          });
        }
        setState(() {
          selectedValue = newValue;
        });
      },
      iconSize: 0,
      underline: const SizedBox.shrink(),
    );
  }
}
