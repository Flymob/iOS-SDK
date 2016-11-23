//
//  FlyMobInterstitialAdMobEvent.m
//  FlyMobSDK
//
//  Created by Ivan Kozlov on 23/11/2016.
//  Copyright © 2016 FlyMob. All rights reserved.
//

#import "FlyMobInterstitialAdMobEvent.h"
#import "FlyMobInterstitial.h"

static NSString *const kCustomEventErrorDomain = @"com.google.FlyMobCustomEvent";

@interface FlyMobInterstitialAdMobEvent ()
<
    FlyMobInterstitialDelegate
>

@property(nonatomic, strong) FlyMobInterstitial *interstitial;

@end

@implementation FlyMobInterstitialAdMobEvent

@synthesize delegate;

#pragma mark - GADCustomEventInterstitial

-(void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                    label:(NSString *)serverLabel
                                  request:(GADCustomEventRequest *)request
{
    _interstitial = [FlyMobInterstitial interstitialWithZoneID:serverParameter.integerValue];
    _interstitial.delegate = self;
    
    [_interstitial loadAd];
}

-(void)presentFromRootViewController:(UIViewController *)rootViewController
{
    [_interstitial showFromViewController:rootViewController];
}

#pragma mark - FlyMobInterstitialDelegate

-(void)interstitialDidLoadAd:(FlyMobInterstitial *)interstitial
{
    [self.delegate customEventInterstitialDidReceiveAd:self];
}

-(void)interstitialDidFailToLoadAd:(FlyMobInterstitial *)interstitial
                             error:(NSError *)error
{
    NSError *flyMobCustomEventError = [NSError errorWithDomain:kCustomEventErrorDomain
                                                          code:error.code
                                                      userInfo:error.userInfo];
    
    [self.delegate customEventInterstitial:self
                                 didFailAd:flyMobCustomEventError];
}

-(void)interstitialDidShow:(FlyMobInterstitial *)interstitial
{
    [self.delegate customEventInterstitialWillPresent:self];
}

-(void)interstitialDidClick:(FlyMobInterstitial *)interstitial
{
    [self.delegate customEventInterstitialWasClicked:self];
    [self.delegate customEventInterstitialWillLeaveApplication:self];
}

-(void)interstitialDidClose:(FlyMobInterstitial *)interstitial
{
    [self.delegate customEventInterstitialWillDismiss:self];
    [self.delegate customEventInterstitialDidDismiss:self];
}

-(void)interstitialDidExpire:(FlyMobInterstitial *)interstitial
{
    // Nothing to do here
}

@end
