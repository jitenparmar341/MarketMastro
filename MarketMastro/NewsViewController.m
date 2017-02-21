//
//  NewsViewController.m
//  MarketMastro
//
//  Created by Harish Patra on 09/02/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "NewsViewController.h"

#import "NewsTableViewCell.h"
#import "SWRevealViewController.h"

#import "NetworkManager.h"
#import "NewDetailsVC.h"
#import "News.h"
@interface NewsViewController ()<UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate, GADInAppPurchaseDelegate, GADAdSizeDelegate> {
    NSMutableArray *newsList;
    NSDateFormatter *dateFormatter;
    NSString *apiMethod;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"News";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorwithHexString:@"#FFFFFF"]}];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [sidebarButton setTarget:self.revealViewController];
        [sidebarButton setAction:@selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    
    News *tNews = [[News alloc] init];
    tNews.image = @"rbi-Reu-L.jpg";
    tNews.title = @"RBI introduces incremental cash reserve ratio of 100 per cent.";
    tNews.pubDate = @"26 Nov, 2016 05:00 PM";
    newsList = [[NSMutableArray alloc] init];
    /* [newsList addObject:tNews];
     [newsList addObject:tNews];
     [newsList addObject:tNews];
     [newsList addObject:tNews];*/
    
    [self getApiUrl];
    //AdBanner
    [self bannerAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return newsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *newsCellId = @"NewsCellID";
    NewsTableViewCell *nCell = [tableView dequeueReusableCellWithIdentifier:newsCellId];
    if (!nCell) {
        nCell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsCellId];
    }
    SQLiteRow *object = newsList[indexPath.row];
    
    NSString *currentDateString=[NSString stringWithFormat:@"%@",[object stringForColumnName:@"pubDate"]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"EEE dd MMM, yyyy hh:mm a"];
    NSString *dateStr = [formatter stringFromDate:currentDate];
    nCell.lblNewsTitle.text = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"title"]];
    //  nCell.imgViewNewsImage.image = [UIImage imageNamed:@"rbi-Reu-L.jpg"];
    nCell.imgViewNewsImage.image=nil;
    //    nCell.lblNewsTitle = [[newsList objectAtIndex:indexPath.row] objectForColumnName:@"title"];
    nCell.lblNewsTime.text = dateStr;
    
    //show image
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[object stringForColumnName:@"image"]]];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NewsTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.imgViewNewsImage.image = image;
                });
            }
        }
    }];
    [task resume];
    
    /* NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[object stringForColumnName:@"image"]]];
     
     NSData *imageData = [NSData dataWithContentsOfURL:url];
     nCell.imgViewNewsImage.image = [UIImage imageWithData:imageData];*/
    return nCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row selected");
    NSLog(@"object selceted- %@",newsList[indexPath.row]);
    
    NewDetailsVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NewDetailsVC"];
    detail.news=newsList[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - NewsPage
- (void)newsPage {
    if (![NetworkManager connectedToNetwork]) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not reachable" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
        return;
    }
    
    NSString *UUID = [[NSUserDefaults standardUserDefaults]valueForKey:@"SavedUUID"];
    NSString *strTokenId = [[NSUserDefaults standardUserDefaults] valueForKey:@"TokenID"];
    
    /*NSDate *currentdate = [NSDate date];
     NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];//HH-mm-ss
     NSString *requestDate = [dateFormatter stringFromDate:currentdate];
     
     [dateFormatter setDateFormat:@"HH-mm-ss"];
     NSString *requestSecond = [dateFormatter stringFromDate:currentdate];
     
     NSDictionary *requestTime = @{@"RequestDate": requestDate, @"RequestSecond": requestSecond};*/
    
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc] init];
    [requestDict setObject:@"I" forKey:@"DeviceOS"];
    [requestDict setObject:@"1.0" forKey:@"AppVer"];
    [requestDict setObject:strTokenId forKey:@"Token"];
    [requestDict setObject:UUID forKey:@"UUID"];
    
    
    /* if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"RequestTime"] isKindOfClass:[NSDictionary class]]) {
     NSDictionary *lRequestTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"RequestTime"];
     apiMethod = [NSString stringWithFormat:@"api/GetNews/%@/%@", [lRequestTime objectForKey:@"RequestDate"], [lRequestTime objectForKey:@"RequestSecond"]];
     }
     else {
     apiMethod = @"api/GetNews";
     }*/
    
    [NetworkManager sendWebRequest:nil withMethod:apiMethod successResponce:^(id response) {
        NSLog(@"Data : %@", response);
        if ([response isKindOfClass:[NSArray class]]) {
            
            /*newsList = [[NSMutableArray alloc] init];
             newsList=response;
             [self newsPage];*/
            [self setNewsToDB:response];
            //[self reloadNews];
        }
    } failure:^(NSError *error) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    }];
}

- (void)setNewsToDB:(NSArray*)newsArr {
    NSMutableArray *columnValues = [[NSMutableArray alloc] init];
    
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *tDict in newsArr) {
        NSString *description=[tDict objectForKey:@"description"];
        NSRange range = [description rangeOfString:@"http"];
        
        NSLog(@"position %lu", (unsigned long)range.location);
        NSString *strImage=[description substringFromIndex:(range.location)];
        NSRange indexEnd = [strImage rangeOfString:@"\""];
        
        strImage=[strImage substringToIndex:indexEnd.location];
        NSLog(@"image %@", strImage);
        NSRange indexImgEnd=[description rangeOfString:@"/>"];
        NSString *strDescription=[description substringFromIndex:indexImgEnd.location+2];
        
        strDescription=[strDescription stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        NSLog(@"description %@", strDescription);
        
        
        /* if ([[tDict objectForKey:@"description"] isKindOfClass:[NSString class]]) {
         [dataDic setObject:[self escapeApostrophe:[tDict objectForKey:@"description"]] forKey:@"description"];
         }
         else {*/
        
        
        
        [dataDic setObject:strDescription forKey:@"description"];
        //}
        
        if ([[tDict objectForKey:@"link"] isKindOfClass:[NSString class]]) {
            [dataDic setObject:[self escapeApostrophe:[tDict objectForKey:@"link"]] forKey:@"link"];
        }
        else {
            [dataDic setObject:@"" forKey:@"link"];
        }
        
        [dataDic setObject:strImage forKey:@"image"];
        
        if ([[tDict objectForKey:@"pubDate"] isKindOfClass:[NSString class]]) {
            [dataDic setObject:[tDict objectForKey:@"pubDate"] forKey:@"pubDate"];
        }
        else {
            [dataDic setObject:@"" forKey:@"pubDate"];
        }
        
        //convert pubdate in seconds and set created on
        
        //   long *seconds=
        
        
        NSString *currentDateString = [tDict objectForKey:@"pubDate"];
        
        NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
        NSLog(@"seconds %@",currentDate);
        long longVal=[currentDate timeIntervalSince1970];
        NSString *seconds=[NSString stringWithFormat:@"%ld",longVal];
        // [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //NSString *dateStr = [dateFormatter stringFromDate:currentDate];
        [dataDic setObject:seconds forKey:@"CreatedOn"];
        
        
        if ([[tDict objectForKey:@"title"] isKindOfClass:[NSString class]]) {
            [dataDic setObject:[self escapeApostrophe:[tDict objectForKey:@"title"]] forKey:@"title"];
        }
        else {
            [dataDic setObject:@"" forKey:@"title"];
        }
        
        if ([[tDict objectForKey:@"type"] isKindOfClass:[NSString class]]) {
            [dataDic setObject:[tDict objectForKey:@"type"] forKey:@"type"];
        }
        else {
            [dataDic setObject:@"" forKey:@"type"];
        }
        
        [columnValues addObject:[NSString stringWithFormat:@"('%@')", [[dataDic allValues] componentsJoinedByString:@"', '"]]];
    }
    NSString *insertQry;
    if (columnValues.count>0) {
        insertQry = [NSString stringWithFormat:@"INSERT INTO News (%@) VALUES %@", [[dataDic allKeys] componentsJoinedByString:@", "], [columnValues componentsJoinedByString:@", "]];
        
        [[SQLiteDatabase sharedInstance] executeQuery:insertQry withParams:nil success:^(SQLiteResult *result) {
            NSLog(@"success: %@", insertQry);
            [self reloadNews];
        } failure:^(NSString *errorMessage) {
            
            NSLog(@"error : %@",errorMessage);
            NSLog(@"FAIL QRY : %@", insertQry);
        }];
    }else{
        [self reloadNews];
    }
    
    
}


- (NSString*)escapeApostrophe:(NSString*)value {
    return [value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

- (void)reloadNews {
    NSString *selectNewsQry = @"SELECT * FROM News order by CreatedOn DESC";
    [[SQLiteDatabase sharedInstance] executeQuery:selectNewsQry withParams:nil success:^(SQLiteResult *result) {
        
        NSLog(@"result : %@", result);
        newsList = result.rows;
        [newsTableView reloadData];
    } failure:^(NSString *errorMessage) {
        NSLog(@"Could not fetch rows , %@",errorMessage);
    }];
}

-(void)getApiUrl{
    NSString *selectNewsQry = @"SELECT * FROM News order by CreatedOn DESC";
    [[SQLiteDatabase sharedInstance] executeQuery:selectNewsQry withParams:nil success:^(SQLiteResult *result) {
        
        NSLog(@"result : %@", result);
        
        if(result.count>0){
            // NSMutableArray *tempArr=result.rows;
            SQLiteRow *object = result.rows[0];
            NSString *currentDateString=[NSString stringWithFormat:@"%@",[object stringForColumnName:@"pubDate"]];
            
            NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateStr = [formatter stringFromDate:currentDate];
            [formatter setDateFormat:@"HH-mm-ss"];
            NSString *timeStr = [formatter stringFromDate:currentDate];
            NSLog(@"CurrentDate:%@", currentDate);
            apiMethod = [NSString stringWithFormat:@"api/GetNews/%@/%@",dateStr,timeStr];
            
        } else {
            apiMethod = @"api/GetNews";
        }
        
        [self newsPage];
        
    } failure:^(NSString *errorMessage) {
        NSLog(@"Could not fetch rows , %@",errorMessage);
    }];
}

#pragma mark - FirebaseAdBanner
- (void)bannerAd {
    adBannerView.adUnitID = BannerAdUnitID;
    //    _adView.rootViewController = self;
    //    adBannerView.adSizeDelegate = self;
    [adBannerView loadRequest:[GADRequest request]];
    [[GADRequest request] setGender:kGADGenderMale];
    [[GADRequest request] setBirthday:[NSDate date]];
    // [END firebase_banner_example]
}

#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    CGFloat height = CGRectGetHeight(adBannerView.frame);
    [self.view bringSubviewToFront:adBannerView];
    [adBannerView setFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height)];
    
    adBannerView.hidden = NO;
    
    //    self.viewForEMC.frame = CGRectMake(0, 135,SCREEN_WIDTH, SCREEN_HEIGHT-135-height);
    newsTableView.frame = CGRectMake(CGRectGetMinX(newsTableView.frame), CGRectGetMinY(newsTableView.frame), CGRectGetWidth(newsTableView.frame), CGRectGetHeight(newsTableView.frame)-height);
    NSLog(@"adViewDidReceiveAd");
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    //    CGFloat height = CGRectGetHeight(adBannerView.frame);
    adBannerView.hidden = YES;
    newsTableView.frame= CGRectMake(CGRectGetMinX(newsTableView.frame), CGRectGetMinY(newsTableView.frame), CGRectGetWidth(newsTableView.frame), SCREEN_HEIGHT-CGRectGetMinY(newsTableView.frame));
    NSLog(@"didFailToReceiveAdWithError");
}
- (void)adViewWillPresentScreen:(GADBannerView *)bannerView {
    NSLog(@"adViewWillPresentScreen");
}
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView {
    NSLog(@"adViewWillDismissScreen");
}
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView {
    NSLog(@"adViewDidDismissScreen");
}
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView {
    NSLog(@"adViewWillLeaveApplication");
}

#pragma mark - GADInAppPurchaseDelegate
- (void)didReceiveInAppPurchase:(GADInAppPurchase *)purchase {
    NSLog(@"didReceiveInAppPurchase");
}

#pragma mark - GADAdSizeDelegate
- (void)adView:(GADBannerView *)bannerView willChangeAdSizeTo:(GADAdSize)size {
    NSLog(@"willChangeAdSizeTo");
}
@end
