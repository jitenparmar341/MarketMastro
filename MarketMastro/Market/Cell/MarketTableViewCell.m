//
//  MarketTableViewCell.m
//  MarketMastro
//
//  Created by Harish Patra on 27/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "MarketTableViewCell.h"

@implementation MarketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    UILabel *tLbl;
//    [_lblLiveRate addConstraint:[NSLayoutConstraint constraintWithItem:_lblLiveRate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20.0f]];
    [_btnOTime_Delete.titleLabel setTextAlignment:NSTextAlignmentRight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
