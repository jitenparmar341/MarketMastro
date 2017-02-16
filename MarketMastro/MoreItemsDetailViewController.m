//
//  MoreItemsDetailViewController.m
//  MarketMastro
//
//  Created by DHARMESH on 01/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "MoreItemsDetailViewController.h"

@interface MoreItemsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *ArrayMain;
    NSMutableArray *ArrayGroupIDs;
}
@end

@implementation MoreItemsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _sender;
    
    ArrayMain = [[NSMutableArray alloc]init];
    ArrayGroupIDs = [[NSMutableArray alloc] init];
    
    ArrayMain = _ArraysubAGroups;
    [_tableMoreItemsDetail reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ArrayMain.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    DropDownCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
    {
        cell = [[DropDownCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] ;
    }
    cell.label.text = [ArrayMain objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strGrpName = [ArrayMain objectAtIndex:indexPath.row];
    
    MoreDetailPlusViewController *plusview = [self.storyboard instantiateViewControllerWithIdentifier:@"MoreDetailPlusViewController"];
    plusview.selectedGroupID = [_ArraySubGroupIDs objectAtIndex:indexPath.row];
    plusview.sender = strGrpName;
    [self.navigationController pushViewController:plusview animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
