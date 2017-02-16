//
//  MarketViewController.m
//  MarketMastro
//
//  Created by Harish Patra on 26/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "MarketViewController.h"

#import "MarketTableViewCell.h"

@interface MarketViewController ()<UITableViewDelegate, UITableViewDataSource> {
    
    __weak IBOutlet UITableView *tableViewMarket;
    
    NSMutableArray *arrMarketData;
}

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    tableViewMarket.backgroundColor = [UIColor colorwithHexString:@"#16191B"];
    tableViewMarket.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"Appear");
    arrMarketData = [[NSMutableArray alloc] init];
    [arrMarketData addObject:@"MarketCellID"];
    [arrMarketData addObject:@"MarketCellID"];
    [arrMarketData addObject:@"MarketCellID"];
    [arrMarketData addObject:@"MarketCellID"];
    [tableViewMarket reloadData];
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrMarketData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if([self.title isEqualToString:@"Bullion"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Expected MCX"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Costing & Difference"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Base metals"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Energy"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Local Spot"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"International Markets"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
*/

- (UITableViewCell*)shareCellDesignTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    MarketTableViewCell *mCell;
    mCell = [tableView dequeueReusableCellWithIdentifier:@"MarketCellID" forIndexPath:indexPath];
    mCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Temp
    if (indexPath.row == 1) {
        [self colorUpForView:mCell.lblLiveRate];
    }
    
    //Data Fitting
    [mCell.lblName_Date setAttributedText:[self productName:@"SILVER" productDate:@"27 Feb 2017"]];
    [mCell.lblStartEndRate setAttributedText:[self rateStart:@"41207.00" rateEnd:@"41215.00"]];
    [mCell.btnOTime_Delete setTitle:@"19:18:17" forState:UIControlStateNormal];
    return mCell;
}

- (NSAttributedString*)productName:(NSString*)pName productDate:(id)pDate {
    NSString *tFString;
    NSString *tPDate;
    if ([pDate isKindOfClass:[NSString class]]) {
        tPDate = pDate;
    }
    else {
        tPDate = @"27 Feb 2017";
    }
    tFString = [pName stringByAppendingFormat:@"  %@", tPDate];
    NSRange nRange = [tFString rangeOfString:pName];
    NSRange dRange = [tFString rangeOfString:tPDate];
    
    NSMutableAttributedString *tFAttString = [[NSMutableAttributedString alloc] initWithString:tFString];
    [tFAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ffffff"] range:nRange];
    [tFAttString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Lato-Regular" size:10.0] range:nRange];
    
    NSDictionary *tDic = @{NSForegroundColorAttributeName: [UIColor colorwithHexString:@"#959595"], NSFontAttributeName: [UIFont fontWithName:@"Lato-Regular" size:8.0]};
    [tFAttString addAttributes:tDic range:dRange];
    
    return tFAttString;
}

- (NSAttributedString*)rateStart:(NSString*)rStart rateEnd:(NSString*)rEnd {
    NSString *tFString = [rStart stringByAppendingFormat:@" - %@", rEnd];
    NSRange sRange = [tFString rangeOfString:rStart];
    NSRange dashRang = [tFString rangeOfString:@" - "];
    NSRange eRange = [tFString rangeOfString:rEnd];
    
    NSMutableAttributedString *tFAttString = [[NSMutableAttributedString alloc] initWithString:tFString];
    [tFAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ffffff"] range:sRange];
    [tFAttString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Lato-Regular" size:13.0] range:sRange];
    
    [tFAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ffffff"] range:dashRang];
    [tFAttString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Lato-Bold" size:12.0] range:dashRang];
    
    NSDictionary *tDic = @{NSForegroundColorAttributeName: [UIColor colorwithHexString:@"#ffffff"], NSFontAttributeName: [UIFont fontWithName:@"Lato-Regular" size:13.0]};
    [tFAttString addAttributes:tDic range:eRange];
    
    return tFAttString;
}

- (void)colorUpForView:(UIView*)idView {
    [UIView animateWithDuration:0 animations:^{
        [idView setBackgroundColor:[UIColor colorwithHexString:@"#15558C"]];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0 animations:^{
            [idView setBackgroundColor:[UIColor clearColor]];
        } completion:^(BOOL finished) {
            [self colorDownForView:idView];
        }];
         }];
}

- (void)colorDownForView:(UIView*)idView {
    [UIView animateWithDuration:0 animations:^{
        [idView setBackgroundColor:[UIColor colorwithHexString:@"#BA1E1A"]];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0 animations:^{
            [idView setBackgroundColor:[UIColor clearColor]];
        } completion:^(BOOL finished) {
            [self colorUpForView:idView];
        }];
        }];
}
@end
