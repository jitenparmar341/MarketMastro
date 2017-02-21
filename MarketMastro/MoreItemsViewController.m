//
//  MoreItemsViewController.m
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "MoreItemsViewController.h"

@interface MoreItemsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *ArrayMoreItems;
    NSMutableArray *ArrayGetCommodityGroup;
    NSMutableArray *ArraySubGroups;
    NSMutableArray *ArraySubGroupsID;
}
@end

@implementation MoreItemsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"More Items";
    self.view.backgroundColor = ViewBackgroundColor;
    NSLog(@"called more items page from = %@",_isFromVC);
    
    ArrayMoreItems = [[NSMutableArray alloc]init];
    ArraySubGroups = [[NSMutableArray alloc]init];
    ArraySubGroupsID = [[NSMutableArray alloc]init];
    [self MethodGetCommodityGrpDB];
}

-(void)MethodGetCommodityGrpDB
{
    //check if commodity grp table is empty or not
    NSString *query1 = @"SELECT * from CommodityGroup";
    NSLog(@"Query %@ ",query1);
    [[MethodsManager sharedManager]loadingView:self.view];
    [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"select all rows from commodity group database = %@",result);
         ArrayGetCommodityGroup = result.rows;
         NSLog(@"Array of history  = %@",ArrayGetCommodityGroup);
         
         if (ArrayGetCommodityGroup.count >0)//if database is not empty then call
         {
             //call get commodity group api with last request date time
             [self GetAllCommodityGroupWithLUDT];
         }
         else //if database is empty then call
         {
             [self MethodApiCallGetcommodityGroup];
         }
     }
                                          failure:^(NSString *errorMessage)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"Could not fetch rows from commodity group database,error = %@",errorMessage);
     }];
}

-(void)MethodApiCallGetcommodityGroup
{
    ///api/GetAllCommodityGroups
    //GET
    [[webManager sharedObject]loginRequest:nil withMethod:@"api/GetAllCommodityGroups" successResponce:^(id response)
     {
         NSLog(@"Get commodity group api response = %@",response);
         NSMutableArray *ArrayInsert = [response valueForKey:@"insert"];
         NSString *strMoreItemsLUDT = [response valueForKey:@"LUDT"];
         
         //LUDT format
         [self getLudtWithFormat:strMoreItemsLUDT];
         
         //insert all commodity groups in database table "CommodityGroup",
         [self insertIntoCommodityGroup:ArrayInsert];
         
     }
                                   failure:^(NSError *error)
     {
         NSLog(@"Get commodity group api error = %@",error.description);
         [self GetParentGroupTypes];
     }];
}

-(void)getLudtWithFormat:(NSString *)sringLUDT
{
    // LUDT = "2017-02-08T16:07:49.9991525+05:30";
    NSString *strLUDT = sringLUDT;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSString *currentDateString = strLUDT;
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:currentDate];
    [dateFormatter setDateFormat:@"HH-mm-ss"];
    NSString *timeStr = [dateFormatter stringFromDate:currentDate];
    NSLog(@"CurrentDate:%@", currentDate);
    NSLog(@"DATE - %@",dateStr);
    NSLog(@"TIME - %@",timeStr);
    
    [[NSUserDefaults standardUserDefaults]setObject:dateStr forKey:@"MoreItemsLastUpdatedDate"];
    [[NSUserDefaults standardUserDefaults]setObject:timeStr forKey:@"MoreItemsLastUpdatedTime"];
}

-(void)insertIntoCommodityGroup:(NSMutableArray *)insertArray
{
    //insert all commodity groups in database table "CommodityGroup",
    
    for (int i = 0; i < insertArray.count; i ++)
    {
        //  NSLog(@"%@",[insertArray objectAtIndex:i]);
        
        //NSDictionary *dic = [insertArray objectAtIndex:i];
        NSString *GroupName= [NSString stringWithFormat:@"%@",[[insertArray objectAtIndex:i] valueForKey:@"GroupName"]];
        NSString *GroupType= [NSString stringWithFormat:@"%@", [[insertArray objectAtIndex:i] valueForKey:@"GroupType"]];
        NSString *strgrpid = [NSString stringWithFormat:@"%@",[[insertArray objectAtIndex:i] valueForKey:@"GroupID"]];
        NSString *strParentId = [NSString stringWithFormat:@"%@", [[insertArray objectAtIndex:i] valueForKey:@"ParentGroupID"]];
        
        
        NSString *query = [NSString stringWithFormat:@"INSERT INTO CommodityGroup (GroupID,GroupName,GroupType,ParentGroupID) VALUES (:GroupID ,:GroupName,:GroupType,:ParentGroupID)"];
        
        /*
         NSDictionary *parameter = @{
         @"GroupName":GroupName,
         @"GroupType":GroupType,
         @"GroupID":[NSNumber numberWithInt:GroupID],
         @"ParentGroupID":[NSNumber numberWithInt:ParentGroupID]
         };
         */
        
        NSDictionary *parameter = @{
                                    @"GroupName":GroupName,
                                    @"GroupType":GroupType,
                                    @"GroupID":strgrpid,
                                    @"ParentGroupID":strParentId
                                    };
        
        [[SQLiteDatabase sharedInstance] executeUpdate:query withParams:parameter
                                               success:^(SQLiteResult *result)
         {
             NSLog(@"response of insert commodity Group = %@",result);
             
             if (i == insertArray.count-1)
             {
                 [self GetParentGroupTypes];
             }
         }
                                               failure:^(NSString *errorMessage)
         {
             NSLog(@"error of insert commodity Group  = %@",errorMessage);
         }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//LUDT >>>
-(void)GetAllCommodityGroupWithLUDT
{
    /* //GET api
     /api/GetAllCommodityGroups/{LastRequestDate?}/{Time?}
     
     in format -
     /api/GetAllCommodityGroups/yyyy-MM-dd/HH-mm-ss
     
     Eg:
     /api/GetAllCommodityGroups/2016-12-01/13-20-46
     */
    
    NSString *strLUDTdate = [[NSUserDefaults standardUserDefaults]valueForKey:@"MoreItemsLastUpdatedDate"];
    NSString *strLUDTtime = [[NSUserDefaults standardUserDefaults]valueForKey:@"MoreItemsLastUpdatedTime"];
    
    [[webManager sharedObject]loginRequest:nil withMethod:[NSString stringWithFormat:@"api/GetAllCommodityGroups/%@/%@",strLUDTdate,strLUDTtime]
                           successResponce:^(id response)
     {
         NSLog(@"GetAllCommodityGroups with LUDT response = %@",response);
         NSMutableArray *ArrayInsert = [response valueForKey:@"insert"];
         
         if (ArrayInsert.count >0)
         {
             //insert all commodity groups in database table "CommodityGroup",
             [self insertIntoCommodityGroup:ArrayInsert];
         }
         else
         {
             [self GetParentGroupTypes];
         }
     }
                                   failure:^(NSError *error)
     {
         NSLog(@"GetAllCommodityGroups with LUDT response = %@",error.description);
         [self GetParentGroupTypes];
     }];
}

-(void)GetParentGroupTypes
{
    NSString *query1 = @"select DISTINCT GroupType from CommodityGroup";
    NSLog(@"Query %@ ",query1);
    [[MethodsManager sharedManager]loadingView:self.view];
    [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"select DISTINCT GroupType from CommodityGroup query response = %@",result);
         NSMutableArray *ArrDistinctGroups = result.rows;
         NSLog(@"Array of history  = %@",ArrDistinctGroups);
         
         SQLiteRow *object;
         NSString *strGrpType;
         
         for (int i = 0; i < ArrDistinctGroups.count; i ++)
         {
             object = [ArrDistinctGroups objectAtIndex:i];
             strGrpType = [object stringForColumnName:@"GroupType"];
             [ArrayMoreItems addObject:strGrpType];
         }
         [_tableMoreItems reloadData];
     }
                                          failure:^(NSString *errorMessage)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"Could not fetch DISTINCT GroupType from CommodityGroup query,error = %@",errorMessage);
     }];
}


#pragma tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ArrayMoreItems.count;
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
    cell.label.text = [ArrayMoreItems objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get detail array more items and send it to moreitemsvc1 page
    NSString *strSelectedMoreItem = [ArrayMoreItems objectAtIndex:indexPath.row];
    [self getDetailArray:strSelectedMoreItem];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)getDetailArray:(NSString *)selectedMoreItem
{
    NSString *query = [NSString stringWithFormat:@"select * from CommodityGroup where GroupType='%@' AND ParentGroupID=0",selectedMoreItem];
    
    [[MethodsManager sharedManager]loadingView:self.view];
    [[SQLiteDatabase sharedInstance] executeQuery:query withParams:nil success:^(SQLiteResult *result)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"Get sub groups of selectedParentGroup database response = %@",result);
         NSMutableArray *resultArray = result.rows;
         // ArraySubGroups = [resultArray mutableCopy];
         // NSLog(@"result Array = %@",resultArray);
         
         SQLiteRow *object;
         NSString *strGrpName;
         NSString *strGrpID;
         [ArraySubGroups removeAllObjects];
         [ArraySubGroupsID removeAllObjects];
         
         for (int i =0; i < resultArray.count; i ++)
         {
             object = [resultArray objectAtIndex:i];
             strGrpName = [object stringForColumnName:@"GroupName"];
             strGrpID = [object stringForColumnName:@"GroupID"];
             
             //  [dic setObject:strGrpID forKey:@"strGrpID"];
             // [dic setObject:strGrpName forKey:@"GroupName"];
             //[ArraySubGroupsID addObject:dic];
             
             [ArraySubGroups addObject:strGrpName];
             [ArraySubGroupsID addObject:strGrpID];
         }
         MoreItems1VC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MoreItems1VC"];
         vc.ArraySubGroups = ArraySubGroups;
         vc.ArraySubGroupID = ArraySubGroupsID;
         vc.strSelectedItem = selectedMoreItem;
         [self.navigationController pushViewController:vc animated:YES];
     }
                                          failure:^(NSString *errorMessage)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"Could not fetch rows from Get sub groups of selectedParentGroup database response,error = %@",errorMessage);
     }];
}
@end
