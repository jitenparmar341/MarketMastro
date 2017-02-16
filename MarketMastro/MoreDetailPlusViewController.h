//
//  MoreDetailPlusViewController.h
//  MarketMastro
//
//  Created by DHARMESH on 07/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface MoreDetailPlusViewController : UIViewController
{
    sqlite3 *sqliteDB;
}
@property (weak, nonatomic) IBOutlet UITableView *tableMoreitems;
@property (copy, nonatomic) NSString *sender;
@property (copy,nonatomic) NSString *selectedGroupID;

@end
