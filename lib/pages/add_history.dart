import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/presentation/controller/c_history.dart';
import 'package:untitled/presentation/controller/c_home.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_fonts.dart';
import 'package:untitled/widgets/form_widget.dart';

class AddHistoryPage extends StatefulWidget {
  const AddHistoryPage({Key? key}) : super(key: key);

  @override
  State<AddHistoryPage> createState() => _AddHistoryPageState();
}

class _AddHistoryPageState extends State<AddHistoryPage> {
  DateTime? ngeng = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tanggal"),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text(DateFormat("yyyy-MM-dd").format(ngeng ?? DateTime.now())),
              SizedBox(
                width: 12,
              ),
              TextButton(
                onPressed: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001, 1, 1),
                      lastDate: DateTime(2066, 1, 1));
                  setState(() {
                    ngeng = date;
                  });
                },
                style: TextButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: EdgeInsets.all(6)),
                child: Row(children: [
                  Icon(
                    Icons.date_range,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Pilih",
                    style: AppFont.primaryTextStyle.copyWith(fontSize: 10),
                  )
                ]),
              ),
            ],
          ),
        ],
      );
    }

    Widget tipe() {
      return Column(
        children: [
          SizedBox(
            height: 16,
          ),
          DropdownButtonFormField(
              items: ["Pemasukan", "Pengeluaran"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                print(value);
              },
              hint: Text("Pemasukan"),
              decoration:
                  InputDecoration(border: OutlineInputBorder(), isDense: true))
        ],
      );
    }

    Widget sumber() {
      return Column(
        children: [
          SizedBox(
            height: 16,
          ),
          FormWidget(
            text: "Jualan",
            label: "Sumber",
            controller: TextEditingController(),
            border: 12,
          )
        ],
      );
    }

    Widget harga() {
      return Column(
        children: [
          SizedBox(
            height: 16,
          ),
          FormWidget(
            text: "30000",
            label: "Harga",
            controller: TextEditingController(),
            border: 12,
          )
        ],
      );
    }

    Widget itemsField() {
      return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Wrap(
            runSpacing: 0,
            spacing: 8,
            children: List.generate(4, (index) {
              return Chip(
                label: Text("KONTOL"),
                deleteIcon: const Icon(Icons.clear),
                onDeleted: () => {},
              );
            }),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add History"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [header(), tipe(), sumber(), harga(), itemsField()],
      ),
    );
  }
}
