//
//  MarketViewController.h
//  MarketMastro
//
//  Created by Harish Patra on 26/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstFourVC.h"

@interface MarketViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
}

@property (nonatomic,weak)IBOutlet UICollectionView *cltView;

@property(nonatomic, retain)FirstFourVC *object;

- (void)reloadTableData;

@end
