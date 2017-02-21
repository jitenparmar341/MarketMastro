//
//  NetworkManager.m
//  MarketOfMums
//
//  Created by IsoDev1 on 10/27/15.
//  Copyright © 2015 Neha. All rights reserved.
//

#import "NetworkManager.h"
#import <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
//#define Main_URL @"http://dev33.myedreamz.com/api_driver/"

#define Main_URL @"http://52.55.5.74:50032/"
//http://52.55.5.74:50032/
@implementation NetworkManager


+(BOOL)connectedToNetwork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        return 0;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+(void)sendWebRequest:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *iOSVersion =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"SavedIosVersion"]];
    
    NSString *UUID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"SavedUUID"]];
    
    NSString *strTokenId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"TokenID"]];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:strTokenId forHTTPHeaderField:@"Token"];
    [manager.requestSerializer setValue:iOSVersion forHTTPHeaderField:@"AppVer"];
    [manager.requestSerializer setValue:UUID forHTTPHeaderField:@"UUID"];
    [manager.requestSerializer setValue:iOSVersion forHTTPHeaderField:@"DeviceOS"];
    
    NSLog(@"%@%@",Main_URL,method);
    NSLog(@"Param = %@",parameters);
    
    [manager GET:[NSString stringWithFormat:@"%@%@",Main_URL,method] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error=nil;
         NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         success(dataDic);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSString* str = operation.responseString;
         NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
         
         NSLog(@"Error information :: %@",dataDic);
         
         NSString* strError = [dataDic objectForKey:@"Error"];
         
//                  [[[UIAlertView alloc] initWithTitle:@"Error"
//                                              message:strError
//                                             delegate:nil
//                                    cancelButtonTitle:nil
//                                    otherButtonTitles:@"Ok", nil] show];
         NSError *tLError;
         if ([[dataDic objectForKey:@"ErrorCode"] isEqual:@"602"]) {
             tLError = [[NSError alloc] initWithDomain:error.domain code:[[dataDic objectForKey:@"ErrorCode"] integerValue] userInfo:@{NSLocalizedDescriptionKey: strError}];
             NSLog(@"tLError : %@", tLError);
             failure(tLError);
         }
         else
             failure(error);
     }];
}

//swati post method
+(void)PostMethod:(NSDictionary *)parameters withMethod:(NSString *)method successResponce:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *iOSVersion =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"SavedIosVersion"]];
    
    NSString *UUID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"SavedUUID"]];
    
    NSString *strTokenId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"TokenID"]];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:strTokenId forHTTPHeaderField:@"Token"];
    [manager.requestSerializer setValue:iOSVersion forHTTPHeaderField:@"AppVer"];
    [manager.requestSerializer setValue:UUID forHTTPHeaderField:@"UUID"];
    [manager.requestSerializer setValue:iOSVersion forHTTPHeaderField:@"DeviceOS"];
    
    NSLog(@"%@%@",Main_URL,method);
    NSLog(@"Param = %@",parameters);
    
    [manager POST:[NSString stringWithFormat:@"%@%@",Main_URL,method] parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         //  NSError *error=nil;
         // NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSData *responseData = responseObject;
         // NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:&error];
         // nsdict *dataDic = [[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error] mutableCopy];
         success(responseData);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         NSLog(@"operation.responseString = %@ \n %@",operation.responseString,[error description]);
         
         NSString* str = operation.responseString;
         NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
         
         NSLog(@"Error information :: %@",dataDic);
         
         NSString* strError = [dataDic objectForKey:@"Error"];
         
         [[[UIAlertView alloc] initWithTitle:@"Error"
                                     message:strError
                                    delegate:nil
                           cancelButtonTitle:nil
                           otherButtonTitles:@"Ok", nil] show];
         failure(error);
     }];
}

//swati.. call put method
+(void)PutMethodWithParameters:(NSDictionary *)parameters withMethod:(NSString *)method successResponce:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *iOSVersion =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"SavedIosVersion"]];
    
    NSString *UUID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"SavedUUID"]];
    
    NSString *strTokenId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"TokenID"]];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:strTokenId forHTTPHeaderField:@"Token"];
    [manager.requestSerializer setValue:iOSVersion forHTTPHeaderField:@"AppVer"];
    [manager.requestSerializer setValue:UUID forHTTPHeaderField:@"UUID"];
    [manager.requestSerializer setValue:iOSVersion forHTTPHeaderField:@"DeviceOS"];
    
    NSLog(@"%@%@",Main_URL,method);
    NSLog(@"Param = %@",parameters);
    
    [manager PUT:[NSString stringWithFormat:@"%@%@",Main_URL,method] parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         NSData *responseData = responseObject;
         success(responseData);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         NSLog(@"operation.responseString = %@ \n %@",operation.responseString,[error description]);
         
         NSString* str = operation.responseString;
         NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
         
         NSLog(@"Error information :: %@",dataDic);
         
         NSString* strError = [dataDic objectForKey:@"Error"];
         [[[UIAlertView alloc] initWithTitle:@"Error"
                                     message:strError
                                    delegate:nil
                           cancelButtonTitle:nil
                           otherButtonTitles:@"Ok", nil] show];
         failure(error);
     }];
    
}


+(void)signUp:(NSDictionary *)parameters withMethod:(NSString *)method successResponce:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *str=[NSString stringWithFormat:@"%@%@",Main_URL,method];
    
    NSLog(@"String = %@",str);
    NSLog(@"Parameter = %@",parameters);
    
    
    [manager GET:[NSString stringWithFormat:@"%@%@",Main_URL,method] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error=nil;
         NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         success(dataDic);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[[UIAlertView alloc] initWithTitle:error.localizedDescription
                                     message:error.localizedRecoverySuggestion
                                    delegate:nil
                           cancelButtonTitle:NSLocalizedString(@"OK", nil)
                           otherButtonTitles:nil, nil] show];
         
         failure(error);
         
     }];
    
}
//
//+(void)uploadImage:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure
//{
////    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
////    [manager POST:[NSString stringWithFormat:@"%@%@",Main_URL,method] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
////        [formData appendPartWithFileURL:filePath name:name error:nil];
////    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        NSLog(@"Success: %@", responseObject);
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
////    {
////        NSLog(@"Error: %@", error);
////    }];
//    NSString *fileName = [NSString stringWithFormat:@"%ld%c%c.jpg", (long)[[NSDate date] timeIntervalSince1970], arc4random_uniform(26) + 'a', arc4random_uniform(26) + 'a'];
//    // NSLog(@"FileName == %@", fileName);
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//
//
//    // BASIC AUTH (if you need):
////    manager.securityPolicy.allowInvalidCertificates = YES;
////    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
////    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"foo" password:@"bar"];
//    // BASIC AUTH END
//
//
//    /// !!! only jpg, have to cover png as well
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5); // image size ca. 50 KB
//    [manager POST:[NSString stringWithFormat:@"%@%@",Main_URL,method] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData name:@"image" fileName:fileName mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//        NSLog(@"Success %@", responseObject);
//         success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failure %@, %@", error, operation.responseString);
//        failure(error);
//    }];
//
//}

+(void)uploadProductImages:(NSDictionary*)parameters withMethod:(NSString*)method WithImageArr:(NSMutableArray*)imageArr successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSLog(@"%@%@",Main_URL,method);
    NSLog(@"%@",parameters);
    [manager POST:[NSString stringWithFormat:@"%@%@",Main_URL,method] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         for (int i=0; i<imageArr.count; i++)
         {
             NSString *fileName = [NSString stringWithFormat:@"%ld%c%c.jpg", (long)[[NSDate date] timeIntervalSince1970], arc4random_uniform(26) + 'a', arc4random_uniform(26) + 'a'];
             UIImage *img;
             img=[imageArr objectAtIndex:i];
             
             NSData *imageData = UIImageJPEGRepresentation(img, 0); // image size ca. 50 KB
             
             [formData appendPartWithFileData:imageData name:@"files[]" fileName:fileName mimeType:@"image/jpeg"];
         }
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Success %@", responseObject);
         success(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Failure %@, %@", error, operation.responseString);
         failure(error);
     }];
}

@end
