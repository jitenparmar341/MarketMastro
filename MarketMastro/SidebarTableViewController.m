//
//  SidebarTableViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
//#import "PhotoViewController.h"
#import "MarketCell.h"



@interface SidebarTableViewController () {
    NSIndexPath *lastSelectedIndex;
}

@end

@implementation SidebarTableViewController {
    NSArray *menuItems;
    NSMutableDictionary *dictSection;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    _tableSideMenu.allowsMultipleSelection = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:22/255.0 green:25/255.0 blue:27/255.0 alpha:1.0];
    
    
    
    [self setUpForDrawerList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSDictionary *dicOfLoggedInuser = [[NSUserDefaults standardUserDefaults] valueForKey:@"DictOfLogedInuser"];
    
    _lblname.text = [dicOfLoggedInuser valueForKey:@"Name"];
    
    NSString *strCredit = [dicOfLoggedInuser valueForKey:@"CreditPoints"];
    _lblcredit.text = [NSString stringWithFormat:@"Credit : %@",strCredit];
    _imgProfile.image = [UIImage imageNamed:@"accountImage.png"];

    if (lastSelectedIndex && lastSelectedIndex.section == 0) {
        NSIndexPath *tIndexPath = lastSelectedIndex;
        lastSelectedIndex = [NSIndexPath indexPathForRow:indexOfDrawer inSection:0];
        [_tableSideMenu reloadRowsAtIndexPaths:@[lastSelectedIndex, tIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (!lastSelectedIndex) {
        lastSelectedIndex = [NSIndexPath indexPathForRow:indexOfDrawer inSection:0];
        [_tableSideMenu reloadData];
    }
}

- (void)setUpForDrawerList {
    menuItems = @[@"market", @"portfolio", @"news", @"calendar", @"accounts", @"subscription", @"alertcenter", @"referfriend", @"help", @"aboutus", @"contactus", @"request"];
    dictSection = [[NSMutableDictionary alloc] init];
    NSMutableArray *tArr1 = [[NSMutableArray alloc] init];
    [tArr1 addObject:@{@"CellID":@"market", @"SelectedImg":@"dro_market_active_ico.png", @"DeselectedImg":@"dro_market_ico.png"}];
    [tArr1 addObject:@{@"CellID":@"EMC", @"SelectedImg":@"dro_emc_active_ico.png", @"DeselectedImg":@"dro_emc_ico.png"}];
    [tArr1 addObject:@{@"CellID":@"portfolio", @"SelectedImg":@"dro_portfolio_active_ico.png", @"DeselectedImg":@"dro_portfolio_ico.png"}];
    [tArr1 addObject:@{@"CellID":@"calendar", @"SelectedImg":@"dro_calendar_active_ico.png", @"DeselectedImg":@"dro_calendar_ico.png"}];
    
    NSMutableArray *tArr2 = [[NSMutableArray alloc] init];
    [tArr2 addObject:@{@"CellID":@"news", @"SelectedImg":@"dro_news_active_ico.png", @"DeselectedImg":@"dro_news_ico.png"}];
    [tArr2 addObject:@{@"CellID":@"accounts", @"SelectedImg":@"dro_account_active_ico.png", @"DeselectedImg":@"dro_account_ico.png"}];
    [tArr2 addObject:@{@"CellID":@"subscription", @"SelectedImg":@"dro_subscription_active_ico.png", @"DeselectedImg":@"dro_subscription_ico.png"}];
    [tArr2 addObject:@{@"CellID":@"alertcenter", @"SelectedImg":@"dro_alert_active_ico.png", @"DeselectedImg":@"dro_alert_ico.png"}];
    [tArr2 addObject:@{@"CellID":@"referfriend", @"SelectedImg":@"dro_refer_active_ico.png", @"DeselectedImg":@"dro_refer_ico.png"}];
    
    NSMutableArray *tArr3 = [[NSMutableArray alloc] init];
    [tArr3 addObject:@{@"CellID":@"help", @"SelectedImg":@"dro_help_active_ico.png", @"DeselectedImg":@"dro_help_ico.png"}];
    [tArr3 addObject:@{@"CellID":@"aboutus", @"SelectedImg":@"dro_about_active_ico.png", @"DeselectedImg":@"dro_about_ico.png"}];
    [tArr3 addObject:@{@"CellID":@"contactus", @"SelectedImg":@"dro_contact_active_ico.png", @"DeselectedImg":@"dro_contact_ico.png"}];
    [tArr3 addObject:@{@"CellID":@"request", @"SelectedImg":@"dro_request_active_ico.png", @"DeselectedImg":@"dro_request_ico.png"}];
    
    [dictSection setObject:tArr1 forKey:@"First"];
    [dictSection setObject:tArr2 forKey:@"Second"];
    [dictSection setObject:tArr3 forKey:@"Third"];
    
    //    [dictSection setObject:@[@"market",@"portfolio",@"EMC",@"calendar"] forKey:@"First"];
    //    [dictSection setObject:@[@"news",@"accounts",@"subscription",@"alertcenter",@"referfriend"] forKey:@"Second"];
    //    [dictSection setObject:@[@"help",@"aboutus",@"contactus",@"request"] forKey:@"Third"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return dictSection.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger noOfRows;
    switch (section) {
        case 0:
            noOfRows = [[dictSection objectForKey:@"First"] count];
            break;
            
        case 1:
            noOfRows = [[dictSection objectForKey:@"Second"] count];
            break;
            
        case 2:
            noOfRows = [[dictSection objectForKey:@"Third"] count];
            break;
            
        default:
            noOfRows = menuItems.count;
            break;
    }
    return noOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *cellIdentifier;
    NSDictionary *selectDict;
    switch (indexPath.section) {
        case 0:
        {
            selectDict = [[dictSection objectForKey:@"First"] objectAtIndex:indexPath.row];
            cellIdentifier = [selectDict objectForKey:@"CellID"];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        }
            break;
            
        case 1:
        {
            selectDict = [[dictSection objectForKey:@"Second"] objectAtIndex:indexPath.row];
            cellIdentifier = [selectDict objectForKey:@"CellID"];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        }
            break;
            
        case 2:
        {
            selectDict = [[dictSection objectForKey:@"Third"] objectAtIndex:indexPath.row];
            cellIdentifier = [selectDict objectForKey:@"CellID"];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        }
            break;
            
        default:
        {
            cellIdentifier = [menuItems objectAtIndex:indexPath.row];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        }
            break;
    }
    
    //    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    //    cell.backgroundColor = [UIColor clearColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    // cell.contentView.backgroundColor = [UIColor colorWithRed:21/255.0 green:85/255.0 blue:140/255.0 alpha:1.0];
    
    if (lastSelectedIndex.row == indexPath.row && lastSelectedIndex.section == indexPath.section) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:85.0/255.0 blue:140.0/255.0 alpha:1.0];
        [(UILabel*)[cell.contentView viewWithTag:102] setTextColor:[UIColor colorwithHexString:@"#ffffff"]];
        [(UILabel*)[cell.contentView viewWithTag:102] setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
        //        cell.textLabel.font = [UIFont fontWithName:@"Lato-Regular" size:13.0];
        [(UIImageView*)[cell.contentView viewWithTag:101] setImage:[UIImage imageNamed:[selectDict objectForKey:@"SelectedImg"]]];
        //        cell.imageView.image = [UIImage imageNamed:[selectDict objectForKey:@"SelectedImg"]];
    }
    else {
        cell.contentView.backgroundColor = [UIColor colorWithRed:22.0/255.0 green:25.0/255.0 blue:27.0/255.0 alpha:1.0];
        [(UILabel*)[cell.contentView viewWithTag:102] setTextColor:[UIColor colorWithRed:149.0/255.0 green:149.0/255.0 blue:149.0/255.0 alpha:1.0]];
        [(UILabel*)[cell.contentView viewWithTag:102] setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
        //        cell.textLabel.textColor = [UIColor colorWithRed:149/255 green:149/255 blue:149/255 alpha:1.0];
        //        cell.textLabel.font = [UIFont fontWithName:@"Lato-Regular" size:13.0];
        [(UIImageView*)[cell.contentView viewWithTag:101] setImage:[UIImage imageNamed:[selectDict objectForKey:@"DeselectedImg"]]];
        //        cell.imageView.image = [UIImage imageNamed:[selectDict objectForKey:@"DeselectedImg"]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *strTitle;
    switch (indexPath.section) {
        case 0:
            strTitle = [[[dictSection objectForKey:@"First"] objectAtIndex:indexPath.row] objectForKey:@"CellID"];
            break;
            
        case 1:
            strTitle = [[[dictSection objectForKey:@"Second"] objectAtIndex:indexPath.row] objectForKey:@"CellID"];
            break;
            
        case 2:
            strTitle = [[[dictSection objectForKey:@"Third"] objectAtIndex:indexPath.row] objectForKey:@"CellID"];
            break;
            
        default:
            strTitle = @"Title";
            break;
    }
    
    indexOfDrawer = (int)indexPath.row;
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [strTitle capitalizedString];
    
    //    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    
    
    //    // Set the photo if it navigates to the PhotoView
    //    if ([segue.identifier isEqualToString:@"showPhoto"]) {
    //        UINavigationController *navController = segue.destinationViewController;
    //        PhotoViewController *photoController = [navController childViewControllers].firstObject;
    //        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo", [menuItems objectAtIndex:indexPath.row]];
    //        photoController.photoFilename = photoFilename;
    //    }
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (lastSelectedIndex) {
        NSIndexPath *tIndexPath = lastSelectedIndex;
        lastSelectedIndex = indexPath;
        [tableView reloadRowsAtIndexPaths:@[lastSelectedIndex, tIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    else {
        lastSelectedIndex = indexPath;
        [tableView reloadData];
        //        [tableView reloadRowsAtIndexPaths:@[lastSelectedIndex] withRowAnimation:UITableViewRowAnimationNone];
    }
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[dictSection objectForKey:@"Second"] objectAtIndex:indexPath.row] forIndexPath:indexPath];
    
    //    cell.contentView.backgroundColor = [UIColor colorWithRed:21/255.0 green:85/255.0 blue:140/255.0 alpha:1.0];
    //    cell.textLabel.textColor = [UIColor whiteColor];
    //    lastSelectedIndex = indexPath;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 11.0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSeparator = [[UIView alloc] init];
    UILabel *lblSep = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-40, 1)];
    [lblSep setBackgroundColor:[UIColor colorWithRed:12.0/255.0 green:16.0/255.0 blue:20.0/255.0 alpha:1.0]];
    [viewSeparator addSubview:lblSep];
    return viewSeparator;
}

/*
 - (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 }
 
 - (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 
 - (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
 cell.contentView.backgroundColor = [UIColor whiteColor];
 cell.textLabel.textColor = [UIColor blackColor];
 
 if ([cell isHighlighted])
 {
 cell.contentView.backgroundColor = [UIColor colorWithRed:21/255.0 green:85/255.0 blue:140/255.0 alpha:1.0];
 cell.textLabel.textColor = [UIColor redColor];
 }
 }
 
 - (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
 {
 //    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
 //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 //    cell.contentView.backgroundColor = [UIColor clearColor];
 //    cell.textLabel.textColor = [UIColor whiteColor];
 }
 */


@end
