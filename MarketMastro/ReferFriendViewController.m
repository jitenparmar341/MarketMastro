//
//  ReferFriendViewController.m
//  MarketMastro
//
//  Created by Mac on 17/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "ReferFriendViewController.h"
#import "SWRevealViewController.h"
@interface ReferFriendViewController ()

@end

@implementation ReferFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Invite Friends";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _btnInviteFriend.layer.cornerRadius = 3;
    _btnInviteFriend.clipsToBounds = YES;
    _btnCreditHistory.layer.cornerRadius = 3;
    _btnCreditHistory.clipsToBounds = YES;
    _txtMobileNumber.layer.cornerRadius = 3;
    _txtMobileNumber.clipsToBounds = YES;
    _txtMobileNumber.layer.borderColor= [[UIColor colorWithRed:41/255.0 green:42/255.0 blue:43/255.0 alpha:1.0] CGColor];
    _txtMobileNumber.layer.borderWidth= 1.0f;
    

    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)alertListBtnClick:(id)sender
{
    AlertViewController *calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    calendarVC.is_NotFromDraw = YES;

    [self.navigationController pushViewController:calendarVC animated:YES];
}

-(void)dismissKeyboard
{
    if([_txtMobileNumber isFirstResponder])
        [_txtMobileNumber resignFirstResponder];
}

- (IBAction)btnInviteFriendTapped:(id)sender {
}

- (IBAction)btnCreditHistoryTapped:(id)sender {
}

@end
