//
//  CurrentAlertListCell.m
//  MarketMastro
//
//  Created by DHARMESH on 02/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "CurrentAlertListCell.h"

@implementation CurrentAlertListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) layoutSubviews
{
    NSMutableArray *subviews = [self.subviews mutableCopy];
    UIView *subV = subviews[0];
    [subviews removeObjectAtIndex:0];
    CGRect f = subV.frame;
    f.size.height = 85;
    subV.frame = f;
};
@end
