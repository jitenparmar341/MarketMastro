//
//  MoreItems1VC.h
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreItems1VC : UIViewController

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableviewMoreItems;

@property (copy, nonatomic) NSMutableArray *ArraySubGroups;
@property (copy, nonatomic) NSMutableArray *ArraySubGroupID;

@property (copy, nonatomic) NSString *strSelectedItem;

@end
