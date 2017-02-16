//
//  MyAlertViewController.h
//  MarketMastro
//
//  Created by DHARMESH on 02/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//


//IT IS A CUSTOM POPUP VIEW CONTROLLER ********

#import <UIKit/UIKit.h>

@protocol MyAlertViewDelegate <NSObject>
- (void)okButtonClick;
@end


@interface MyAlertViewController : UIViewController
@property (nonatomic, weak) id <MyAlertViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *PopupHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;


- (IBAction)BtnOkTapped:(id)sender;

@end
