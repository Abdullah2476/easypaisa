import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/account_model.dart';
import '../models/action_item_model.dart';
import '../models/debit_card_model.dart';
import '../models/promo_banner_model.dart';

class HomeViewModel extends ChangeNotifier {
  AccountModel _account = const AccountModel(
    userName: "AHMED BILAL",
    maskedPhoneNumber: "********8545",
    balance: 2450.50,
    isSignedIn: false,
  );

  int _moreServicesPageIndex = 0;
  int _miniAppsPageIndex = 0;

  AccountModel get account => _account;
  int get moreServicesPageIndex => _moreServicesPageIndex;
  int get miniAppsPageIndex => _miniAppsPageIndex;

  void toggleSignIn() {
    _account = _account.copyWith(isSignedIn: !_account.isSignedIn);
    notifyListeners();
  }

  void setMoreServicesPageIndex(int index) {
    _moreServicesPageIndex = index;
    notifyListeners();
  }

  void setMiniAppsPageIndex(int index) {
    _miniAppsPageIndex = index;
    notifyListeners();
  }

  // Quick Actions (Top 3 Cards)
  List<ActionItemModel> get quickActions => const [
        ActionItemModel(
          id: 'send_money',
          title: 'Send Money',
          customIconKey: 'send_money',
        ),
        ActionItemModel(
          id: 'bill_payment',
          title: 'Bill Payment',
          customIconKey: 'bill_payment',
        ),
        ActionItemModel(
          id: 'mobile_packages',
          title: 'Mobile Packages',
          customIconKey: 'mobile_packages',
        ),
      ];

  // More with easypaisa (12 grid items)
  List<ActionItemModel> get moreServices => const [
        ActionItemModel(
          id: 'easyload',
          title: 'Easyload',
          customIconKey: 'easyload',
        ),
        ActionItemModel(
          id: 'easycash',
          title: 'Easycash\nLoan',
          customIconKey: 'easycash',
        ),
        ActionItemModel(
          id: 'savings_pocket',
          title: 'Savings\nPocket',
          customIconKey: 'savings_pocket',
          badgeText: 'Reward',
          badgeColor: Color(0xFFE5A93C),
        ),
        ActionItemModel(
          id: 'invite_earn',
          title: 'Invite & Earn',
          customIconKey: 'invite_earn',
        ),
        ActionItemModel(
          id: 'donations',
          title: 'Donations',
          customIconKey: 'donations',
        ),
        ActionItemModel(
          id: 'term_deposit',
          title: 'Term Deposit',
          customIconKey: 'term_deposit',
        ),
        ActionItemModel(
          id: 'daily_rewards',
          title: 'Daily Rewards',
          customIconKey: 'daily_rewards',
        ),
        ActionItemModel(
          id: 'bnpl',
          title: 'Buy Now Pay\nLater',
          customIconKey: 'bnpl',
        ),
        ActionItemModel(
          id: 'insurance',
          title: 'Insurance\nMarketplace',
          customIconKey: 'insurance',
        ),
        ActionItemModel(
          id: 'mtag',
          title: 'M-Tag',
          customIconKey: 'mtag',
        ),
        ActionItemModel(
          id: 'rs1_game',
          title: 'Rs.1 Game',
          customIconKey: 'rs1_game',
        ),
        ActionItemModel(
          id: 'see_all',
          title: 'See All',
          customIconKey: 'see_all',
        ),
      ];

  // Debit Cards
  List<DebitCardModel> get debitCards => const [
        DebitCardModel(
          id: 'online_card',
          title: 'Online Card',
          subtitle: 'Only for Online Payments\nin Pakistan',
          backgroundColor: AppColors.onlineCardBg,
          hasChip: false,
          buttonText: 'Manage card',
        ),
        DebitCardModel(
          id: 'plastic_card',
          title: 'Plastic Card',
          subtitle: 'Use at any ATM or Shop\nin Pakistan',
          backgroundColor: AppColors.plasticCardBg,
          hasChip: true,
          buttonText: 'Manage card',
        ),
      ];

  // Discover MiniApps on easypaisa (8 items)
  List<ActionItemModel> get miniApps => const [
        ActionItemModel(
          id: 'tapshop',
          title: 'TapShop',
          customIconKey: 'tapshop',
          iconBgColor: Color(0xFF00A859),
        ),
        ActionItemModel(
          id: 'hbl_asset',
          title: 'HBL Asset',
          customIconKey: 'hbl_asset',
          badgeText: 'NEW',
          badgeColor: AppColors.badgeGreen,
          iconBgColor: Color(0xFF006B68),
        ),
        ActionItemModel(
          id: 'kommittee',
          title: 'Kommittee',
          customIconKey: 'kommittee',
          badgeText: 'JOIN',
          badgeColor: AppColors.badgeGreen,
          iconBgColor: Color(0xFF00B368),
        ),
        ActionItemModel(
          id: 'bookme',
          title: 'BookMe',
          customIconKey: 'bookme',
          iconBgColor: Color(0xFF0066CC),
        ),
        ActionItemModel(
          id: 'bookkaru',
          title: 'Bookkaru',
          customIconKey: 'bookkaru',
          badgeText: 'NEW',
          badgeColor: AppColors.badgeOrange,
          iconBgColor: Color(0xFFFF7A00),
        ),
        ActionItemModel(
          id: 'ktrade',
          title: 'KTrade',
          customIconKey: 'ktrade',
          iconBgColor: Color(0xFF00965E),
        ),
        ActionItemModel(
          id: 'al_meezan',
          title: 'Al Meezan',
          customIconKey: 'al_meezan',
          badgeText: 'Invest',
          badgeColor: AppColors.badgePurple,
          iconBgColor: Colors.white,
        ),
        ActionItemModel(
          id: 'more_miniapps',
          title: 'More',
          customIconKey: 'more_miniapps',
        ),
      ];

  // Tap to see what's new (Promo Banners)
  List<PromoBannerModel> get promoBanners => const [
        PromoBannerModel(
          id: 'banner_1',
          headline: 'your first bill',
          subheadline: 'could win you',
          prizeAmount: 'Rs. 5,000',
          borderGradientColors: [
            Color(0xFF00E676),
            Color(0xFF69F0AE),
          ],
          backgroundGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF00C853),
              Color(0xFF009624),
            ],
          ),
        ),
        PromoBannerModel(
          id: 'banner_2',
          headline: 'Bill Specials',
          tagOffers: [
            'Rs. 530 on mondays',
            'Rs. 600 tuesdays-sundays',
          ],
          borderGradientColors: [
            Color(0xFFE040FB),
            Color(0xFFFF9100),
          ],
          backgroundGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C3E50),
              Color(0xFF1E824C),
            ],
          ),
        ),
        PromoBannerModel(
          id: 'banner_3',
          headline: 'Crazy Deals',
          tagOffers: [
            'Rs. 700 on mondays',
            'Rs. 770 tuesdays-sundays',
          ],
          borderGradientColors: [
            Color(0xFF00E676),
            Color(0xFFE040FB),
          ],
          backgroundGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF004D40),
              Color(0xFF00796B),
            ],
          ),
        ),
        PromoBannerModel(
          id: 'banner_cornetto',
          headline: 'Love Cornetto',
          tagOffers: [
            'Up to 30% Off',
          ],
          borderGradientColors: [
            Color(0xFFFF5252),
            Color(0xFFFFD700),
          ],
          backgroundGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3E1A0C),
              Color(0xFF5D2813),
            ],
          ),
        ),
      ];
}
