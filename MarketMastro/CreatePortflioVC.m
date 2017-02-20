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

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    selectedOption = @"";
    
    self.title = @"Choose Community";
    
    [super viewDidLoad];
    _btn1.layer.borderColor = RGB(41, 84, 134).CGColor;
    _btn1.layer.borderWidth = 1;
    
    _btn1.layer.borderColor = RGB(41, 84, 134).CGColor;
    _btn1.layer.borderWidth = 1;

    
    _btn2.layer.borderColor = RGB(41, 84, 134).CGColor;
    _btn2.layer.borderWidth = 1;

    
    _btn3.layer.borderColor = RGB(41, 84, 134).CGColor;
    _btn3.layer.borderWidth = 1;

    
    _btn4.layer.borderColor = RGB(41, 84, 134).CGColor;
    _btn4.layer.borderWidth = 1;

    
    _btn5.layer.borderColor = RGB(41, 84, 134).CGColor;
    _btn5.layer.borderWidth = 1;

    
    _btn6.layer.borderColor = RGB(41, 84, 134).CGColor;
    _btn6.layer.borderWidth = 1;

    
    _btn7.layer.borderColor = RGB(41, 84, 134).CGColor;
    _btn7.layer.borderWidth = 1;

    
    _btn8.layer.borderColor = RGB(41, 84, 134).CGColor;
    _btn8.layer.borderWidth = 1;
    
    self.btnSave.hidden = true;
    
    if (self.isFromPortfolio == true)
    {
        self.btnSave.hidden = false;
    }
    else if(self.isFromMarket == true)
    {
        
    }
    else if (self.isFromAlert == true)
    {
        
    }
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    // Do any additional setup after loading the view.
}

#pragma mark - Received Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Click Method

-(IBAction)btnClick:(UIButton *)sender
{
    if (self.isFromMarket == true)
    {
        return;
    }
    
    sender.selected =! sender.selected;
    
    if(!sender.selected)
    {
        [sender setBackgroundColor:[UIColor clearColor]];
    }
    else
    {
        [sender setBackgroundColor:RGB(41, 84, 134)];
        
        if(self.isFromAlert)
        {
            NSLog(@"%@",selectedOption);
            selectedOption = sender.currentTitle;
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

#pragma mark - Search Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.srcBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.srcBar resignFirstResponder];
}

@end
