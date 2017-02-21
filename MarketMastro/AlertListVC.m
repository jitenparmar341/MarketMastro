//
//  AlertListVC.m
//  MarketMastro
//
//  Created by Kanhaiya on 24/11/16.
//  Copyright © 2016 Macmittal software. All rights reserved.
//

#import "AlertListVC.h"

@interface AlertListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *menuItems;
    NSMutableArray *ArrayAlertHistory;
}
@end

@implementation AlertListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Alerts";
    menuItems = @[@"market"];
    
    /*
     [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     */
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    ArrayAlertHistory = [[NSMutableArray alloc] init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self MethodGetAlertHistory];
}


-(void)MethodGetAlertHistory
{
    //get alert history
    NSString *query1 = @"SELECT * from Alert where isExecuted=0";
    NSLog(@"Query %@ ",query1);
    
    [[MethodsManager sharedManager]loadingView:self.view];
    [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"select all rows from database = %@",result);
         ArrayAlertHistory = result.rows;
         NSLog(@"Array of history  = %@",ArrayAlertHistory);
         
         if(ArrayAlertHistory.count>0){
             [_TableAlertHistory reloadData];
         }
         //SQLiteRow *object = [ArrayGetAlertFromDB objectAtIndex:0];
         //NSString *strName  = [NSString stringWithFormat:@"AlertID - %@",[object stringForColumnName:@"AlertID"]];
         //NSLog(@"alert ID = %@",strName);
     }
                                          failure:^(NSString *errorMessage)
     {
         [[MethodsManager sharedManager]StopAnimating];
         NSLog(@"Could not fetch rows , %@",errorMessage);
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return ArrayAlertHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     NSString *CellIdentifier = @"HistoryCell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
     cell.backgroundColor = [UIColor clearColor];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.backgroundColor = [UIColor clearColor];
     */
    static NSString *MyIdentifier = @"HistoryCell";
    CurrentAlertListCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[CurrentAlertListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:MyIdentifier] ;
    }
    
    SQLiteRow *object = [ArrayAlertHistory objectAtIndex:indexPath.row];
    NSString *strText = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"Text"]];
    //remove html tags from strhistorytext
    strText = [self removeHtmlTags:strText];
    cell.lblCommodityAlert.text = strText;
    NSString *dateString = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"CreatedDateTime"]];
    cell.lbldate.text = dateString;
    //set date >>alertedDateTime >>
    return cell;
    
}

-(NSString*)removeHtmlTags:(NSString*)historyText
{
    
    NSString *html = historyText;
    NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                          NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)}
                                                     documentAttributes:nil
                                                                  error:nil];
    NSLog(@"html: %@", html);
    NSLog(@"attr: %@", attr);
    NSLog(@"string: %@", [attr string]);
    historyText = [attr string];
    
    
    NSString *str1 = historyText;
    NSRange range = [str1 rangeOfString:@":"];
    if (range.location != NSNotFound) {
        NSString *newString = [str1 substringToIndex:range.location];
        NSLog(@"%@",newString);
        historyText = newString;
        
    } else {
        NSLog(@": is not found");
    }
    return historyText;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
