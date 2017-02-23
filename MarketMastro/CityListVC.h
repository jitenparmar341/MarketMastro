//
//  CityListVC.h
//  MarketMastro
//
//  Created by jiten on 24/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityListVC : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    
}

@property (nonatomic,weak)IBOutlet UISearchBar *srcBar;

@property (nonatomic,retain)NSMutableArray *arrCityList;

@property (nonatomic,weak)IBOutlet UITableView *tblList;

@end
