
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:insta_canvas/ads/ad_state_provider.dart';

import 'package:insta_canvas/homeModule/provider/home_provider.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'package:provider/provider.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../authModule/provider/auth_provider.dart';
import '../../colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? banner;
  InterstitialAd? searchInterstitialAd;
  InterstitialAd? columnInterstitialAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            size: AdSize.fluid,
            adUnitId: adState.homeBannerAdUnitId,
            request: const AdRequest(),
            listener: adState.adListener)
          ..load();
      });
    });
    createSearchInterstitialAd();
    createColumnInterstitialAd();
  }

  void createSearchInterstitialAd() {
    final adState = Provider.of<AdState>(context);
    InterstitialAd.load(
        adUnitId: adState.searchInterstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) => searchInterstitialAd = ad,
            onAdFailedToLoad: (ad) => searchInterstitialAd = null));
  }

  void createColumnInterstitialAd() {
    final adState = Provider.of<AdState>(context);
    InterstitialAd.load(
        adUnitId: adState.homeColumnInterstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) => columnInterstitialAd = ad,
            onAdFailedToLoad: (ad) => columnInterstitialAd = null));
  }

  double dH = 0.0;
  double dW = 0.0;
  double tS = 0.0;
  TextTheme customTextTheme = const TextTheme();
  Map language = {};
  bool isLoading = false;
  bool isImageFectched = false;
  bool imageFounded = false;

  String? _profilePicUrl;

  late HomeProvider homeProvider;

  TextEditingController textEditingController = TextEditingController();

  fetchData() async {
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  void showSearchInterstitialAd() {
    if (searchInterstitialAd != null) {
      searchInterstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createSearchInterstitialAd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        createSearchInterstitialAd();
      });
      searchInterstitialAd!.show();
      searchInterstitialAd = null;
    }
  }

  void showColumnInterstitialAd() {
    if (columnInterstitialAd != null) {
      columnInterstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createSearchInterstitialAd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        createSearchInterstitialAd();
      });
      columnInterstitialAd!.show();
      columnInterstitialAd = null;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    dH = MediaQuery.of(context).size.height;
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaler.scale(1.0);
    language = Provider.of<AuthProvider>(context).selectedLanguage;
    customTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: getAppBackground(context),
      body: SafeArea(child: screenBody()),
    );
  }

  screenBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: dW * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: dW * 0.04),
                Text(
                  language['subTitle'],
                  style: customTextTheme.displaySmall!
                      .copyWith(color: getSubTitle(context)),
                ),
                Text(language['title'],
                    style:
                        customTextTheme.displayLarge!.copyWith(fontSize: 32)),
                SizedBox(height: dW * 0.05),
                TextFormField(
                    onFieldSubmitted: (a) async {},
                    cursorColor: getSuffixIcon(context),
                    controller: textEditingController,
                    decoration: InputDecoration(
                        suffixIcon: RotationTransition(
                            turns: const AlwaysStoppedAnimation(120 / 360),
                            child: Icon(
                              Icons.alternate_email_rounded,
                              color: getSuffixIcon(context),
                            )),
                        contentPadding: EdgeInsets.all(dW * .05),
                        hintText: language['usernameHintText'],
                        hintStyle: customTextTheme.titleLarge!
                            .copyWith(color: getHintText(context)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                        filled: true,
                        fillColor: getTextFieldBackground(context))),
                SizedBox(height: dW * 0.05),
                Visibility(
                  visible: homeProvider.imageBytes != null,
                  child: homeProvider.imageBytes == null
                      ? Container()
                      : InkWell(
                          splashColor: Colors.transparent,
                          onTap: () => showColumnInterstitialAd(),
                          child: Column(
                            children: [
                              ZoomOverlay(
                                modalBarrierColor: Colors.black12,
                                animationCurve: Curves.fastOutSlowIn,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                twoTouchOnly: true,
                                child: InstaImageViewer(
                                  disableSwipeToDismiss: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child:
                                        Image.memory(homeProvider.imageBytes!),
                                  ),
                                ),
                              ),
                              SizedBox(height: dW * 0.05),
                            ],
                          ),
                        ),
                ),
                Center(
                  child: isImageFectched
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            // showSearchInterstitialAd();
                            fetchImage();
                            // homeProvider
                            //     .getProfilePicUrlHd(textEditingController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: getTextFieldBackground(context),
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(color: Colors.white)),
                          child: Text(language['search'])),
                ),
              ],
            ),
          ),
        ),
        if (banner == null)
          const SizedBox(height: 50)
        else
          Container(
            color: getAppBackground(context),
            height: 50,
            child: AdWidget(ad: banner!),
          )
      ],
    );
  }

  void fetchImage() async {
    try {
      setState(() {
        isImageFectched = true;
        homeProvider.username = textEditingController.text;
      });

      imageFounded = await homeProvider.fetchImage();

      // if (imageFounded == true) showSearchInterstitialAd();
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      setState(() {
        isImageFectched = false;
      });
    }
  }
}
