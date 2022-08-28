import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_fonts.dart';

class DetailIncome extends StatelessWidget {
  const DetailIncome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return PreferredSize(
        preferredSize: Size.square(60),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColor.bgColor3,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Row(
            children: [
              Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "29 Jun 2022",
                      style: AppFont.primaryTextStyle.copyWith(fontSize: 16),
                    ),
                    Icon(
                      Icons.add_to_photos_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
        body: Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Total",
              style: AppFont.secondaryTextStyle,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Rp. 300.000",
              style: AppFont.primaryTextStyle,
            ),
            SizedBox(
              height: 16,
            ),
            space(),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                  itemCount: 10,
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
                          Text(
                            "1",
                            style: AppFont.secondaryTextStyle
                                .copyWith(fontWeight: FontWeight.bold),
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
                                    "Teh",
                                    style: AppFont.secondaryTextStyle
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Rp. 10.000",
                                    style: AppFont.secondaryTextStyle
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
