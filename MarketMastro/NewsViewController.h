//
//  NewsViewController.h
//  MarketMastro
//
//  Created by Harish Patra on 09/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FirstFourVC.h"

@interface NewsViewController : UIViewController {
    
    __weak IBOutlet UIBarButtonItem *sidebarButton;
    __weak IBOutlet UITableView *newsTableView;
    __weak IBOutlet GADBannerView *adBannerView;
    
}


@end
