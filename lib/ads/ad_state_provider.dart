import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get homeBannerAdUnitId => Platform.isAndroid
      ? "ca-app-pub-1056908307573409/7474080544"
      : "ca-app-pub-1056908307573409/3701290834";

  String get historyListBannerAdUnitId => Platform.isAndroid
      ? "ca-app-pub-1056908307573409/3213387436"
      : "ca-app-pub-1056908307573409/9879207449";

  String get searchInterstitialAdUnitId => Platform.isAndroid
      ? "ca-app-pub-1056908307573409/4459004587"
      : "ca-app-pub-1056908307573409/9647752082";

  String get homeColumnInterstitialAdUnitId => Platform.isAndroid
      ? "ca-app-pub-1056908307573409/4762256915"
      : "ca-app-pub-1056908307573409/1948746533";

  String get historyRewardedAdUnitId => Platform.isAndroid
      ? "ca-app-pub-1056908307573409/9201029526"
      : "ca-app-pub-1056908307573409/5939962436";

  BannerAdListener get adListener => _adListener;

  final BannerAdListener _adListener = BannerAdListener(
      onAdLoaded: (ad) => debugPrint('Ad loaded: ${ad.adUnitId}.'),
      onAdClosed: (ad) => debugPrint('Ad closed: ${ad.adUnitId}.'),
      onAdFailedToLoad: (ad, error) =>
          debugPrint('Ad failed to load: ${ad.adUnitId}, $error.'),
      onAdOpened: (ad) => debugPrint('ad opened: ${ad.adUnitId}'),
      onAdClicked: (ad) => debugPrint('ad clicked: ${ad.adUnitId}.'),
      onAdImpression: (ad) => debugPrint('ad impression: ${ad.adUnitId}.'),
      onPaidEvent: (ad, valueMicros, precision, currencyCode) => debugPrint(
          'ad paid:  ad=${ad.adUnitId}, valueMicros=$valueMicros, precision=${precision.name}, currencyCode=$currencyCode'),
      onAdWillDismissScreen: (ad) =>
          debugPrint('ad will dismiss screen: ${ad.adUnitId}'));
}
