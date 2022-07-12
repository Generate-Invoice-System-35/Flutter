// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/model/invoice_model.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/view_models/invoices_view_model.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_button.dart';
import 'package:flutter_capstone_project/widgets/invoice_table.dart';
import 'package:flutter_capstone_project/widgets/filter_dropdown.dart';
import 'package:flutter_capstone_project/widgets/inputs/borderless_input.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class InvoicesFragment extends StatefulWidget {
  const InvoicesFragment({Key? key}) : super(key: key);

  @override
  State<InvoicesFragment> createState() => _InvoicesFragmentState();
}

class _InvoicesFragmentState extends State<InvoicesFragment> {
  String? searchQuery;
  Map<int, bool> checks = {};

  void changeChecksOnIdx(int idx, bool state) {
    checks[idx] = state;
    return;
  }

  void onNavigateUpload(BuildContext context) {
    context.read<FragmentManager>().navigateToFragment(fragmentEnum: FragmentEnum.uploadFragment);
  }

  void onNavigateGenerate(BuildContext context) async {
    ApiResponse<List<Invoice>> res =
        await Provider.of<InvoicesViewModel>(context, listen: false).getInvoices();
    List<int> ids = [];
    if (res.data != null) {
      checks.forEach((key, value) {
        if (value) {
          ids.add(res.data?[key].id ?? 0);
        }
      });
    }

    context
        .read<FragmentManager>()
        .navigateToFragment(fragmentEnum: FragmentEnum.invoiceItemsFragment, invoiceIdsParam: ids);
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
              checks.containsValue(true)
                  ? ElevatedButton(
                      onPressed: () => onNavigateGenerate(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(17, 9, 18, 10),
                        primary: ColorConstant.darkBlue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      child: Text(
                        "Generate",
                        style:
                            TypographyConstant.button1.merge(const TextStyle(color: Colors.white)),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 4),
          BorderlessInput(
            placeholder: "Search...",
            suffixIcon: SvgPicture.asset('assets/icons/search.svg'),
            onChange: (val) {
              setState(() {
                searchQuery = val;
              });
            },
          ),
          const SizedBox(height: 0),
          Row(
            children: [
              // TextButton.icon(
              //   style: TextButton.styleFrom(padding: EdgeInsets.zero),
              //   onPressed: () {},
              //   icon: SvgPicture.asset('assets/icons/filter.svg'),
              //   label: Text(
              //     'Filters',
              //     style: TypographyConstant.button3.merge(const TextStyle(color: Colors.black)),
              //   ),
              // ),
              FilterDropdown(changeState: setState),
              const SizedBox(width: 28),
              // TextButton.icon(
              //   style: TextButton.styleFrom(padding: EdgeInsets.zero),
              //   onPressed: () {},
              //   icon: SvgPicture.asset('assets/icons/star.svg'),
              //   label: Text(
              //     'Favorites',
              //     style: TypographyConstant.button3.merge(const TextStyle(color: Colors.black)),
              //   ),
              // ),
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
          InvoiceTable(
            tableHeight: MediaQuery.of(context).size.height - 350,
            query: searchQuery,
            checks: checks,
            changeChecksOnIdx: changeChecksOnIdx,
            changeState: setState,
          ),
        ],
      ),
    );
  }
}
