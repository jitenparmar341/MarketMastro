//
//  CityListVC.m
//  MarketMastro
//
//  Created by jiten on 24/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "CityListVC.h"
#import "CustomCityCell.h"

@interface CityListVC ()

@end

@implementation CityListVC

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    self.title = @"Select City";
    
    [self setDefaultData];
    
    [self.tblList reloadData];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - TableView Delegte

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self.arrCityList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"citycell";
    
    CustomCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.lblName.text = [self.arrCityList objectAtIndex:indexPath.section];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults]setValue:[self.arrCityList objectAtIndex:indexPath.section] forKey:@"CitySelected"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self btnBackClicked:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *vw = [[UIView alloc]init];
    vw.backgroundColor = [UIColor clearColor];
    
    return vw;
}

#pragma mark - Button Click Method

- (IBAction)btnBackClicked:(id)sender
{
    [self.srcBar resignFirstResponder];
    
    [[self navigationController]popViewControllerAnimated:true];
}

#pragma mark - SearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0)
    {
        [self setDefaultData];
    }
    else
    {
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
        self.arrCityList = [[self.arrCityList filteredArrayUsingPredicate:resultPredicate]mutableCopy];
    }
    
    [self.tblList reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.srcBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.srcBar.text = nil;
    
    [self.srcBar resignFirstResponder];
    
    [self setDefaultData];
    
    [self.tblList reloadData];
}

#pragma mark - Custom Method

- (void)setDefaultData
{
    self.arrCityList = [NSMutableArray arrayWithObjects:@"Mumbai",@"Pune",@"Ahmedabad",@"Rajkot",@"Hyderabad",@"Vijaywada",@"Nellore",@"Vizag",@"Warangal",@"Surat",@"Vadodara",@"Other", nil];
}

#pragma mark - Received Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
