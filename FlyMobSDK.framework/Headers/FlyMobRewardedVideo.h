//
//  FlyMobRewardedVideo.h
//  FlyMobSDK
//
//  Created by Ivan Kozlov on 29/08/16.
//  Copyright © 2016 FlyMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@protocol FlyMobRewardedVideoDelegate;

@interface FlyMobRewardedVideo : NSObject

+(instancetype)initialize:(NSUInteger)zoneID;

+(void)showFromViewController:(UIViewController *)viewController;

+(BOOL)isReady;

+(void)setDelegate:(id<FlyMobRewardedVideoDelegate>) delegate;

@end

@protocol FlyMobRewardedVideoDelegate <NSObject>

@optional

// Called when the ad is ready to show
-(void)rewardedVideoDidLoadAd:(FlyMobRewardedVideo *)rewardedVideo;

// Called when ad controller become visible
-(void)rewardedVideoDidShow:(FlyMobRewardedVideo *)rewardedVideo;

// Called when video finished
-(void)rewardedVideoDidComplete:(FlyMobRewardedVideo *)rewardedVideo;

// Called when video play started
-(void)rewardedVideoDidStart:(FlyMobRewardedVideo *)rewardedVideo;

// Called when ad controller removed from the screen
-(void)rewardedVideoDidClose:(FlyMobRewardedVideo *)rewardedVideo;

@end
