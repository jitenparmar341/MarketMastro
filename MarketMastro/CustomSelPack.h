//
//  CustomSelPack.h
//  MarketMastro
//
//  Created by jiten on 15/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSelPack : UITableViewCell
{
    
}

@property (nonatomic,weak)IBOutlet UILabel *lblMain,*lblSub,*lblPrice;
@property (nonatomic,weak)IBOutlet UILabel *viewPrice;
@property (nonatomic,weak)IBOutlet UIButton *btnSubScribe;

@end
