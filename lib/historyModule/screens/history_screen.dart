// DownloadScreen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:insta_canvas/historyModule/provider/history_provider.dart';

import 'package:insta_canvas/navigation/navigators.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:provider/provider.dart';
import 'package:insta_canvas/authModule/provider/auth_provider.dart';
import 'package:insta_canvas/commonWidgets/asset_svg_icon.dart';
import 'package:insta_canvas/commonWidgets/circular_loader.dart';

import 'package:insta_canvas/colors.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../ads/ad_state_provider.dart';
// Import your HomeProvider here

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Object>? itemList;
  RewardedAd? rewardedAd;
  double dH = 0.0;
  double dW = 0.0;
  double tS = 0.0;
  TextTheme customTextTheme = const TextTheme();
  Map language = {};
  bool isLoading = false;
  List<File> savedImages = [];
  late HistoryProvider historyProvider;
  AdState? adState;

  createdRewardedAd() {
    RewardedAd.load(
        adUnitId: adState!.historyRewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) => setState(() => rewardedAd = ad),
            onAdFailedToLoad: (ad) => setState(() => rewardedAd = null)));
  }

  showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createdRewardedAd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        createdRewardedAd();
      });

      rewardedAd!.show(onUserEarnedReward: (ad, reward) {});
      rewardedAd = null;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    adState = Provider.of<AdState>(context);
    createdRewardedAd();
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });

    historyProvider = Provider.of<HistoryProvider>(context, listen: false);
    List<File> images =
        await Provider.of<HistoryProvider>(context, listen: false)
            .getSavedImages();
    setState(() {
      savedImages = images;
      itemList = List.from(savedImages);
      isLoading = false;
    });

    adState!.initialization.then((status) {
      setState(() {
        for (int i = itemList!.length; i >= 0; i--) {
          itemList!.insert(
              i,
              BannerAd(
                  size: AdSize.fluid,
                  adUnitId: adState!.historyListBannerAdUnitId,
                  request: const AdRequest(),
                  listener: adState!.adListener)
                ..load());
        }
      });
    });
  }

  @override
  void dispose() {
    itemList?.forEach((item) {
      if (item is BannerAd) {
        item.dispose();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dH = MediaQuery.of(context).size.height;
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaler.scale(1.0);
    language = Provider.of<AuthProvider>(context).selectedLanguage;
    customTextTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: isLoading
          ? const CircularLoader()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: dW * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: dW * 0.07),
                  Text(
                    language['history'],
                    style: customTextTheme.headlineLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${savedImages.length} ${language['files']}',
                    style: customTextTheme.displayLarge!
                        .copyWith(color: getSubTitle(context)),
                  ),
                  SizedBox(height: dW * 0.08),
                  // Display saved images
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemList!.length,
                    itemBuilder: (context, index) {
                      if (itemList![index] is File) {
                        File imageFile = itemList![index] as File;
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: dW * .02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _generateUsernameFromFileName(
                                        imageFile.path.split('/').last),
                                    style: customTextTheme.titleLarge!.copyWith(
                                        color: getSuffixIcon(context)),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showRewardedAd();
                                          historyProvider.copyFileToGallery(
                                              imageFile.path,
                                              imageFile.path.split('/').last);
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: dW * .02),
                                          child: AssetSvgIcon(
                                            iconName: 'saveToGallery',
                                            width: dW * .07,
                                            color: getSuffixIcon(context),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: dW * .05),
                                      GestureDetector(
                                        onTap: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            deleteImage(
                                                                imageFile);
                                                            fetchData();
                                                          });

                                                          pop();
                                                        },
                                                        child: Text(
                                                            language['ok'])),
                                                    TextButton(
                                                        onPressed: () {
                                                          pop();
                                                        },
                                                        child: Text(
                                                            language['cancel']))
                                                  ],
                                                  title: Text(
                                                    language['deleteTitle'],
                                                    style: customTextTheme
                                                        .titleLarge!
                                                        .copyWith(),
                                                  ),
                                                  backgroundColor:
                                                      getAppBackground(context),
                                                )),
                                        child: AssetSvgIcon(
                                          iconName: 'delete',
                                          width: dW * .05,
                                          color: getSuffixIcon(context),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: dW * .02),
                            ZoomOverlay(
                              modalBarrierColor: Colors.black12,
                              animationCurve: Curves.fastOutSlowIn,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              twoTouchOnly: true,
                              child: InstaImageViewer(
                                disposeLevel: DisposeLevel.low,
                                disableSwipeToDismiss: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.file(
                                    imageFile,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: dW * .08),
                          ],
                        );
                      } else {
                        return SizedBox(
                          height: 50,
                          child: AdWidget(
                            ad: itemList![index] as BannerAd,
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
    );
  }

  String _generateUsernameFromFileName(String fileName) {
    // Extract username from file name
    List<String> parts = fileName.split('-');
    if (parts.isNotEmpty) {
      if (parts[0].contains(' ')) {
        parts[0] = parts[0].replaceAllMapped(' ', (match) => '.');
      }
      return parts[0];
    } else {
      return '';
    }
  }

  void deleteImage(File imageFile) async {
    await historyProvider.deleteImage(imageFile);
  }
}
