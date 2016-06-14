//
//  FLYConfiguration.h
//  InAppTest
//
//  Created by Ivan Kozlov on 30/05/16.
//  Copyright © 2016 Ivan Kozlov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLYInterstitialModel;

typedef void (^FLYConfigurationSuccessBlock)(FLYInterstitialModel *interstitialModel);
typedef void (^FLYConfigurationFailureBlock)(NSError *error);

@interface FLYConfiguration : NSObject

@property(nonatomic) BOOL coppa;
@property(nonatomic) BOOL shouldTrack;
@property(nonatomic) BOOL testing;
@property(nonatomic) NSUInteger zoneID;

+(instancetype)sharedInstance;

-(NSDictionary *)dictionaryRepresentation;

@end