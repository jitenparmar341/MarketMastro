//
//  UpgradeDetailsVC.h
//  MarketMastro
//
//  Created by Kanhaiya on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpgradeDetailsVC : UIViewController<UITextFieldDelegate>
{
    UITextField *txtRef;
}

@property (nonatomic,weak)IBOutlet UIButton *btnApply;

@property (nonatomic,weak)IBOutlet UITextField *txtPromoCode,*txtBalance;

@property(nonatomic,retain)NSString *numberOfIndex;
@end
