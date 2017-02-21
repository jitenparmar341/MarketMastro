//
//  MyAlertViewController.m
//  MarketMastro
//
//  Created by DHARMESH on 02/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "MyAlertViewController.h"

@interface MyAlertViewController ()

@end

@implementation MyAlertViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 if([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
 [self.delegate webViewDidStartLoad:self];
 }
 */

- (IBAction)BtnOkTapped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(okButtonClick)])
    {
        [self.delegate okButtonClick];
    }
}
@end
