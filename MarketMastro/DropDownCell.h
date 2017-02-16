//
//  DropDownCell.h
//  MarketMastro
//
//  Created by DHARMESH on 10/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCityName;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *sublabel;
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;


@end
