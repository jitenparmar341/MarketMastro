//
//  UpgradeViewController.m
//  MarketMastro
//
//  Created by Kanhaiya on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "UpgradeViewController.h"
#import "UpgradeDetailsVC.h"
#import "SWRevealViewController.h"
#import "CustomSelPack.h"

#import "ModeOfPaymentVC.h"


@interface UpgradeViewController ()
{
    NSMutableArray *menuItems;
}
@end

@implementation UpgradeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Select Package";
    menuItems = [NSMutableArray array];
    
    NSMutableDictionary *dicData = [NSMutableDictionary dictionary];
    
    [dicData setValue:@"Free - MCX only version" forKey:@"main"];
    [dicData setValue:@"30 Days Trial" forKey:@"sub"];
    [dicData setValue:@"₹25" forKey:@"price"];
    
    [menuItems addObject:dicData];
    
    dicData = [NSMutableDictionary dictionary];
    
    [dicData setValue:@"With Ad - MCX only version" forKey:@"main"];
    [dicData setValue:@"30 Days Trial" forKey:@"sub"];
    [dicData setValue:@"₹50" forKey:@"price"];
    
    [menuItems addObject:dicData];
    
    [self.tblView reloadData];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    if(!_is_NotFromDraw)
    {
        SWRevealViewController *revealViewController = self.revealViewController;
        if ( revealViewController )
        {
            [self.sidebarButton setTarget: self.revealViewController];
            [self.sidebarButton setAction: @selector( revealToggle: )];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
    }
    else{
        [self.sidebarButton setImage:[UIImage imageNamed:@"back-button"]];
        [self.sidebarButton setTarget: self];
        [self.sidebarButton setAction: @selector( goBack: )];
        
    }
    
    // Do any additional setup after loading the view.
}
-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return menuItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"market";
    
    CustomSelPack *cell = (CustomSelPack*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dicData = [menuItems objectAtIndex:indexPath.section];
    
    cell.lblMain.text = [dicData valueForKey:@"main"];
    cell.lblSub.text = [dicData valueForKey:@"sub"];
    cell.lblPrice.text = [dicData valueForKey:@"price"];
    
    cell.viewPrice.layer.cornerRadius = cell.viewPrice.frame.size.width/2;
    cell.viewPrice.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.viewPrice.layer.borderWidth = 0.5;
    cell.viewPrice.clipsToBounds = true;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModeOfPaymentVC *upgradeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeOfPaymentVC"];
    [self.navigationController pushViewController:upgradeVC animated:YES];
}

@end
