//
//  MarketViewController.m
//  MarketMastro
//
//  Created by Harish Patra on 26/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import "MarketViewController.h"

#import "MarketTableViewCell.h"
#import "cltMarketCell.h"

@interface MarketViewController ()<UITableViewDelegate, UITableViewDataSource>
{    
    __weak IBOutlet UITableView *tableViewMarket;
    
    NSMutableArray *arrMarketData, *arrCategoryLabels, *arrCategoryIds;
    
    UIColor *rateDownColor, *rateUpColor;
}

@end

@implementation MarketViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    
    tableViewMarket.backgroundColor = [UIColor colorwithHexString:@"#16191B"];
    self.view.backgroundColor = [UIColor colorwithHexString:@"#16191B"];
    
    rateDownColor = [UIColor colorwithHexString:@"#15558C"];
    rateUpColor = [UIColor colorwithHexString:@"#BA1E1A"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    tableViewMarket.hidden = true;
    self.cltView.hidden = true;
    
    if ([AppDelegate sharedAppDelegate].isListClicked == true)
    {
        tableViewMarket.hidden = false;
    }
    else
    {
        self.cltView.hidden = false;
    }
    
    NSLog(@"Appear");
    
    arrMarketData = [[NSMutableArray alloc] init];
    
    [self connectToDB];
    
    if([self.title isEqualToString:@"ProfolioList"]){
        NSString *query1 =[NSString stringWithFormat:@"SELECT * from UserPortfolio"];
        
        [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result)
        {
            arrMarketData = result.rows;
            
            if ([AppDelegate sharedAppDelegate].isListClicked == true)
            {
                [tableViewMarket reloadData];
            }
            else
            {
                [self.cltView reloadData];
            }

        } failure:^(NSString *errorMessage) {
            NSLog(@"Could not fetch rows , %@",errorMessage);
        }];
        NSLog(@"Query %@ ",query1);
    }else{
        
        NSMutableArray *arrOfTypes =  [[NSUserDefaults standardUserDefaults] valueForKey:@"commodity_types"];
        
        
        for (int i =0; i<arrOfTypes.count; i++)
        {
            NSDictionary *dic = [arrOfTypes objectAtIndex:i];
            NSString *groupID=[dic valueForKey:@"GroupID"];
            NSString *groupName=[dic valueForKey:@"GroupName"];
            if([self.title isEqualToString:groupName]) {
                // select query
                NSString *query1 =[NSString stringWithFormat:@"SELECT * from Commodity where isPopular=1 AND CommodityType=%@ order by SortOrder",groupID];
                
                [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result) {
                    arrMarketData = result.rows;
                    if ([AppDelegate sharedAppDelegate].isListClicked == true)
                    {
                        [tableViewMarket reloadData];
                    }
                    else
                    {
                        [self.cltView reloadData];
                    }

                } failure:^(NSString *errorMessage) {
                    NSLog(@"Could not fetch rows , %@",errorMessage);
                }];
                NSLog(@"Query %@ ",query1);
                break;
            }
        }
    }
    
    //[tableViewMarket reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//DB connection
-(void) connectToDB{
    [[SQLiteDatabase databaseWithFileName:@"LKSDB"] setAsSharedInstance];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *sqliteDB = [documentsDirectory stringByAppendingPathComponent:@"LKSDB.db"];
    NSLog(@"File location %@",sqliteDB);
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)reloadTableData {
    [tableViewMarket reloadData];
}

#pragma mark - UICollectionView Delegate and DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrMarketData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"market";
    
    cltMarketCell *cell = [self.cltView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if([self.title isEqualToString:@"Bullion"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Expected MCX"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Costing & Difference"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Base metals"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Energy"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Local Spot"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"International Markets"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"ProfolioEditable"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Expected MCX"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Costing & Difference"]) {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }else if([self.title isEqualToString:@"ProfolioList"]){
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }
    //HP Temp Condition(Remove After Every Thing Done)
    else
    {
        cell = [self shareCellDesignCollectionView:collectionView indexPath:indexPath];
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/3.3, 90);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return -2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (cltMarketCell*)shareCellDesignCollectionView:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath
{
    cltMarketCell *mCell;
    
    mCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"market" forIndexPath:indexPath];
    
    if (indexPath.row == 1)
    {
        [self colorUpForView:mCell.lblLastPrice];
    }
    
    SQLiteRow *object = arrMarketData[indexPath.row];
    
    NSString *strName = [object stringForColumnName:@"Name"];
    
    mCell.lblName.text = [[strName componentsSeparatedByString:@" "] objectAtIndex:0];
    
    NSArray *arrData = [strName componentsSeparatedByString:@" "];
    
    if ([arrData count] > 3)
    {
        mCell.lblDate.text = [NSString stringWithFormat:@"%@ %@ %@",[[strName componentsSeparatedByString:@" "] objectAtIndex:1],[[strName componentsSeparatedByString:@" "] objectAtIndex:2],[[strName componentsSeparatedByString:@" "] objectAtIndex:3]];
    }
    else
    {
        mCell.lblDate.text = @"--";
    }
    
    mCell.lblLastPrice.text = @"21217.89";
    
    if (indexPath.row%2==0)
    {
        mCell.lblLastLowHigh.text = @"-361.01(-1.25%)";
        mCell.lblLastLowHigh.textColor = [UIColor colorwithHexString:@"#F73F2B"];
        [self rateDownSetColor:mCell.viewBG];
        [self rateDownCurve:mCell.viewBG];
    }
    else
    {
        mCell.lblLastLowHigh.textColor = [UIColor colorWithRed:41/255.0f green:84/255.0f blue:134/255.0f alpha:1.0f];
        
        mCell.lblLastLowHigh.text = @"365.01(1.25%)";
        [self rateUpSetColor:mCell.viewBG];
        [self rateUpCurve:mCell.viewBG];
    }

    return mCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row selected");
    
    MarketDetailsVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MarketDetailsVC"];
    [_object.navigationController pushViewController:detail animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrMarketData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    
    if([self.title isEqualToString:@"Bullion"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Expected MCX"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Costing & Difference"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Base metals"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Energy"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Local Spot"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"International Markets"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"ProfolioEditable"]) {
        cell = [self shareCellEditableDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Expected MCX"]) {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    else if ([self.title isEqualToString:@"Costing & Difference"]) {
        cell = [self shareCellEditableDesignTableView:tableView indexPath:indexPath];
    }else if([self.title isEqualToString:@"ProfolioList"]){
        cell = [self shareCellEditableDesignTableView:tableView indexPath:indexPath];
    }
    //HP Temp Condition(Remove After Every Thing Done)
    else
    {
        cell = [self shareCellDesignTableView:tableView indexPath:indexPath];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row selected");
    
    MarketDetailsVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MarketDetailsVC"];
    [_object.navigationController pushViewController:detail animated:YES];
}

/*
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 return 10;
 }
 - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
 return 10;
 }
 */

- (UITableViewCell*)shareCellDesignTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath
{
    MarketTableViewCell *mCell;
    mCell = [tableView dequeueReusableCellWithIdentifier:@"MarketCellID" forIndexPath:indexPath];
    mCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Temp
    if (indexPath.row == 1)
    {
        [self colorUpForView:mCell.lblLiveRate];
    }
    
    //Data Fitting
    /* [mCell.lblName_Date setAttributedText:[self productName:@"SILVER" productDate:@"27 Feb 2017"]];
     [mCell.lblStartEndRate setAttributedText:[self rateStart:@"41207.00" rateEnd:@"41215.00"]];
     [mCell.btnOTime_Delete setTitle:@"19:18:17" forState:UIControlStateNormal]; */
    
    
    [mCell.lblStartEndRate setAttributedText:[self rateStart:@"41207.00" rateEnd:@"41215.00"]];
    [mCell.btnOTime_Delete setTitle:@"19:18:17" forState:UIControlStateNormal];
    
    SQLiteRow *object = arrMarketData[indexPath.row];
    mCell.lblName_Date.text = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"Name"]];
    
    if (indexPath.row%2==0)
    {
        [self rateDownSetColor:mCell.viewBG];
        [self rateDownCurve:mCell.viewBG];
    }
    else
    {
        [self rateUpSetColor:mCell.viewBG];
        [self rateUpCurve:mCell.viewBG];
    }
    
    [mCell.btnOTime_Delete.titleLabel setTextAlignment:NSTextAlignmentRight];
    return mCell;
}

- (UITableViewCell*)shareCellEditableDesignTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    MarketTableViewCell *mCell;
    mCell = [tableView dequeueReusableCellWithIdentifier:@"MarketCellID" forIndexPath:indexPath];
    mCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Temp
    if (indexPath.row == 1) {
        [self colorUpForView:mCell.lblLiveRate];
    }
    
    SQLiteRow *object = arrMarketData[indexPath.row];
    mCell.lblName_Date.text = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"Name"]];
    
    //Data Fitting
    // [mCell.lblName_Date setAttributedText:[self productName:@"SILVER" productDate:@"27 Feb 2017"]];
    [mCell.lblStartEndRate setAttributedText:[self rateStart:@"41207.00" rateEnd:@"41215.00"]];
    [mCell.btnOTime_Delete setTitle:@"19:18:17" forState:UIControlStateNormal];
    
    if (indexPath.row%2==0) {
        [self rateDownSetColor:mCell.viewBG];
        [self rateDownCurve:mCell.viewBG];
    }
    else {
        [self rateUpSetColor:mCell.viewBG];
        [self rateUpCurve:mCell.viewBG];
    }
    [mCell.btnOTime_Delete setEnabled:YES];
    [mCell.btnOTime_Delete setTag:indexPath.row];
    [mCell.btnOTime_Delete setTitle:@"X" forState:UIControlStateNormal];
    [mCell.btnOTime_Delete.titleLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:12.0f]];
    [mCell.btnOTime_Delete.titleLabel setTextAlignment:NSTextAlignmentRight];
    [mCell.btnOTime_Delete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
    
    return mCell;
}

- (NSAttributedString*)productName:(NSString*)pName productDate:(id)pDate {
    NSString *tFString;
    NSString *tPDate;
    if ([pDate isKindOfClass:[NSString class]]) {
        tPDate = pDate;
    }
    else {
        tPDate = @"27 Feb 2017";
    }
    tFString = [pName stringByAppendingFormat:@"  %@", tPDate];
    NSRange nRange = [tFString rangeOfString:pName];
    NSRange dRange = [tFString rangeOfString:tPDate];
    
    NSMutableAttributedString *tFAttString = [[NSMutableAttributedString alloc] initWithString:tFString];
    [tFAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ffffff"] range:nRange];
    [tFAttString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Lato-Regular" size:10.0] range:nRange];
    
    NSDictionary *tDic = @{NSForegroundColorAttributeName: [UIColor colorwithHexString:@"#959595"], NSFontAttributeName: [UIFont fontWithName:@"Lato-Regular" size:8.0]};
    [tFAttString addAttributes:tDic range:dRange];
    
    return tFAttString;
}

- (NSAttributedString*)rateStart:(NSString*)rStart rateEnd:(NSString*)rEnd {
    NSString *tFString = [rStart stringByAppendingFormat:@" - %@", rEnd];
    NSRange sRange = [tFString rangeOfString:rStart];
    NSRange dashRang = [tFString rangeOfString:@" - "];
    NSRange eRange = [tFString rangeOfString:rEnd];
    
    NSMutableAttributedString *tFAttString = [[NSMutableAttributedString alloc] initWithString:tFString];
    [tFAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ffffff"] range:sRange];
    [tFAttString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Lato-Regular" size:13.0] range:sRange];
    
    [tFAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ffffff"] range:dashRang];
    [tFAttString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Lato-Bold" size:12.0] range:dashRang];
    
    NSDictionary *tDic = @{NSForegroundColorAttributeName: [UIColor colorwithHexString:@"#ffffff"], NSFontAttributeName: [UIFont fontWithName:@"Lato-Regular" size:13.0]};
    [tFAttString addAttributes:tDic range:eRange];
    
    return tFAttString;
}

- (void)btnDelete:(UIButton*)sender
{
    SQLiteRow *object = arrMarketData[sender.tag];
    NSString *str = [NSString stringWithFormat:@"%@",[object stringForColumnName:@"CommodityID"]];
    
    NSString *query1 =[NSString stringWithFormat:@"delete from UserPortfolio where CommodityID=%@",str];
    
    [[SQLiteDatabase sharedInstance] executeQuery:query1 withParams:nil success:^(SQLiteResult *result) {
        
        NSLog(@"deleted %@",str);
        
    } failure:^(NSString *errorMessage) {
        NSLog(@"Could not fetch rows , %@",errorMessage);
    }];
    
    [arrMarketData removeObjectAtIndex:sender.tag];
    
    [self reloadTableData];
}

- (void)colorUpForView:(UIView*)idView {
    [UIView animateWithDuration:0 animations:^{
        [idView setBackgroundColor:rateDownColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0 animations:^{
            [idView setBackgroundColor:[UIColor clearColor]];
        } completion:^(BOOL finished) {
            [self colorDownForView:idView];
        }];
    }];
}

- (void)colorDownForView:(UIView*)idView {
    [UIView animateWithDuration:0 animations:^{
        [idView setBackgroundColor:rateUpColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0 animations:^{
            [idView setBackgroundColor:[UIColor clearColor]];
        } completion:^(BOOL finished) {
            [self colorUpForView:idView];
        }];
    }];
}

#pragma mark - UpDownRateColor
- (void)rateUpSetColor:(UIView*)bgView {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *newBezier = [UIBezierPath bezierPath];
    
    [newBezier moveToPoint:CGPointMake(0, 15)];//(3*tempBtn.frame.size.height)/4
    [newBezier addLineToPoint:CGPointMake(0, 0)];
    [newBezier addLineToPoint:CGPointMake(15, 0)];
    [newBezier addQuadCurveToPoint:CGPointMake(0, 15) controlPoint:CGPointMake(3, 3)];
    [newBezier closePath];
    
    shapeLayer.path = newBezier.CGPath;
    shapeLayer.fillColor = [UIColor colorWithRed:41/255.0f green:84/255.0f blue:134/255.0f alpha:1.0f].CGColor;
    shapeLayer.fillRule = kCAFillRuleNonZero;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.lineJoin = kCALineJoinMiter;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = rateUpColor.CGColor;
    if ([[bgView.layer.sublayers lastObject] isKindOfClass:[CAShapeLayer class]]) {
        [bgView.layer replaceSublayer:[bgView.layer.sublayers lastObject] with:shapeLayer];
    }
    else {
        [bgView.layer addSublayer:shapeLayer];
    }
}
- (void)rateUpCurve:(UIView*)bgView {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:(UIRectCornerTopLeft) cornerRadii:CGSizeMake(3.0, 3.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgView.bounds;
    maskLayer.path  = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
}

- (void)rateDownSetColor:(UIView*)bgView {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *newBezier = [UIBezierPath bezierPath];
    
    [newBezier moveToPoint:CGPointMake(0, CGRectGetHeight(bgView.bounds)-15)];//(3*tempBtn.frame.size.height)/4
    [newBezier addLineToPoint:CGPointMake(0, bgView.bounds.size.height)];
    [newBezier addLineToPoint:CGPointMake(15, CGRectGetHeight(bgView.bounds))];
    [newBezier addQuadCurveToPoint:CGPointMake(0, CGRectGetHeight(bgView.bounds)-15) controlPoint:CGPointMake(3, bgView.bounds.size.height-3)];
    [newBezier closePath];
    
    shapeLayer.path = newBezier.CGPath;
    shapeLayer.fillColor = [UIColor colorwithHexString:@"#F73F2B"].CGColor;
    shapeLayer.fillRule = kCAFillRuleNonZero;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.lineJoin = kCALineJoinMiter;
    shapeLayer.lineWidth = 0.0;
    shapeLayer.strokeColor = rateDownColor.CGColor;
    if ([[bgView.layer.sublayers lastObject] isKindOfClass:[CAShapeLayer class]]) {
        [bgView.layer replaceSublayer:[bgView.layer.sublayers lastObject] with:shapeLayer];
    }
    else {
        [bgView.layer addSublayer:shapeLayer];
    }
}
- (void)rateDownCurve:(UIView*)bgView {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:(UIRectCornerBottomLeft) cornerRadii:CGSizeMake(3.0, 3.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgView.bounds;
    maskLayer.path  = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
}


@end
