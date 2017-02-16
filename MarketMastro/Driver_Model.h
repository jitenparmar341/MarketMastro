//
//  Driver_Model.h
//  AsiavanDriver
//
//  Created by IsoDev1 on 11/2/15.
//  Copyright © 2015 edreamz. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DRIVER_DETAILS ([Driver_Model sharedObject])

@interface Driver_Model : NSObject

+(Driver_Model*)sharedObject;
-(void)initWithData:(NSDictionary*)dict;
@property (nonatomic,strong)NSDictionary *driver_details_dict;
@end
