# FlyMob iOS SDK

## Getting started
### Requirements and Dependencies
* iOS 8+
* Allow arbitrary loads for iOS 9+ in project **info.plist** file:

### Installation
1. Download and unzip the FlyMob iOS SDK.
2. Drag and drop **FlyMob.framework** into your project (check the *"Copy items into destination group's folder"* option)
3. Add FlyMob.framework to **Embedded Binaries** section


## Usage
### Interstitial
#### Integration & invocation
1. Import FlyMob SDK in your View Controller. To listen optional evens you can also implement **FlyMobInterstitialDelegate** protocol.
```
#import <FlyMobSDK/FlyMobSDK.h>

@interface TestViewController ()
<
    FlyMobInterstitialDelegate
>
```
2. The FlyMob SDK provides a custom class, **FlyMobInterstitial**, that handles fetching and displaying fullscreen interstitial ads. To ensure a smooth experience, you should pre-fetch the content as soon as your View Controller is ready, then display it if the fetch was successful. In the View Controller in which you want to show the interstitial ad, declare a **FlyMobInterstitial** instance variable
`@property(nonatomic, strong) FlyMobInterstitial *interstitial;`
3. Inside **viewWillAppear:** method instantiate **FlyMobInterstitial** and prefetch interstitial ad:
```
_interstitial = [FlyMobInterstitial interstitialWithZoneID:659830];
_interstitial.delegate = self;
[_interstitial loadAd];
```
4. There are several **optional** delegate methods:
```
-(void)interstitialDidLoadAd:(FlyMobInterstitial *)interstitial;
 
-(void)interstitialDidFailToLoadAd:(FlyMobInterstitial *)interstitial;
 
-(void)interstitialDidShow:(FlyMobInterstitial *)interstitial;
 
-(void)interstitialDidClick:(FlyMobInterstitial *)interstitial;
 
-(void)interstitialDidExpire:(FlyMobInterstitial *)interstitial;
 
-(void)interstitialDidClose:(FlyMobInterstitial *)interstitial;
```
5. If fetch was successful you can present interstitial ad with **showFromViewController:animated:completion:** method: 
```
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
