//
//  SubscriptionHistoryCell.h
//  MarketMastro
//
//  Created by DHARMESH on 17/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscriptionHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *lblorderid;
@property (weak, nonatomic) IBOutlet UILabel *lblprize;
@property (weak, nonatomic) IBOutlet UILabel *LblPackageName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubscribedOn;
@property (weak, nonatomic) IBOutlet UILabel *lblValidDate;
@property (weak, nonatomic) IBOutlet UIButton *btnActive;


@property (weak, nonatomic) IBOutlet UIButton *btnRenew;

@end
