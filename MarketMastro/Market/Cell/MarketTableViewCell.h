//
//  MarketTableViewCell.h
//  MarketMastro
//
//  Created by Harish Patra on 27/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewBG;
@property (weak, nonatomic) IBOutlet UILabel *lblName_Date;
@property (weak, nonatomic) IBOutlet UILabel *lblStartEndRate;
@property (weak, nonatomic) IBOutlet UILabel *lblH;
@property (weak, nonatomic) IBOutlet UILabel *lblHighRate;
@property (weak, nonatomic) IBOutlet UILabel *lblSeparator1;
@property (weak, nonatomic) IBOutlet UILabel *lblL;
@property (weak, nonatomic) IBOutlet UILabel *lblLowRate;
@property (weak, nonatomic) IBOutlet UILabel *lblSeparator2;
@property (weak, nonatomic) IBOutlet UILabel *lblO;
@property (weak, nonatomic) IBOutlet UILabel *lblOpenRate;

@property (weak, nonatomic) IBOutlet UIButton *btnOTime_Delete;

@property (weak, nonatomic) IBOutlet UILabel *lblLiveRate;
@property (weak, nonatomic) IBOutlet UILabel *lblLiveEffect;

@end
