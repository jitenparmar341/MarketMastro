//
//  ModeOfPaymentVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 15/02/17.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "ModeOfPaymentVC.h"
#import "CustomModePay.h"
#import "UpgradeDetailsVC.h"

@interface ModeOfPaymentVC ()

@end

@implementation ModeOfPaymentVC

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Mode of Payment";
    
    arrPaymentMode = [NSMutableArray array];
    
    NSMutableDictionary *dicData = [NSMutableDictionary dictionary];
    [dicData setValue:@"Credit Card" forKey:@"name"];
    [dicData setValue:@"payment_card_ico" forKey:@"image"];
    
    [arrPaymentMode addObject:dicData];
    
    dicData = [NSMutableDictionary dictionary];
    [dicData setValue:@"Debit Card" forKey:@"name"];
    [dicData setValue:@"payment_card_ico" forKey:@"image"];
    
    [arrPaymentMode addObject:dicData];
    
    dicData = [NSMutableDictionary dictionary];
    [dicData setValue:@"Net Banking" forKey:@"name"];
    [dicData setValue:@"payment_netbanking_ico" forKey:@"image"];
    
    [arrPaymentMode addObject:dicData];
    
    dicData = [NSMutableDictionary dictionary];
    [dicData setValue:@"PayzApp Wallet" forKey:@"name"];
    [dicData setValue:@"payment_wallet_ico" forKey:@"image"];
    
    [arrPaymentMode addObject:dicData];
    
    dicData = [NSMutableDictionary dictionary];
    [dicData setValue:@"Cash Deposit" forKey:@"name"];
    [dicData setValue:@"payment_cash_ico" forKey:@"image"];
    
    [arrPaymentMode addObject:dicData];
    
    dicData = [NSMutableDictionary dictionary];
    [dicData setValue:@"NEFT" forKey:@"name"];
    [dicData setValue:@"payment_neft_ico" forKey:@"image"];
    
    [arrPaymentMode addObject:dicData];
    
    dicData = [NSMutableDictionary dictionary];
    [dicData setValue:@"Cheque" forKey:@"name"];
    [dicData setValue:@"payment_cheque_ico" forKey:@"image"];
    
    [arrPaymentMode addObject:dicData];
    
    [self.tblPayment reloadData];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    // Do any additional setup after loading the view.
}

#pragma mark - Received Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Click Method

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)callingBtnClick:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://11111111111"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return arrPaymentMode.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"paymentmode";
    
    CustomModePay *cell = (CustomModePay*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dicData = [arrPaymentMode objectAtIndex:indexPath.section];
    
    cell.lblPaymentMode.text = [dicData valueForKey:@"name"];
    
    cell.imgView.image = [UIImage imageNamed:[dicData valueForKey:@"image"]];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UpgradeDetailsVC *upgradeDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"UpgradeDetailsVC"];
    
    [[self navigationController] pushViewController:upgradeDetail animated:true];
}

@end
