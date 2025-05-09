import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:accountant_app/services/home_service.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeService homeService = HomeService();
  Map<String, double>? amouts;
  bool isLoading = true;
  String? errorMessage;

  HomeProvider() {
    init();
  }

  Future<void> init() async {
    final response = await ExceptionHandler().exceptionCatcher<void>(
        function: () => getTotals(), showSnackbar: false);

    if (response.isError) {
      errorMessage = response.error;
    }
  }

  Future<void> getTotals() async {
    isLoading = true;
    amouts = await homeService.tranactionsAmounts();
    isLoading = false;
    notifyListeners();
  }
}
