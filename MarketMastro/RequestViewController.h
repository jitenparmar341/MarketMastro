//
//  RequestViewController.h
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestViewController : UIViewController
{
    __weak IBOutlet UITextView *textviewDescription;
    __weak IBOutlet UITextField *txtCommodityName;
    __weak IBOutlet UILabel *lblDesc;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)btnSendTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsend;

@end
