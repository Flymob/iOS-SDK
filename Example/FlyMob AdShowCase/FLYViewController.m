//
//  FLYViewController.m
//  FlyMob AdShowCase
//
//  Created by Ivan Kozlov on 08/06/16.
//  Copyright © 2016 FlyMob. All rights reserved.
//

#import "FLYViewController.h"
#import "FLYTestViewController.h"

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
    
    _rowTitles = @[@"Interstitial", @"Native Ad", @"Rewarded Video"];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rowTitles.count;
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
    
    switch (indexPath.row)
    {
        case 0:
        {
            [self performSegueWithIdentifier:NSStringFromClass([FLYTestViewController class]) sender:self];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
    }
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end