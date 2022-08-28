import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_fonts.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _toggle = true;
  bool _peng = true;

  List<Map> ngeng = [
    {"type": "Pengeluaran", "nama": "Teh", "harga": "Rp. 30.000"},
    {"type": "Pengeluaran", "nama": "Refresh", "harga": "Rp. 40.000"},
    {"type": "Pengeluaran", "nama": "Milo", "harga": "Rp. 30.000"},
    {"type": "Pemasukan", "nama": "Sembarang", "harga": "Rp. 30.000"},
    {"type": "Pengeluaran", "nama": "Ihir", "harga": "Rp. 300.000"},
    {"type": "Pengeluaran", "nama": "Ultra milk", "harga": "Rp. 15.000"},
    {"type": "Pemasukan", "nama": "Teh", "harga": "Rp. 30.000"},
  ];

  void _doToggle() => setState(() {
        _toggle = !_toggle;
      });
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        automaticallyImplyLeading: false,
        title: Stack(children: [
          SizedBox(
              height: kToolbarHeight * 0.8,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("History"),
                        GestureDetector(
                          onTap: () => _doToggle(),
                          child: Icon(
                            Icons.search,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          AnimatedContainer(
            width: _toggle ? 0 : MediaQuery.of(context).size.width,
            transform: Matrix4.translationValues(
                _toggle ? MediaQuery.of(context).size.width : 0, 0, 0),
            duration: const Duration(milliseconds: 250),
            height: kToolbarHeight * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                width: 1,
                color: Colors.grey[600]!,
              ),
            ),
            child: TextField(
              textInputAction: TextInputAction.search,
              style: AppFont.secondaryTextStyle.copyWith(fontSize: 20),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 7),
                  prefixIcon: AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: _toggle ? 0 : 1,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: _doToggle,
                      )),
                  border: InputBorder.none),
            ),
          )
        ]),
        backgroundColor: AppColor.bgNavBar,
      );
    }

    Widget space() {
      return Container(
        margin: EdgeInsets.all(16),
        height: 3,
        width: 40,
        decoration: BoxDecoration(color: Colors.grey),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: AppColor.bgColor1,
        body: LayoutBuilder(builder: (context, constrains) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constrains.maxHeight),
              child: Container(
                padding: EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "2022-06-18",
                        style: AppFont.primaryTextStyle,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      space(),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: ListView.builder(
                            itemCount: ngeng.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                margin: EdgeInsets.only(bottom: 10),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: AppColor.bgNavBar,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.south_west,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              ngeng[index]["nama"],
                                              style: AppFont.secondaryTextStyle
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Text(
                                              ngeng[index]["harga"],
                                              style: AppFont.secondaryTextStyle
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      Icons.shopping_bag,
                                      color: AppColor.bgUnselected,
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
