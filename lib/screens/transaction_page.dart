import 'package:accountant_app/constants/app_themes/buttom_navigation_theme.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/providers/current_user_provider.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:accountant_app/screens/aboutDevelopper.dart';
import 'package:accountant_app/screens/add_transaction_form.dart';
import 'package:accountant_app/screens/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  static const String transactionsPageRoute = '/transactions';
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            TransactionProvider(userId: SupabaseConfig().currentUserId),
        child: const _TransactionPage());
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
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: transactionProvider.currentIndex == 4
            ? Text(ApplicationLocalization.translator!.aboutDeveloper)
            : Text(ApplicationLocalization.translator!.transactions),
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
        children: <Widget>[
          const AddTransactionForm(),
          const TransactionList(
            pageIndex: 1,
          ),
          const TransactionList(
            pageIndex: 2,
          ),
          const TransactionList(
            pageIndex: 3,
          ),
          AboutDeveloper(),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: BottomNavigationTabBarTheme().initialSelectedTab,
        labels: BottomNavigationTabBarTheme().labels,
        icons: BottomNavigationTabBarTheme().icons,
        badges: BottomNavigationTabBarTheme().primaryBadges,
        tabSize: BottomNavigationTabBarTheme().tabSize,
        tabBarHeight: BottomNavigationTabBarTheme().tabBarHeight,
        textStyle: BottomNavigationTabBarTheme().textStyle,
        tabIconColor: BottomNavigationTabBarTheme().tabIconColor,
        tabIconSize: BottomNavigationTabBarTheme().tabIconSize,
        tabIconSelectedSize: BottomNavigationTabBarTheme().tabIconSelectedSize,
        tabSelectedColor: BottomNavigationTabBarTheme().tabSelectedColor,
        tabIconSelectedColor:
            BottomNavigationTabBarTheme().tabIconSelectedColor,
        tabBarColor: BottomNavigationTabBarTheme().tabBarColor,
        onTabItemSelected: (int value) async {
          setState(() {
            _motionTabBarController!.index = value;
          });
          await transactionProvider
              .updateCurrentIndex(_motionTabBarController!.index);
        },
      ),
    );
  }
}
