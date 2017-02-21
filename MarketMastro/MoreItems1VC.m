//
//  MoreItems1VC.m
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "MoreItems1VC.h"
#import "MoreItemsCell.h"

@interface MoreItems1VC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *ArrayMoreItems;
    NSMutableArray *ArrayBullion;
    
    NSMutableArray *ArrayMoreItemsSubgroups;
    NSMutableArray *ArrayMoreItemsSubgroupIDs;
}
@end

@implementation MoreItems1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.title = @"More Items";
    self.title = _strSelectedItem;
    
    self.view.backgroundColor = ViewBackgroundColor;
    _tableviewMoreItems.backgroundColor = ViewBackgroundColor;
    
    ArrayMoreItemsSubgroups = [[NSMutableArray alloc]init];
    ArrayMoreItemsSubgroupIDs = [[NSMutableArray alloc] init];
    
    ArrayMoreItems = _ArraySubGroups;
    [_tableviewMoreItems reloadData];
    
    NSLog(@"ArraySubGroupsID = %@",_ArraySubGroupID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ArrayMoreItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //MoreItemsCell.h
    static NSString *MyIdentifier = @"cell";
    MoreItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[MoreItemsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:MyIdentifier];
    }
    cell.lblMoreItem.text = [ArrayMoreItems objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *strGroupId = [_ArraySubGroupID objectAtIndex:indexPath.row];
    NSString *strGroupName = [ArrayMoreItems objectAtIndex:indexPath.row];
    [self GetSubGroups:strGroupId grpName:strGroupName];
    
}

-(void)GetSubGroups :(NSString *)strGroupId grpName:(NSString *)strGroupName
{
    
    //IF GROUP ID IS PRESENT THEN
    if (strGroupId !=nil)
    {
        NSString *query = [NSString stringWithFormat:@ "select * from CommodityGroup where ParentGroupID=%@",strGroupId];
        
        [[MethodsManager sharedManager]loadingView:self.view];
        [[SQLiteDatabase sharedInstance] executeQuery:query withParams:nil success:^(SQLiteResult *result)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"select all from commodity group with group id result = %@",result);
             NSMutableArray *array = result.rows;
             
             [ArrayMoreItemsSubgroups removeAllObjects];
             [ArrayMoreItemsSubgroupIDs removeAllObjects];
             
             for (int i =0; i < array.count; i ++)
             {
                 SQLiteRow *object = [array objectAtIndex:i];
                 NSString *strGrpName = [object stringForColumnName:@"GroupName"];
                 NSString *GroupID = [object stringForColumnName:@"GroupID"];
                 [ArrayMoreItemsSubgroups addObject:strGrpName];
                 [ArrayMoreItemsSubgroupIDs addObject:GroupID];
             }
             
             MoreItemsDetailViewController *items = [self.storyboard instantiateViewControllerWithIdentifier:@"MoreItemsDetailViewController"];
             items.ArraysubAGroups = ArrayMoreItemsSubgroups;
             items.ArraySubGroupIDs = ArrayMoreItemsSubgroupIDs;
             items.sender = strGroupName;
             [self.navigationController pushViewController:items animated:YES];
         }
                                              failure:^(NSString *errorMessage)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"Could not fetch rows from commodity group with group id =,error = %@",errorMessage);
         }];
    }
    else
    {
        //IF GROUP ID NOT PRESENT THEN
        NSString *query = [NSString stringWithFormat:@"select * fromCommodityGroup where GroupType='%@' AND ParentGroupID=0",strGroupName];
        
        [[MethodsManager sharedManager]loadingView:self.view];
        [[SQLiteDatabase sharedInstance] executeQuery:query withParams:nil success:^(SQLiteResult *result)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"select all from commodity group where group id is nil result = %@",result);
         }
                                              failure:^(NSString *errorMessage)
         {
             [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"Could not fetch rows from commodity group where group id is nil,error = %@",errorMessage);
         }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
@end
