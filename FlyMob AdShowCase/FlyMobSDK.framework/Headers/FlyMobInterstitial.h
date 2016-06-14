//
//  FlyMobInterstitial.h
//  InAppTest
//
//  Created by Ivan Kozlov on 31/05/16.
//  Copyright © 2016 Ivan Kozlov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@protocol FlyMobInterstitialDelegate;

@interface FlyMobInterstitial : NSObject

@property(nonatomic) NSUInteger zoneID;
@property(nonatomic) BOOL isReady;
@property(nonatomic, weak) id<FlyMobInterstitialDelegate> delegate;

+(instancetype)interstitialWithZoneID:(NSUInteger)zoneID;

-(void)loadAd;

-(void)showFromViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(dispatch_block_t)completion;

@end

@protocol FlyMobInterstitialDelegate <NSObject>

@optional;

-(void)interstitialDidLoadAd:(FlyMobInterstitial *)interstitial;

-(void)interstitialDidFailToLoadAd:(FlyMobInterstitial *)interstitial;

-(void)interstitialDidShow:(FlyMobInterstitial *)interstitial;

-(void)interstitialDidClick:(FlyMobInterstitial *)interstitial;

-(void)interstitialDidExpire:(FlyMobInterstitial *)interstitial;

-(void)interstitialDidClose:(FlyMobInterstitial *)interstitial;

@end