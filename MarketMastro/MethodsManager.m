//
//  MethodsManager.m
//  MarketMastro
//
//  Created by DHARMESH on 23/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "MethodsManager.h"
#import "Reachability.h"


@implementation MethodsManager

static MethodsManager *SharedMethodsManager = nil;    // static instance variable

+ (MethodsManager *)sharedManager
{
    if (SharedMethodsManager == nil)
    {
        SharedMethodsManager = [[super allocWithZone:NULL] init];
    }
    return SharedMethodsManager;
}

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
    }
    return self;
}

- (void)customMethod {
    // implement your custom code here
}

-(void)loadingView:(UIView*)view
{
    transperentView = [[UIView alloc]init];
    transperentView.frame = view.frame;
    transperentView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    [view addSubview:transperentView];
    transperentView.hidden = NO;
    
  //  UIImage *imgLoader = [UIImage imageNamed:@"loading_1.png"];
    imgViewLoading = [[UIImageView alloc]init];
    
    imgViewLoading.frame = CGRectMake(CGRectGetMidX(view.frame)-40, CGRectGetMidY(view.frame), 100, 20);
    NSMutableArray *gifImgArr = [[NSMutableArray alloc] init];
    
    for(int i = 1; i<8; i++)
    {
        [gifImgArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d.png",i]]];
    }
    
    imgViewLoading.animationImages = gifImgArr;
    imgViewLoading.animationDuration = 1.0f;
    [view addSubview:imgViewLoading];
    [imgViewLoading startAnimating];
    
    //block ui
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

-(void)StopAnimating
{
    transperentView.hidden = YES;
    
    //unblock ui
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
     [imgViewLoading stopAnimating];
}

- (BOOL)isInternetAvailable
{
    BOOL isAvailablee = NO;
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        NSLog(@"There is no internet connection");
        isAvailablee = NO;
    }
    else
    {
        NSLog(@"There is internet connection");
        isAvailablee = YES;
    }
    return isAvailablee;
}

@end


