//
//  cltMarketCell.h
//  MarketMastro
//
//  Created by jiten on 22/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cltMarketCell : UICollectionViewCell
{
    
}

@property (nonatomic,weak)IBOutlet UILabel *lblName,*lblDate,*lblLastPrice,*lblLastLowHigh;
@property (weak, nonatomic) IBOutlet UIView *viewBG;

@end
