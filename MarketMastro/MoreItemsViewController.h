//
//  MoreItemsViewController.h
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreItemsViewController : UIViewController

/*
 @property (weak, nonatomic) IBOutlet UIButton *btnMCX;
 @property (weak, nonatomic) IBOutlet UIImageView *imgMcx;
 @property (weak, nonatomic) IBOutlet UIButton *btnexcel;
 @property (weak, nonatomic) IBOutlet UIImageView *imgExcel;
 @property (weak, nonatomic) IBOutlet UIButton *btnlocalspot;
 @property (weak, nonatomic) IBOutlet UIImageView *imgLocalSpot;
 */

@property (weak, nonatomic) IBOutlet UITableView *tableMoreItems;
@property (copy, nonatomic) NSString *isFromVC;

@end
