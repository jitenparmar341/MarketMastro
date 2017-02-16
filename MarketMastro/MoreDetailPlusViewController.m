//
//  MoreDetailPlusViewController.m
//  MarketMastro
//
//  Created by DHARMESH on 07/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "MoreDetailPlusViewController.h"

@interface MoreDetailPlusViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *ArrayMain;
    NSMutableArray *detailsArray;
    NSString *isFromVC;
    UIBarButtonItem *btnDone;
    NSMutableArray *ArrayUserPortFolio;
    NSMutableArray *ArrayPresentCommodity;
    NSString *ifExistinPortFolio;
    
    NSMutableArray *resultArrayy;
}
@end

@implementation MoreDetailPlusViewController
@synthesize selectedGroupID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _sender;
    
    ArrayUserPortFolio = [[NSMutableArray alloc]init];
    detailsArray = [[NSMutableArray alloc]init];
    resultArrayy = [[NSMutableArray alloc]init];
    
    isFromVC = [[NSUserDefaults standardUserDefaults]valueForKey:@"isFromVC"];
    NSLog(@"isFromVc = %@",isFromVC);
    [self GetCommoditiesByGroupID];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self doneButtonOnNavigation];
}

-(void)doneButtonOnNavigation
{
    CGRect frameimg = CGRectMake(0, 0, 18, 15);
    UIButton *done = [[UIButton alloc] initWithFrame:frameimg];
    [done setImage:[UIImage imageNamed:@"act_tick_ico"] forState:UIControlStateNormal];
    [done.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [done addTarget:self action:@selector(BtnDoneTapped) forControlEvents:UIControlEventTouchUpInside];
    btnDone = [[UIBarButtonItem alloc] initWithCustomView:done];
    [self.navigationItem setRightBarButtonItem:btnDone];
    
    if ([isFromVC isEqualToString:@"Dashboard"])
    {
        //cell.btnPlus.hidden = YES;
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.navigationItem setRightBarButtonItem:nil];
    }
    else if ([isFromVC isEqualToString:@"Port"])//portfolio
    {
        // cell.btnPlus.hidden = NO;
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
    else if ([isFromVC isEqualToString:@"Alert"])
    {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.navigationItem setRightBarButtonItem:nil];
    }
}

-(void)BtnDoneTapped
{
    NSLog(@"button done tapped");
    //add plus(+) or remove(-) commodity to user portfolio table
    [self addOrRemoveFromUserPortfolioTable];
}

/*
 /api/GetCommoditiesByGroupID/{GroupID}
 //GET
 */

-(void)GetCommoditiesByGroupID
{
    [[MethodsManager sharedManager]loadingView:self.view];
    [[webManager sharedObject]loginRequest:nil withMethod:[NSString stringWithFormat:@"api/GetCommoditiesByGroupID/%@",selectedGroupID] successResponce:^(id response)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"moreItems fourth page>>GetCommoditiesByGroupID response = %@",response);
         
         NSMutableArray *responseArray = response;
         [self matchCommodityID:responseArray];
     }
     failure:^(NSError *error)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"moreItems fourth page>>GetCommoditiesByGroupID error = %@",error);
     }];
}

-(void)matchCommodityID:(NSMutableArray *)responseArray
{
    
    //Check if every commodity is exist in Commodity table, using commodity id- Refer trying query = "select * from Commodity where CommodityID ="+ commodityId + " AND Status=1";,
    
    NSString *strCommodityID;
    
    for (int i =0; i< responseArray.count; i ++)
    {
        strCommodityID = [NSString stringWithFormat:@"%@",[[responseArray valueForKey:@"CommodityID"] objectAtIndex:i]];
        NSString *query =  [NSString stringWithFormat:@"select * from Commodity where CommodityID ='%@' AND Status=1",strCommodityID];
        
        [[SQLiteDatabase sharedInstance]executeQuery:query withParams:nil success:^(SQLiteResult *result)
         {
            NSLog(@"match commodity id query response = %@",result);
            resultArrayy = result.rows;
            SQLiteRow *object = [resultArrayy objectAtIndex:0];
           // ifExistinPortFolio =
           [self presentInPortFolio:strCommodityID object:object];
             
         }
          failure:^(NSString *errorMessage)
         {
             NSLog(@"match commodity id query response = %@",errorMessage);
         }];
    }
   // NSLog(@"detailsarray = %@",detailsArray);
}

-(void)presentInPortFolio:(NSString*)strCommoID object:(SQLiteRow*)object
{
    NSString *strCommodityID = strCommoID;
    NSString *query =  [NSString stringWithFormat:@"select * from UserPortfolio where CommodityId ='%@'",strCommodityID];
    
    // [[MethodsManager sharedManager]loadingView:self.view];
     [[SQLiteDatabase sharedInstance]executeQuery:query withParams:nil success:^(SQLiteResult *result)
     {
     
       NSLog(@"query = %@",query);
         
     // [[MethodsManager sharedManager]StopAnimating];
      NSMutableArray *ResultArray = result.rows;
      NSLog(@"resultArray = %@",ResultArray);
      NSString *status = @"NO";
     
    if (ResultArray.count >0)
    {
    status = @"YES";
    }
     
     NSString *strName = [object stringForColumnName:@"Name"];
     NSString *strScriptCode = [object stringForColumnName:@"ScriptCode"];
     NSString *strCommodityType = [object stringForColumnName:@"CommodityType"];
     NSString *strExpiry = [object stringForColumnName:@"Expiry"];
     NSString *strExch = [object stringForColumnName:@"Exch"];
     NSString *strExchType = [object stringForColumnName:@"ExchType"];
     NSString *strSubTitle = [object stringForColumnName:@"SubTitle"];
     NSString *strDigits = [object stringForColumnName:@"Digits"];
     NSString *strCommodityID = [object stringForColumnName:@"CommodityID"];
     [detailsArray addObject:@{@"Name":strName,
                               @"CommodityID":strCommodityID,
                               @"ScriptCode":strScriptCode,
                               @"CommodityType":strCommodityType,
                               @"Expiry":strExpiry,
                               @"Exch":strExch,
                               @"ExchType":strExchType,
                               @"SubTitle":strSubTitle,
                               @"Digits":strDigits,
                               @"Status":status
     }];
     
     NSLog(@"detailsArray = %@",detailsArray);
     ArrayMain = detailsArray;
     [_tableMoreitems reloadData];
     
     }
     failure:^(NSString *errorMessage)
     {
    // [[MethodsManager sharedManager]StopAnimating];
     NSLog(@"select all from user portfolio table error = %@",errorMessage);
     }];
}


-(void)checkIfPresentInUserPortfolioTable
{
    for (int i =0; i <detailsArray.count; i++)
    {
        NSString *strCommodityID = [[detailsArray objectAtIndex:i] valueForKey:@"CommodityID"];
        NSString *query =  [NSString stringWithFormat:@"select * from UserPortfolio where CommodityId ='%@'",strCommodityID];
        
        [[MethodsManager sharedManager]loadingView:self.view];
        [[SQLiteDatabase sharedInstance]executeQuery:query withParams:nil success:^(SQLiteResult *result) {
            
            [[MethodsManager sharedManager]StopAnimating];
            NSMutableArray *ResultArray = result.rows;
            for (int i = 0; i <ResultArray.count; i ++)
            {
                //then show minus button >>>>
                SQLiteRow *object = [ResultArray objectAtIndex:i];
                NSString *strPresentCommodity = [object stringForColumnName:@"CommodityID"];
                [ArrayPresentCommodity addObject:strPresentCommodity];
            }
        } failure:^(NSString *errorMessage)
         {
            [[MethodsManager sharedManager]StopAnimating];
             NSLog(@"select all from user portfolio table error = %@",errorMessage);
         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    cell.label.text = [[ArrayMain objectAtIndex:indexPath.row] valueForKey:@"Name"];
    
    if ([isFromVC isEqualToString:@"Dashboard"])
    {
        cell.btnPlus.hidden = YES;
    }
    else if ([isFromVC isEqualToString:@"Port"])//portfolio
    {
        cell.btnPlus.hidden = NO;
        cell.btnPlus.tag = indexPath.row;
        
        NSString *StatusPlusMinus = [[ArrayMain objectAtIndex:indexPath.row] valueForKey:@"Status"];
        
       if ([StatusPlusMinus isEqualToString:@"YES"])
        {
            [cell.btnPlus setBackgroundImage:[UIImage imageNamed:@"act_remove_ico.png"] forState:UIControlStateNormal];
        }
        
        [cell.btnPlus addTarget:self action:@selector(btnPlusTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([isFromVC isEqualToString:@"Alert"])
    {
        cell.btnPlus.hidden = YES;
    }
    return cell;
}

-(void)btnPlusTapped:(id)sender
{
    UIButton *plusbutton = sender;
    
    plusbutton.selected = !plusbutton.selected;
    [plusbutton setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    
    [plusbutton setBackgroundImage:[UIImage imageNamed:@"act_remove_ico.png"] forState:UIControlStateSelected];
    
    if (plusbutton.selected)
    {
        [ArrayUserPortFolio addObject:[ArrayMain objectAtIndex:plusbutton.tag]];
    }
    else
    {
        [ArrayUserPortFolio removeObject:[ArrayMain objectAtIndex:plusbutton.tag]];
        
        NSLog(@"user portfolio array = %@",ArrayUserPortFolio);
    }
    NSLog(@"ArrayUserPortFolio = %@",ArrayUserPortFolio);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([isFromVC isEqualToString:@"Dashboard"])
    {
        MarketDetailsVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MarketDetailsVC"];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if ([isFromVC isEqualToString:@"Alert"])
    {
        //        CreateAlertVC *alert = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAlertVC"];
        //        alert.selectedItem = [[ArrayMain objectAtIndex:indexPath.row] valueForKey:@"Name"];
        //        [self.navigationController popToViewController:alert animated:YES];
    }
}

-(void)addOrRemoveFromUserPortfolioTable
{
    for (int i =0; i<ArrayUserPortFolio.count; i ++)
    {
        NSString *strCommodityID = [NSString stringWithFormat:@"%@",[[ArrayUserPortFolio valueForKey:@"CommodityID"] objectAtIndex:i]];
        NSString *strScriptCode = [NSString stringWithFormat:@"%@",[[ArrayUserPortFolio valueForKey:@"ScriptCode"] objectAtIndex:i]];
        NSString *strCommoType = [NSString stringWithFormat:@"%@",[[ArrayUserPortFolio valueForKey:@"CommodityType"] objectAtIndex:i]];
        NSString *strName = [NSString stringWithFormat:@"%@",[[ArrayUserPortFolio valueForKey:@"Name"] objectAtIndex:i]];
        NSString *strExpiry = [NSString stringWithFormat:@"%@",[[ArrayUserPortFolio valueForKey:@"Expiry"] objectAtIndex:i]];
        
        NSString *query = [NSString stringWithFormat:@"INSERT INTO UserPortfolio (CommodityID,ScriptCode,CommodityType,Name,Expiry) VALUES (:CommodityID,:ScriptCode,:CommodityType,:Name,:Expiry)"];
        
        NSDictionary *parameter = @{
                                    @"CommodityID":strCommodityID,
                                    @"ScriptCode":strScriptCode,
                                    @"CommodityType":strCommoType,
                                    @"Name":strName,
                                    @"Expiry":strExpiry
                                    };
        
        
        [[SQLiteDatabase sharedInstance] executeUpdate:query withParams:parameter
         success:^(SQLiteResult *result)
         {
             NSLog(@"response of insert into user portfolio table = %@",result);
             [self.navigationController popViewControllerAnimated:YES];
         }
         failure:^(NSString *errorMessage)
         {
             NSLog(@"error of insert into user portfolio table = %@",errorMessage);
         }];
    }
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
