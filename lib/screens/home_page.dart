import 'package:accountant_app/constants/app_themes/buttom_navigation_theme.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/providers/current_user_provider.dart';
import 'package:accountant_app/providers/expenses.dart';
import 'package:accountant_app/providers/incomes.dart';
import 'package:accountant_app/providers/transactions.dart';
import 'package:accountant_app/screens/aboutDevelopper.dart';
import 'package:accountant_app/screens/add_transaction_form.dart';
import 'package:accountant_app/screens/expenses_list.dart';
import 'package:accountant_app/screens/incomes_list.dart';
import 'package:accountant_app/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String pageRoute = '/homePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final homePageProvider = context.watch<HomePageProvider>();
    return const _TransactionPage();
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<Transactions>(
    //       create: (context) => Transactions(),
    //     ),
    //     ChangeNotifierProvider<Expenses>(
    //       create: (context) => Expenses(),
    //     ),
    //     ChangeNotifierProvider<Incomes>(
    //       create: (context) => Incomes(),
    //     )
    //   ],
    //   child: const _TransactionPage(),
    // );
  }
}

class _TransactionPage extends StatefulWidget {
  const _TransactionPage({Key? key}) : super(key: key);

  @override
  State<_TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<_TransactionPage>
    with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _motionTabBarController!.index == 4
            ? Text(ApplicationLocalization.translator.aboutDeveloper)
            : Text(ApplicationLocalization.translator.transactions),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: CurrentUserProvider().logOut,
          )
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: [
          const AddTransactionForm(),
          ChangeNotifierProvider(
            create: (_) => Transactions(),
            child: const TransactionsList(),
          ),
          ChangeNotifierProvider(
              create: (_) => Expenses(), child: const ExpensesList()),
          ChangeNotifierProvider(
              create: (_) => Incomes(), child: const IncomesList()),
          AboutDeveloper(),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: ApplicationLocalization.translator.add,
        labels: [
          ApplicationLocalization.translator.add,
          ApplicationLocalization.translator.transactions,
          ApplicationLocalization.translator.expenses,
          ApplicationLocalization.translator.incomes,
          ApplicationLocalization.translator.aboutDeveloper
        ],
        // labels: BottomNavigationTabBarTheme.labels,
        icons: BottomNavigationTabBarTheme.icons,
        badges: BottomNavigationTabBarTheme.primaryBadges,
        tabSize: BottomNavigationTabBarTheme.tabSize,
        tabBarHeight: BottomNavigationTabBarTheme.tabBarHeight,
        textStyle: BottomNavigationTabBarTheme.textStyle,
        tabIconColor: BottomNavigationTabBarTheme.tabIconColor,
        tabIconSize: BottomNavigationTabBarTheme.tabIconSize,
        tabIconSelectedSize: BottomNavigationTabBarTheme.tabIconSelectedSize,
        tabSelectedColor: BottomNavigationTabBarTheme.tabSelectedColor,
        tabIconSelectedColor: BottomNavigationTabBarTheme.tabIconSelectedColor,
        tabBarColor: BottomNavigationTabBarTheme.tabBarColor,
        onTabItemSelected: (int value) async {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}
