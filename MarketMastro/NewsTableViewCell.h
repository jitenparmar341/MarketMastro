//
//  NewsTableViewCell.h
//  MarketMastro
//
//  Created by Harish Patra on 26/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewBG;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewNewsImage;
@property (weak, nonatomic) IBOutlet UILabel *lblNewsTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblNewsTime;

@end
