import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_app/config/theme.dart';
import 'package:crypto_app/core/providers/theme_provider.dart';
import 'package:crypto_app/features/home/home_screen.dart';
import 'package:crypto_app/features/market/market_screen.dart';
import 'package:crypto_app/features/wallet/wallet_screen.dart';
import 'package:crypto_app/features/transactions/transactions_screen.dart';
import 'package:crypto_app/features/settings/settings_screen.dart';
import 'package:crypto_app/features/send/send_screen.dart';
import 'package:crypto_app/features/receive/receive_screen.dart';
import 'package:crypto_app/features/swap/swap_screen.dart';
import 'package:crypto_app/features/qr_scan/qr_scan_screen.dart';
import 'package:crypto_app/features/search/search_screen.dart';
import 'package:crypto_app/features/asset_details/asset_details_screen.dart';
import 'package:crypto_app/features/settings/language_settings_screen.dart';
import 'package:crypto_app/features/settings/currency_settings_screen.dart';
import 'package:crypto_app/features/settings/security_settings_screen.dart';
import 'package:crypto_app/features/settings/help_center_screen.dart';
import 'package:crypto_app/features/settings/terms_screen.dart';
import 'package:crypto_app/features/settings/privacy_policy_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: CryptoApp()));
}

class CryptoApp extends ConsumerWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Crypto App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/send': (context) => const SendScreen(),
        '/receive': (context) => const ReceiveScreen(),
        '/swap': (context) => const SwapScreen(),
        '/scan': (context) => const QRScanScreen(),
        '/search': (context) => const SearchScreen(),
        '/asset_details': (context) => const AssetDetailsScreen(),
        '/settings/language': (context) => const LanguageSettingsScreen(),
        '/settings/currency': (context) => const CurrencySettingsScreen(),
        '/settings/security': (context) => const SecuritySettingsScreen(),
        '/settings/help': (context) => const HelpCenterScreen(),
        '/settings/terms': (context) => const TermsScreen(),
        '/settings/privacy': (context) => const PrivacyPolicyScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const WalletScreen(),
    const MarketScreen(),
    const TransactionsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),
            selectedIcon: Icon(Icons.show_chart),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
