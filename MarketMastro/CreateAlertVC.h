//
//  CreateAlertVC.h
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;

@interface CreateAlertVC : UIViewController {
    //Firebase
    __weak IBOutlet GADBannerView *adBannerView;
}
@property (weak, nonatomic) IBOutlet UIButton *btnSelectComm;
extern NSString *selctedOption;
@property (weak, nonatomic) IBOutlet UIButton *selectCondition;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPrice;
@property (strong, nonatomic) IBOutlet UIView *viewForAlertOption;
@property (strong, nonatomic)NSMutableDictionary *DicSelectedAlert;
@property (weak, nonatomic) IBOutlet UIButton *btnSetAlert;
@property (nonatomic, assign)BOOL isFromAertViewController;

@property (nonatomic, copy) NSString *selectedItem;

@end
