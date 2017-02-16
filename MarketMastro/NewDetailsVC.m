//
//  NewDetailsVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 27/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "NewDetailsVC.h"

@interface NewDetailsVC ()

@end

@implementation NewDetailsVC
@synthesize news;

- (void)viewDidLoad {
    self.title = @"News";
    [super viewDidLoad];
    
    NSString *title=[NSString stringWithFormat:@"%@",[news stringForColumnName:@"title"]];
    self.lblLastUpdate.hidden=YES;
    self.lblOfTitle.text = title;
   // self.imgVIew.image = _imageLoad;
    NSString *currentDateString=[NSString stringWithFormat:@"%@",[news stringForColumnName:@"pubDate"]];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    NSDate *currentDate = [formatter dateFromString:currentDateString];
   
    [formatter setDateFormat:@"EEE dd MMM, yyyy hh:mm a"];
    NSString *dateStr = [formatter stringFromDate:currentDate];
    self.lblDateTime.text=dateStr;
    self.lblDesc.text=[NSString stringWithFormat:@"%@",[news stringForColumnName:@"description"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[news stringForColumnName:@"image"]]];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                        self.imgVIew.image  = image;
                });
            }
        }
    }];
    [task resume];
    
    NSLog(@"SELECTED VALUES  %@%@",currentDateString,title);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
