//
//  MarketCreateAlertVC.h
//  MarketMastro
//
//  Created by Vodlo iMac 022 on 24/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreatePortflioVC.h"

@interface MarketCreateAlertVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnSelectComm;
extern NSString *selctedOptionMarket;
@property (weak, nonatomic) IBOutlet UIButton *selectCondition;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPrice;
@property (strong, nonatomic) IBOutlet UIView *viewForAlertOption;
@end
