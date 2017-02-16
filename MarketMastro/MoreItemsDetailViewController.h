//
//  MoreItemsDetailViewController.h
//  MarketMastro
//
//  Created by DHARMESH on 01/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreItemsDetailViewController : UIViewController

@property(copy, nonatomic)NSString *sender;
@property (weak, nonatomic) IBOutlet UITableView *tableMoreItemsDetail;


@property (copy, nonatomic)NSMutableArray *ArraysubAGroups;
@property (copy, nonatomic)NSMutableArray *ArraySubGroupIDs;

@end
