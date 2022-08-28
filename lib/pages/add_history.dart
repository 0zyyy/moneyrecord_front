import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/presentation/controller/c_history.dart';
import 'package:untitled/presentation/controller/c_home.dart';
import 'package:untitled/presentation/controller/c_user.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_fonts.dart';
import 'package:untitled/widgets/form_widget.dart';

class AddHistoryPage extends StatefulWidget {
  const AddHistoryPage({Key? key}) : super(key: key);

  @override
  State<AddHistoryPage> createState() => _AddHistoryPageState();
}

class _AddHistoryPageState extends State<AddHistoryPage> {
  final cHistory = Get.put(HistoryController());
  final cUser = Get.put(UserController());

  //textEditControl
  TextEditingController sumberController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  DateTime? ngeng = DateTime.now();
  List<String> ngong = ["Ngang", "ngeng", "nguing"];

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return PreferredSize(
        preferredSize: Size.square(60),
        child: Container(
          width: double.infinity,
          height: 200,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColor.bgColor3,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "Add History",
                style: AppFont.primaryTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal",
            style: AppFont.secondaryTextStyle,
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text(
                DateFormat("yyyy-MM-dd").format(ngeng ?? DateTime.now()),
                style: AppFont.secondaryTextStyle,
              ),
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
                    backgroundColor: AppColor.bgUnselected,
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
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: AppFont.secondaryTextStyle,
                      )))
                  .toList(),
              onChanged: (value) {
                print(value);
              },
              hint: Text(
                "Pemasukan",
                style: AppFont.secondaryTextStyle,
              ),
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
            label: "Sumber/Hasil Jual",
            controller: sumberController,
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
            controller: hargaController,
            border: 12,
          )
        ],
      );
    }

    Widget itemsFieldTitle() {
      return Container(
        margin: EdgeInsets.only(left: 16, top: 20, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items',
              style: AppFont.primaryTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
    }

    Widget space() {
      return Container(
        margin: EdgeInsets.all(16),
        height: 3,
        width: 30,
        decoration: BoxDecoration(color: Colors.grey),
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
            children: List.generate(ngong.length, (index) {
              return Chip(
                elevation: 1,
                label: Text(ngong[index]),
                deleteIcon: const Icon(Icons.clear),
                onDeleted: () => {},
              );
            }),
          ));
    }

    Widget totalAmountText() {
      return Container(
        margin: EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              "Total",
              style: AppFont.secondaryTextStyle,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              "Rp. 300.000",
              style: AppFont.primaryTextStyle,
            )
          ],
        ),
      );
    }

    Widget bottomBar() {
      return Material(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Ink(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.priceColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: InkWell(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              onTap: () async {
                if (await cHistory.addHistory(
                    cUser.user.idUser!, cUser.user.token)) {
                  Get.snackbar("Bisa", "Masuk");
                } else {
                  Get.snackbar("Gabisa", "Masuk");
                }
              },
              child: Center(
                child: Text(
                  "Submit",
                  style: AppFont.primaryTextStyle.copyWith(fontSize: 16),
                ),
              ),
            )),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor1,
        appBar: appBar(),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            header(),
            tipe(),
            sumber(),
            harga(),
            space(),
            itemsFieldTitle(),
            itemsField(),
            totalAmountText()
          ],
        ),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }
}
