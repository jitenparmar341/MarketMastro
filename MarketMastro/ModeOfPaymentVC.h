//
//  ModeOfPaymentVC.h
//  MarketMastro
//
//  Created by Kanhaiya on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModeOfPaymentVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrPaymentMode;
}

@property (nonatomic,weak)IBOutlet UITableView *tblPayment;

@end
