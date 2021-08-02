import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobHelper {
  static String get bannerUnitID => 'ca-app-pub-3940256099942544/6300978111';
  //production if => ca-app-pub-9575384856484892/4173456520
  static String get interstitialUnitID =>
      'ca-app-pub-3940256099942544/1033173712';
  //profuction id => ca-app-pub-9575384856484892/7284843207
  InterstitialAd? _interstitialAd;

  int num_of_attempt_load = 0;

  static initialization() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd getBannerAd() {
    BannerAd bAd = new BannerAd(
        size: AdSize.fullBanner,
        adUnitId: bannerUnitID,
        listener: BannerAdListener(onAdClosed: (Ad ad) {
          print("Ad Closed");
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }, onAdLoaded: (Ad ad) {
          print('Ad Loaded');
        }, onAdOpened: (Ad ad) {
          print('Ad opened');
        }),
        request: AdRequest());
    return bAd;
  }

  void createInterAd() {
    InterstitialAd.load(
      adUnitId: interstitialUnitID,
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        _interstitialAd = ad;
        num_of_attempt_load = 0;
      }, onAdFailedToLoad: (LoadAdError error) {
        num_of_attempt_load += 1;
        _interstitialAd = null;
        if (num_of_attempt_load <= 2) {
          createInterAd();
        }
      }),
    );
  }

  void showInterAd() {
    if (_interstitialAd == null) {
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      print("More Money added");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("No money...");
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print("Ad mob not giving money because " + error.toString());
      ad.dispose();
      createInterAd();
    });

    _interstitialAd!.show();

    _interstitialAd = null;
  }
}
