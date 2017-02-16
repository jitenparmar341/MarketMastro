//
//  SingInViewController.h
//  MarketMastro
//
//  Created by Mac on 13/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingInViewController : UIViewController {
    BOOL keyboardIsShowing;
}
@property (nonatomic, strong) IBOutlet UITextField *txtFieldMobileNumber;
@property (nonatomic, strong) IBOutlet UIButton *btnContinue;

- (IBAction)MethodDontHaveAccount:(id)sender;
- (IBAction)btnSignIntapped:(id)sender;

@end
