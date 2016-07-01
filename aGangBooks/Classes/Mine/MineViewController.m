//
//  MineViewController.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/11.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "MineViewController.h"
#import "GDataXMLNode.h"
//#import <ContactsUI/ContactsUI.h>


@interface MineViewController ()

//<CNContactPickerDelegate>
//@property (nonatomic , strong) CNContactPickerViewController *contactPicker;
//

@property(nonatomic,strong)UIImageView *imageV;
@end

@implementation MineViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"个人中心";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.imageV = [[UIImageView alloc]init];
    _imageV.frame = CGRectMake(30, 30, 100, 100);
    
    self.imageV.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_imageV];
    
//    //创建CNContactStore对象,用与获取和保存通讯录信息
//    CNContactStore *contactStore = [[CNContactStore alloc] init];
//    
//    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
//        //首次访问通讯录会调用
//        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
//            if (error) return;
//            if (granted) {//允许
//                NSLog(@"授权访问通讯录");
//                [self fetchContactWithContactStore:contactStore];//访问通讯录
//            }else{//拒绝
//                NSLog(@"拒绝访问通讯录");//访问通讯录
//            }
//        }];
//    }
//    else if([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
//        
//        NSError *error = nil;
//        
//        //创建数组,必须遵守CNKeyDescriptor协议,放入相应的字符串常量来获取对应的联系人信息
//        NSArray <id<CNKeyDescriptor>> *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey];
//        //创建获取联系人的请求
//        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
//        //遍历查询
//        [contactStore enumerateContactsWithFetchRequest:fetchRequest error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
//            if (!error) {
//                NSLog(@"familyName = %@", contact.familyName);//姓
//                NSLog(@"givenName = %@", contact.givenName);//名字
//                NSLog(@"phoneNumber = %@", ((CNPhoneNumber *)(contact.phoneNumbers.lastObject.value)).stringValue);//电话
//                
//            }
//            else{
//                NSLog(@"error:%@", error.localizedDescription);
//            }
//        }];
//        
//        //调用通讯录
//        [self presentViewController:self.contactPicker  animated:YES completion:nil];
//    }
//    
//    else{
//        //无权限访问
//        NSLog(@"拒绝访问通讯录");  
//    }

    [self uploadImageAction];
    
}

-(void)uploadImageAction {
//    NSString *url = @"http://www.wngn123.com/wngn-resource/upload/upload_form";
    NSString *url = @"http://192.168.0.100:8080/wngn-resource/upload/upload_form_extend";

    NSMutableDictionary *dpp =[@{@"token":@"zhaoshenshenazhao"} mutableCopy];
    NSMutableArray *pimgs= [@[[UIImage imageNamed:@"image.png"],[UIImage imageNamed:@"one.png"]] mutableCopy];
//    [self uploadImageWithUrl:url dataParams:dpp imageParams:pimgs Success:^(NSDictionary *resultDic) {
//        NSLog(@"%@", resultDic);
//    } Failed:^(NSError *error) {
//    }];
    
    [MineViewController uploadImageWithUrl:url dataParams:nil imageParams:pimgs Success:^(NSData *resultDic) {
        NSLog(@"resultDict:%@",resultDic);
        
        
        UIImage *image = [UIImage imageWithData:resultDic];
        
        self.imageV.image = image;
        
    } Failed:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

+(void)uploadImageWithUrl:(NSString *)strUrl dataParams:(nullable NSMutableDictionary *)dataParams imageParams:(NSMutableArray *)imageParams Success:(void(^)(NSData *resultDic)) success Failed:(void(^)(NSError *error))fail {
//    NSArray *keys = [imageParams allKeys];
//    UIImage * image = [imageParams objectForKey:[keys firstObject]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];//对SSL做处理，防止上传失败
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"application/json"];


    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 120;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:strUrl parameters:dataParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        
        for (int i = 0; i < imageParams.count; i++) {
            
            UIImage *image = imageParams[i];
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"icon%d:%@.png", i,str];
            NSString *formKey =[NSString stringWithFormat:@"image%d%@",i,str];
            

            
            
            [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:formKey fileName:fileName mimeType:@"image/png"];

            
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            
            success(responseObject);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"dict:%@",dict);
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

//#pragma  mark 访问通讯录
//- (void)fetchContactWithContactStore:(CNContactStore *)contactStore{
//    
//    //调用通讯录
//    self.contactPicker.displayedPropertyKeys =@[CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey];
//    [self presentViewController:self.contactPicker  animated:YES completion:nil];
//    
//}
//
//#pragma mark 选择联系人进入详情
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        CNContactViewController *vc = [CNContactViewController viewControllerForContact:contact];
//        vc.displayedPropertyKeys =@[CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactFamilyNameKey,CNContactInstantMessageAddressesKey,CNContactEmailAddressesKey,CNContactDatesKey,CNContactUrlAddressesKey,CNContactBirthdayKey, CNContactImageDataKey];
//        [self presentViewController:vc animated:YES completion:nil];
//    });
//    
//}
//
//
//- (CNContactPickerViewController *)contactPicker{
//    
//    if (_contactPicker == nil) {
//        _contactPicker = [[CNContactPickerViewController alloc] init];
//        _contactPicker.delegate = self;
//    }
//    return _contactPicker;
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
