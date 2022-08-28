import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/presentation/controller/c_history.dart';
import 'package:untitled/presentation/controller/c_home.dart';
import 'package:untitled/presentation/controller/c_user.dart';
import 'package:untitled/services/history_service.dart';
import 'package:untitled/utils/app_asset.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_fonts.dart';
import 'package:untitled/utils/session.dart';
import 'package:untitled/widgets/bar_chart.dart';
import 'package:untitled/widgets/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(UserController());
  final cHome = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    cHome.getAnalysis(cUser.user.idUser!, cUser.user.token!);
    // print(cHome.weekText());
    // print(cHome.tooltipWeekText());
  }

  Widget menuItem(String text) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppFont.secondaryTextStyle,
          ),
          Icon(
            Icons.chevron_right,
            color: AppColor.secondaryTextColor,
          )
        ],
      ),
    );
  }

  Widget drawer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      decoration: BoxDecoration(color: AppColor.bgColor3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppAsset.profil),
          SizedBox(
            height: 20,
          ),
          Text(
            'Menu',
            style: AppFont.primaryTextStyle
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
              onTap: () {
                Get.toNamed("/tambah");
              },
              child: menuItem('Tambah Baru')),
          menuItem('Pemasukan'),
          menuItem('Pengeluaran'),
          GestureDetector(
              onTap: () {
                Get.toNamed("/history");
              },
              child: menuItem('Riwayat')),
          SizedBox(
            height: 20,
          ),
          Text(
            'General',
            style: AppFont.primaryTextStyle
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          menuItem('Privacy & Policy'),
          menuItem('Term of Service'),
          menuItem('Rate App'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Session.clearUser();
                  Get.toNamed('/login');
                },
                child: Image.asset(AppAsset.profil)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Obx(
                    () => Text(
                      cUser.user.name ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Builder(builder: (ctx) {
              return Material(
                color: AppColor.chart,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Scaffold.of(ctx).openEndDrawer();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                      padding: EdgeInsets.all(8), child: Icon(Icons.menu)),
                ),
              );
            }),
          ],
        ),
      );
    }

    Widget expensesNowTitle() {
      return Container(
        margin: EdgeInsets.only(left: 16, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengeluaran hari ini',
              style: AppFont.primaryTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
    }

    Widget expensesNow() {
      return Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(left: 30, top: 30, bottom: 30),
        decoration: BoxDecoration(
            color: AppColor.bgColor2, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Text(
                cHome.today.toString(),
                style: AppFont.primaryTextStyle,
              );
            }),
            SizedBox(
              height: 6,
            ),
            Obx(() {
              return Text(
                cHome.todayPercent,
                style: AppFont.secondaryTextStyle,
              );
            }),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              margin: EdgeInsets.only(left: 10, top: 16),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed("/history");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Selengkapnya"), Icon(Icons.chevron_right)],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget barChartTitle() {
      return Container(
        margin: EdgeInsets.only(left: 16, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengeluaran minggu ini',
              style: AppFont.primaryTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    Widget pieChartTitle() {
      return Container(
        margin: EdgeInsets.only(left: 16, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perbandingan bulan lalu dengan sekarang',
              style: AppFont.primaryTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgColor1,
      endDrawer: Drawer(
        backgroundColor: AppColor.bgColor3,
        width: 300,
        child: drawer(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            header(),
            expensesNowTitle(),
            expensesNow(),
            barChartTitle(),
            GetBuilder<HomeController>(builder: (context) {
              return ExpensesChart(
                  tooltipWeeks: cHome.tooltipWeekText(),
                  weeks: cHome.weekText(),
                  weeksValue: cHome.week);
            }),
            pieChartTitle(),
            GetBuilder<HomeController>(builder: (context) {
              return PieChartExpenses(
                income: context.monthIncome,
                outcome: context.monthOutcome,
              );
            }),
          ],
        ),
      ),
    );
  }
}
