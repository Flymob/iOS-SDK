# FlyMob iOS SDK

## Getting started
### Requirements and Dependencies
* iOS 8+
* Allow arbitrary loads for iOS 9+ in project **info.plist** file:
![](https://cloud.githubusercontent.com/assets/1261116/16084221/051bb8a6-3329-11e6-998b-c62ff5239e57.png)

### Installation
1. Download and unzip the FlyMob iOS SDK
2. Drag and drop **FlyMob.framework** into your project (check the *"Copy items into destination group's folder"* option)
3. Add FlyMob.framework to **Embedded Binaries** section
![](https://cloud.githubusercontent.com/assets/1261116/16084222/06ee55a8-3329-11e6-9815-68039e73d52f.png)


## Usage
### Interstitial
#### Integration & invocation
1. Import FlyMob SDK in your View Controller. To listen optional evens you can also implement **FlyMobInterstitialDelegate** protocol:

    ```objc
    #import <FlyMobSDK/FlyMobSDK.h>
    
    @interface TestViewController ()
    <
        FlyMobInterstitialDelegate
    >
    ```
2. The FlyMob SDK provides a custom class, **FlyMobInterstitial**, that handles fetching and displaying fullscreen interstitial ads. To ensure a smooth experience, you should pre-fetch the content as soon as your View Controller is ready, then display it if the fetch was successful. In the View Controller in which you want to show the interstitial ad, declare a **FlyMobInterstitial** instance variable:

    ```objc
    @property(nonatomic, strong) FlyMobInterstitial *interstitial;
    ```
3. Inside **viewWillAppear:** method instantiate **FlyMobInterstitial** and prefetch interstitial ad:

    ```objc
    _interstitial = [FlyMobInterstitial interstitialWithZoneID:659830];
    _interstitial.delegate = self;
    [_interstitial loadAd];
    ```
4. There are several **optional** delegate methods:

    ```objc
    -(void)interstitialDidLoadAd:(FlyMobInterstitial *)interstitial;
        
    -(void)interstitialDidFailToLoadAd:(FlyMobInterstitial *)interstitial;
     
    -(void)interstitialDidShow:(FlyMobInterstitial *)interstitial;
     
    -(void)interstitialDidClick:(FlyMobInterstitial *)interstitial;
     
    -(void)interstitialDidExpire:(FlyMobInterstitial *)interstitial;
     
    -(void)interstitialDidClose:(FlyMobInterstitial *)interstitial;
    ```
5. If fetch was successful you can present interstitial ad with **showFromViewController:animated:completion:** method:

    ```objc
    if (_interstitial.isReady)
    {
        [_interstitial showFromViewController:self animated:YES completion:nil];
    }
    ```

#### Conclusion
Keep in mind following steps:
* In your **viewWillAppear:** method, call **loadAd** to begin prefetching the ad. It’s important to fetch interstitial ad content before you plan to show it, since it often incorporates rich media and may take some time to load. We suggest prefetching when your View Controller is ready, but you may also choose to do it based on events in your app, like beginning a game level.
* When you receive load in your delegate method, you can display your ad. Also you can check if your ad is loaded by **isReady** method. If the ad was loaded, but expired by time, you'll receive **interstitialDidExpire:** event in your delegate.
* You can add logic to the other interstitial lifecycle methods to handle what should happen when your user interacts with the ad.

### Native
#### Integration
1. Import FlyMob SDK in your View Controller. To listen optional evens you can also implement **FlyMobNativeAdDelegate** protocol.
    ```objc
        #import <FlyMobSDK/FlyMobSDK.h>
        
        @interface TestViewController ()
        <
            FlyMobNativeAdDelegate
        >
    ```
2. Use **FlyMobNativeAd** class to fetch native ad
    ```objc
        @property(nonatomic, strong) FlyMobNativeAd *nativeAd;
        ...
        _nativeAd = [FlyMobNativeAd nativeAdWithZoneID:624470];
        _nativeAd.shouldPreloadImage = YES;
        _nativeAd.shouldPreloadIcon = YES;
        _nativeAd.delegate = self;
        
        [_nativeAd loadAd];
    ```
3. Optional delegate methods:
    ```objc
        -(void)nativeAdDidLoadAd:(FlyMobNativeAd *)nativeAd;
        
        -(void)nativeAdDidFailToLoadAd:(FlyMobNativeAd *)nativeAd;
        
        -(void)nativeAdDidShow:(FlyMobNativeAd *)nativeAd;
        
        -(void)nativeAdDidClick:(FlyMobNativeAd *)nativeAd;
        
        -(void)nativeAdDidExpire:(FlyMobNativeAd *)nativeAd;
    ```
4. When your ad successfully you can get all necessary data:
    * **iconURL**
    * **imageURL**
    * **image** - will be nil if **shouldPreloadImage = NO** 
    * **icon** - will be nil if **shouldPreloadIcon = NO** 
    * **cta**
    * **rating**
    * **text**
    * **title**
5. In order to enable handle the impression and the click automatically you must register the ad's view with the FlyMobNativeAd instance. You should call **registerView:**. Please note that if your NativeAd container will not be registered by **registerView:**, ad impression will not be counted. (It is thought that ad was shown, if it was on the screen at least 1 second).
