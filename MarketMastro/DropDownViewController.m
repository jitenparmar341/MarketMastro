//
//  DropDownViewController.m
//  MarketMastro
//
//  Created by DHARMESH on 10/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "DropDownViewController.h"
#import "DropDownCell.h"

@interface DropDownViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DropDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview deleagate methods






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;    //count number of row from counting array hear cataGorry is An Array
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
    
    cell.lblCityName.text = @"My Text";
    return cell;
}

@end
