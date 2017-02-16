//
//  webManager.m
//  MarketOfMums
//
//  Created by IsoDev1 on 10/28/15.
//  Copyright © 2015 Neha. All rights reserved.
//

#import "webManager.h"
#import "NetworkManager.h"
#import "Driver_Model.h"

@implementation webManager

+(webManager*)sharedObject
{
    static webManager *objWeb = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objWeb = [[webManager alloc] init];
    });
    return objWeb;
    
}
-(void)loginRequest:(NSDictionary *)parameters withMethod:(NSString *)method successResponce:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [NetworkManager sendWebRequest:parameters withMethod:method successResponce:^(id response)
    {
        [DRIVER_DETAILS initWithData:response];
         success(response);
        
    }
    failure:^(NSError *error)
    {
        failure(error);
    }];
}


//swati post
-(void)CallPostMethod:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    [NetworkManager PostMethod:parameters withMethod:method
               successResponce:^(id response)
     {
         [DRIVER_DETAILS initWithData:response];
         success(response);
         
     }
   failure:^(NSError *error)
     {
         failure(error);
     }];
}

//swati put
-(void)CallPutMethodwithParameters:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    [NetworkManager PutMethodWithParameters:parameters withMethod:method successResponce:^(id response)
    {
        [DRIVER_DETAILS initWithData:response];
        success(response);
    }
    failure:^(NSError *error)
    {
        failure(error);
    }];
}

-(void)OrderRequest:(NSDictionary *)parameters withMethod:(NSString *)method successResponse:(void (^)(id response))success failure:(void (^)(NSError *error))failure
{
    [NetworkManager sendWebRequest:parameters withMethod:method successResponce:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)signUp:(NSDictionary*)Parameters andMethod:(NSString*)methodName successResponce:(void (^)(id Responce))success failure:(void (^)(NSError *error))failure
{
    [NetworkManager signUp:Parameters withMethod:methodName successResponce:^(id response)
     {
        NSLog(@"%@",response);
         success(response);
    }
    failure:^(NSError *error)
    {
        failure(error);
        NSLog(@"%@",error.localizedDescription);
    }];
}


//for sending multiple images
-(void)UploadMultipleImagesWithParam:(NSDictionary *)parameters withArr:(NSMutableArray *)ProductImgArr andMethod :(NSString *)methodName successResponce:(void (^)(id Responce))success failure:(void (^)(NSError *error))failure
{
    [NetworkManager uploadProductImages:parameters withMethod:methodName WithImageArr:ProductImgArr successResponce:^(id response)
     {
         success(response);
         // NSLog(@"%@",response);
     } failure:^(NSError *error)
     {
         failure(error);
         // NSLog(@"%@",error.localizedDescription);
     }];
}

@end
