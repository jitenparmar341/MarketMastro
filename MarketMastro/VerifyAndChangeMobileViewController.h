//
//  VerifyAndChangeMobileViewController.h
//  MarketMastro
//
//  Created by Mac on 14/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ChangeMobileNumberProtocol <NSObject>

-(void)sendDataToA:(NSString *)strPopped;

@end

@interface VerifyAndChangeMobileViewController : UIViewController
{
    __weak IBOutlet UIView *ViewForResendOTP;
    __weak IBOutlet UILabel *lblOR;
}
@property (weak, nonatomic) IBOutlet UILabel *lblText;

@property(nonatomic,copy)NSString *strMobileNumber;

@property(nonatomic,copy)NSString *isSigned;

@property (nonatomic, strong) IBOutlet UIButton *btnVerify;
@property (nonatomic, strong) IBOutlet UIButton *btnChangeMobileNumber;
@property (nonatomic, strong) IBOutlet UILabel *labelOTPDelivered;


@property (nonatomic, strong) IBOutlet UIButton *btnResendOTP;
@property (nonatomic, strong) IBOutlet UIButton *btnOTPReceiveViaCall;


@property (nonatomic, strong) IBOutlet UILabel *labelOTPTime;
@property (nonatomic, strong) IBOutlet UIImageView *imageViewClockTime;
@property (weak, nonatomic) IBOutlet UITextField *txtOtp;
@property(nonatomic,assign)id ChanegeMobileNumberDelegate;


@property (weak, nonatomic) IBOutlet UILabel *lblTimer;

-(void)updateCounter:(NSTimer *)theTimer;
-(void)countdownTimer;


- (IBAction)btnVerifyTapped:(id)sender;



- (IBAction)btnChangeMobileNumberTapped:(id)sender;

- (IBAction)MethodResendOTP:(id)sender;
- (IBAction)MethodReceiveOTPviaCall:(id)sender;

@end
