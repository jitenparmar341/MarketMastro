//
//  UpgradeViewController.h
//  MarketMastro
//
//  Created by Kanhaiya on 23/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpgradeViewController : UIViewController<UITableViewDelegate>
{
    
}

@property (nonatomic,weak)IBOutlet UITableView *tblView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic) BOOL is_NotFromDraw;
/*!
 1   :   ThroughRegistration
 2   :   ThroughLogin
 */
@property NSInteger isFrom;
@end
