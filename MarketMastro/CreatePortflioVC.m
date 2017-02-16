//
//  CreatePortflioVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "CreatePortflioVC.h"
#define RGB(r, g, b)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface CreatePortflioVC ()

@end

@implementation CreatePortflioVC

- (void)viewDidLoad {
    selctedOption = @"";

    self.title = @"Create Commodities";
    [super viewDidLoad];
    _btn1.layer.borderColor = RGB(0, 122, 255).CGColor;
    _btn1.layer.borderWidth = 1;
    
    _btn1.layer.borderColor = RGB(0, 122, 255).CGColor;
    _btn1.layer.borderWidth = 1;

    
    _btn2.layer.borderColor = RGB(0, 122, 255).CGColor;
    _btn2.layer.borderWidth = 1;

    
    _btn3.layer.borderColor = RGB(0, 122, 255).CGColor;
    _btn3.layer.borderWidth = 1;

    
    _btn4.layer.borderColor = RGB(0, 122, 255).CGColor;
    _btn4.layer.borderWidth = 1;

    
    _btn5.layer.borderColor = RGB(0, 122, 255).CGColor;
    _btn5.layer.borderWidth = 1;

    
    _btn6.layer.borderColor = RGB(0, 122, 255).CGColor;
    _btn6.layer.borderWidth = 1;

    
    _btn7.layer.borderColor = RGB(0, 122, 255).CGColor;
    _btn7.layer.borderWidth = 1;

    
    _btn8.layer.borderColor = RGB(0, 122, 255).CGColor;
    _btn8.layer.borderWidth = 1;
    if(_isCreateAlert)
    {
        self.btnSave.hidden = YES;
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    if(btn.selected)
    {
        btn.selected = NO;
    }
    else{
         btn.selected = YES;
        if(_isCreateAlert)
        {
            selctedOption = btn.currentTitle;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"More"])
    {
        MoreItemsViewController *more = (MoreItemsViewController*)[segue destinationViewController];
        more.isFromVC = _isFromVC;
        
          [[NSUserDefaults standardUserDefaults]setObject:_isFromVC forKey:@"isFromVC"];
        
         [[NSUserDefaults standardUserDefaults]setObject:_isFromVC forKey:@"isFromVC"];
        
        
    }
}
@end
