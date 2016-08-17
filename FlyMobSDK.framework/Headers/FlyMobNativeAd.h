//
//  FlyMobNativeAd.h
//  FlyMobSDK
//
//  Created by Ivan Kozlov on 21/06/16.
//  Copyright © 2016 FlyMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage, UIView;

@protocol FlyMobNativeAdDelegate;

@interface FlyMobNativeAd : NSObject

@property(nonatomic) NSUInteger zoneID;
@property(nonatomic) BOOL isReady;

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImage *icon;

@property(nonatomic) BOOL shouldPreloadImage;
@property(nonatomic) BOOL shouldPreloadIcon;

@property(nonatomic, weak) id<FlyMobNativeAdDelegate> delegate;

+(instancetype)nativeAdWithZoneID:(NSUInteger)zoneID;

-(void)loadAd;
-(void)registerView:(UIView *)view;

@end

@protocol FlyMobNativeAdDelegate <NSObject>

@optional;

-(void)nativeAdDidLoadAd:(FlyMobNativeAd *)nativeAd;

-(void)nativeAdDidFailToLoadAd:(FlyMobNativeAd *)nativeAd;

-(void)nativeAdDidShow:(FlyMobNativeAd *)nativeAd;

-(void)nativeAdDidClick:(FlyMobNativeAd *)nativeAd;

-(void)nativeAdDidExpire:(FlyMobNativeAd *)nativeAd;

@end