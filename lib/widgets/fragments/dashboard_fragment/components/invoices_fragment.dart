import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_button.dart';
import 'package:flutter_capstone_project/widgets/common/table.dart';
import 'package:flutter_capstone_project/widgets/inputs/search_input.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class InvoicesFragment extends StatefulWidget {
  const InvoicesFragment({Key? key}) : super(key: key);

  @override
  State<InvoicesFragment> createState() => _InvoicesFragmentState();
}

class _InvoicesFragmentState extends State<InvoicesFragment> {
  void onNavigateUpload(BuildContext context) {
    context.read<FragmentManager>().navigateToFragment(fragmentEnum: FragmentEnum.uploadFragment);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text("Invoices", style: TypographyConstant.title),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              GradientButton(
                "Upload",
                gradient: ColorConstant.orangeGradient,
                onTap: () => onNavigateUpload(context),
                padding: const EdgeInsets.fromLTRB(17, 9, 18, 10),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                height: 40,
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(17, 9, 18, 10),
                  primary: ColorConstant.darkBlue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                child: Text(
                  "Generate",
                  style: TypographyConstant.button1.merge(const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SearchInput(
            placeholder: "Search...",
          ),
          const SizedBox(height: 0),
          Row(
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/filter.svg'),
                label: Text(
                  'Filters',
                  style: TypographyConstant.button3.merge(const TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(width: 28),
              TextButton.icon(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/star.svg'),
                label: Text(
                  'Favorites',
                  style: TypographyConstant.button3.merge(const TextStyle(color: Colors.black)),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              const Text("1/1", style: TypographyConstant.button3),
              SizedBox(
                width: 40,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/triangle-left.svg'),
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/triangle-right.svg'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const TableComponent(tableHeight: 500),
        ],
      ),
    );
  }
}
