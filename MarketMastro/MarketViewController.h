//
//  MarketViewController.h
//  MarketMastro
//
//  Created by Harish Patra on 26/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstFourVC.h"

@interface MarketViewController : UIViewController

- (void)reloadTableData;

@property(nonatomic, strong)FirstFourVC *object;

@end
