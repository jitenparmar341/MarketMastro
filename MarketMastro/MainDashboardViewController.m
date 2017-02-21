//
//  MainDashboardViewController.m
//  MarketMastro
//
//  Created by Mac on 14/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "MainDashboardViewController.h"
#import "SWRevealViewController.h"
@interface MainDashboardViewController ()

@end

@implementation MainDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:23/255.0 green:25/255.0 blue:27/255.0 alpha:1.0]];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:12/255.0 green:16/255.0 blue:20/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:13/255.0 green:16/255.0 blue:20/255.0 alpha:1.0]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
