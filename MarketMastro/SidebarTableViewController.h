//
//  SidebarTableViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface SidebarTableViewController : UITableViewController

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblname;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblcredit;
@property (weak, nonatomic) IBOutlet UITableView *tableSideMenu;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;


@end
