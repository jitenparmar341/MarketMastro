//
//  CurrentAlertListCell.h
//  MarketMastro
//
//  Created by DHARMESH on 02/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentAlertListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *container;

@property (weak, nonatomic) IBOutlet UILabel *lblCommodityAlert;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;

@end
