//
//  FLYViewController.m
//  FlyMob AdShowCase
//
//  Created by Ivan Kozlov on 08/06/16.
//  Copyright © 2016 FlyMob. All rights reserved.
//

#import "FLYViewController.h"
#import "FLYInterstitialTestViewController.h"

static NSString *const kAdTypeCellIdentifer = @"AdTypeCell";

@interface FLYViewController ()
<

    UITableViewDelegate,
    UITableViewDataSource
>

@property(nonatomic, copy) NSArray *rowTitles;

@end

@implementation FLYViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _rowTitles = @[@"Interstitial"];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdTypeCellIdentifer
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = _rowTitles[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        [self performSegueWithIdentifier:NSStringFromClass([FLYInterstitialTestViewController class]) sender:self];
    }
}

@end