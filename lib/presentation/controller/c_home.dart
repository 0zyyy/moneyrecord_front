import 'package:get/get.dart';
import 'package:untitled/services/history_service.dart';

class HomeController extends GetxController {
  final _today = 0.0.obs;

  double get today => _today.value;

  final _todayPercent = ''.obs;

  String get todayPercent => _todayPercent.value;
  final _week = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ].obs;
  List<String> get days => ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"];
  List<String> get toolTipWeek =>
      ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"];
  List<String> weekText() {
    DateTime today = DateTime.now();
    return [
      days[today.subtract(const Duration(days: 6)).weekday - 1],
      days[today.subtract(const Duration(days: 5)).weekday - 1],
      days[today.subtract(const Duration(days: 4)).weekday - 1],
      days[today.subtract(const Duration(days: 3)).weekday - 1],
      days[today.subtract(const Duration(days: 2)).weekday - 1],
      days[today.subtract(const Duration(days: 1)).weekday - 1],
      days[today.subtract(const Duration(days: 0)).weekday - 1],
    ];
  }

  List<String> tooltipWeekText() {
    DateTime today = DateTime.now();
    return [
      toolTipWeek[today.subtract(const Duration(days: 6)).weekday - 1],
      toolTipWeek[today.subtract(const Duration(days: 5)).weekday - 1],
      toolTipWeek[today.subtract(const Duration(days: 4)).weekday - 1],
      toolTipWeek[today.subtract(const Duration(days: 3)).weekday - 1],
      toolTipWeek[today.subtract(const Duration(days: 2)).weekday - 1],
      toolTipWeek[today.subtract(const Duration(days: 1)).weekday - 1],
      toolTipWeek[today.subtract(const Duration(days: 0)).weekday - 1],
    ];
  }

  final _monthIncome = 0.0.obs;
  double get monthIncome => _monthIncome.value;

  final _monthOutcome = 0.0.obs;
  double get monthOutcome => _monthOutcome.value;

  final _percentIncome = '0'.obs;
  String get percentIncome => _percentIncome.value;

  final _monthPercent = ''.obs;
  String get monthPercent => _monthPercent.value;

  final _differentMonth = 0.0.obs;
  double get differentMonth => _differentMonth.value;

  getAnalysis(String idUser) async {
    Map? data = await HistoryService.Analysis(int.parse(idUser));

    // today outcome
    _today.value = data!["data"]['today'].toDouble();
    double yesterday = data["data"]['yesterday'].toDouble();
    double different = (today - yesterday).abs();
    bool isSame = today.isEqual(yesterday);
    bool isPlus = today.isGreaterThan(yesterday);
    double dividerToday = (today + yesterday) == 0 ? 1 : (today + yesterday);
    double percent = (different / dividerToday) * 100;
    _todayPercent.value = isSame
        ? '100% sama dengan kemarin'
        : isPlus
            ? '+${percent.toStringAsFixed(1)}% dibanding kemarin'
            : '-${percent.toStringAsFixed(1)}% dibanding kemarin';

    _week.value = List.castFrom(data['week'].map((e) => e.toDouble()).toList());

    _monthIncome.value = data["data"]['month']['income'].toDouble();
    _monthOutcome.value = data["data"]['month']['outcome'].toDouble();
    _differentMonth.value = (monthIncome - monthOutcome).abs();
    bool isSameMonth = monthIncome.isEqual(monthOutcome);
    bool isPlusMonth = monthIncome.isGreaterThan(monthOutcome);
    double dividerMonth =
        (monthIncome + monthOutcome) == 0 ? 1 : (monthIncome + monthOutcome);
    double percentMonth = (differentMonth / dividerMonth) * 100;
    _percentIncome.value = percentMonth.toStringAsFixed(1);
    _monthPercent.value = isSameMonth
        ? 'Pemasukan\n100% sama\ndengan Pengeluaran'
        : isPlusMonth
            ? 'Pemasukan\nlebih besar $percentIncome%\ndari Pengeluaran'
            : 'Pemasukan\nlebih kecil $percentIncome%\ndari Pengeluaran';
  }
}
