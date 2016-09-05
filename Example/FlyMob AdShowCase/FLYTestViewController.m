//
//  FLYTestViewController.m
//  FlyMob AdShowCase
//
//  Created by Ivan Kozlov on 14/06/16.
//  Copyright © 2016 FlyMob. All rights reserved.
//

#import "FLYTestViewController.h"

#import <FlyMobSDK/FlyMobSDK.h>

@interface FLYTestViewController ()
<
    FlyMobInterstitialDelegate,
    UITextFieldDelegate
>

// UI Outlets
@property (weak, nonatomic) IBOutlet UITextField *zoneIDTextField;
@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(nonatomic, strong) FlyMobInterstitial *interstitial;

@end

@implementation FLYTestViewController

#pragma mark - Lyfecycle

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        [self loadAd];
    });
}

#pragma mark - Actions

-(IBAction)loadButtonClicked:(UIButton *)button
{
    [self loadAd];
}

-(IBAction)showButtonClicked:(UIButton *)button
{
    _showButton.enabled = NO;
    
    if (_interstitial.isReady)
    {
        [_interstitial showFromViewController:self];
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
                             error:(NSError *)error
{
    [_activityIndicator stopAnimating];
    
    [self showAllert:[NSString stringWithFormat:@"Failed to load ad: %@", error.domain]];
    
    NSLog(@"Did fail: %@", error.domain);
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

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _showButton.enabled = NO;
    
    return YES;
}

#pragma mark - Helpers

-(void)loadAd
{
    _showButton.enabled = NO;
    [_activityIndicator startAnimating];
    
    _interstitial = [FlyMobInterstitial interstitialWithZoneID:_zoneIDTextField.text.integerValue/*659830,657274*/];
    _interstitial.delegate = self;
    
    [_interstitial loadAd];
}

-(void)showAllert:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Something happened!"
                                                                             message:title
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end