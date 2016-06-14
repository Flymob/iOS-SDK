//
//  FLYInterstitialTestViewController.m
//  FlyMob AdShowCase
//
//  Created by Ivan Kozlov on 14/06/16.
//  Copyright © 2016 FlyMob. All rights reserved.
//

#import "FLYInterstitialTestViewController.h"

#import <FlyMobSDK/FlyMobSDK.h>

@interface FLYInterstitialTestViewController ()
<
    FlyMobInterstitialDelegate
>

// UI Outlets
@property (weak, nonatomic) IBOutlet UITextField *zoneIDTextField;
@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(nonatomic, strong) FlyMobInterstitial *interstitial;

@end

@implementation FLYInterstitialTestViewController

#pragma mark - Lyfecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Actions

-(IBAction)loadButtonClicked:(UIButton *)button
{
    _showButton.enabled = NO;
    [_activityIndicator startAnimating];
    
    _interstitial = [FlyMobInterstitial interstitialWithZoneID:_zoneIDTextField.text.integerValue/*659830,657274*/];
    _interstitial.delegate = self;
    
    [_interstitial loadAd];
}

-(IBAction)showButtonClicked:(UIButton *)button
{
    _showButton.enabled = NO;
    
    if (_interstitial.isReady)
    {
        [_interstitial showFromViewController:self animated:YES completion:nil];
    }
}

#pragma mark - FLYInterstitialDelegate

-(void)interstitialDidLoadAd:(FlyMobInterstitial *)interstitialController
{
    [_activityIndicator stopAnimating];
    _showButton.enabled = YES;
    
    NSLog(@"Did load");
}

-(void)interstitialDidFailToLoadAd:(FlyMobInterstitial *)interstitialController
{
    [_activityIndicator stopAnimating];
    
    [self showAllert:@"Failed to load ad"];
    
    NSLog(@"Did fail");
}

-(void)interstitialDidShow:(FlyMobInterstitial *)interstitialController
{
    NSLog(@"Did show");
}

-(void)interstitialDidClick:(FlyMobInterstitial *)interstitialController
{
    NSLog(@"Did click");
}

-(void)interstitialDidExpire:(FlyMobInterstitial *)interstitialController
{
    NSLog(@"Did expire");
}

-(void)interstitialDidClose:(FlyMobInterstitial *)interstitialController
{
    NSLog(@"Did close");
}

#pragma mark - Helpers

-(void)showAllert:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Something happened!"
                                                                             message:title
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end