//
//  CreditCardHistoryVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 26/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "CreditCardHistoryVC.h"

@interface CreditCardHistoryVC ()

@end

@implementation CreditCardHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Credit History";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)optionBtnClick:(UIButton *)sender
{
    UIButton *btn = sender;
    UIButton *btnAll = [self.view viewWithTag:10];
    UIButton *btnReceive = [self.view viewWithTag:11];
    UIButton *btnPaid = [self.view viewWithTag:12];
    
    btnAll.selected = NO;
    btnPaid.selected = NO;
    btnReceive.selected = NO;
    
    //    self.imgArrow.frame = CGRectMake((btn.frame.size.width / 2) - (self.imgArrow.frame.size.width / 2), btn.frame.origin.y+btn.frame.size.height-6, self.imgArrow.frame.size.width, self.imgArrow.frame.size.height);
    
    self.imgArrow.frame = CGRectMake((btn.frame.origin.x+btn.frame.size.width)/2, btn.frame.origin.y+btn.frame.size.height-6, self.imgArrow.frame.size.width, self.imgArrow.frame.size.height);
    
    if(btn == btnAll)
    {
        //        self.imgArrow.frame = CGRectMake(btn.frame.size.width/2, btn.frame.size.height+2, 20, 20);
        //
        btnAll.selected = YES;
    }
    else if(btn == btnReceive)
    {
        //        self.imgArrow.frame = CGRectMake(btn.frame.size.width/2, 80, 20, 20);
        
        btnReceive.selected = YES;
    }
    else if(btn == btnPaid)
    {
        btnPaid.selected = YES;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
