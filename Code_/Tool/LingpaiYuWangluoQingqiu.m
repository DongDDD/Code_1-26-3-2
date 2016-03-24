//
//  LingpaiYuWangluoQingqiu.m
//  Code_
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 东. All rights reserved.
//

#import "LingpaiYuWangluoQingqiu.h"
#import<CommonCrypto/CommonDigest.h>
#import <AFNetworking.h>
#import <YTKKeyValueStore.h>

#import "shareMethod.h"//单例
#import "UIViewController+HUD.h"//花

@implementation LingpaiYuWangluoQingqiu


-(NSString *)chongxinHuoquLingpai{
    NSString *ss =  [self lingpai:0];
    NSLog(@"ss:%@,令牌:%@",ss,_lingpaiStr);
    return _lingpaiStr;
}



-(NSString *)lingpai:(int)num{
    
    if (num == 0) {
        [self lingpai01];
    }else{
        //得到当前的时间
        NSDate * date = [NSDate date];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        
        //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
        NSTimeInterval time = 0;//两个小时的秒数
        //得到两个小时后的当前时间
        NSDate * nextDate = [date dateByAddingTimeInterval:time];
        
        //转化为字符串
        NSString * nextTime = [dateFormatter stringFromDate:nextDate];
        // NSLog(@"两个小时后是%@",nextTime);
        //    NSInteger aa = [nextTime integerValue];
        //    NSLog(@"nextTime:%@--%ld",nextTime,(long)aa);
        
        NSInteger time1 = [nextTime integerValue];
        
        
        YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"lingpai.db"];
        NSString *tableName = @"lingpai_table";
        // 创建名为lingpai_table的表，如果已存在，则忽略该操作
        [store createTableWithName:tableName];
        NSString *key = @"lingpai";
        
        // 查询令牌的获取时间与数值
        NSDictionary *queryLingpai = [store getObjectById:key fromTable:tableName];
        NSLog(@"query data result: %@", queryLingpai);
        NSLog(@"%@",queryLingpai[@"time"]);
        NSInteger time2 = [queryLingpai[@"time"] integerValue];
        
        NSLog(@"time1:%ld,time2:%ld",(long)time1,(long)time2);
        
        if (time1 < time2) {//令牌还在有效期
            _lingpaiStr = queryLingpai[@"AccessToken"];
            NSLog(@"令牌在有效期,不用重新获取，令牌是:%@",_lingpaiStr);
        }else{//重新获取令牌
            NSLog(@"令牌为空,开始获取令牌");
            [self lingpai01];//开始获取令牌
        }
        
        NSLog(@"返回令牌");
    }
    return _lingpaiStr;
}

-(void)lingpai01{
    NSLog(@"令牌为空,开始获取令牌");
    //获取网络地址字符串
    /*
     1.网络地址目录：http://10.0.8.8/sns/my/user_list.php
     2.用？把地址目录和参数分隔开
     3.key（page）=value（1）
     4.使用&把每个参数分隔开
     */
    
    NSString *urlString = @"http://120.25.69.40:1005/ValidToken.ashx";
    
    //网络请求地址的格式转换
    NSURL *url = [NSURL URLWithString:urlString];
    
    //网络请求对象创建

    // 创建一个请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    /*
     同步，请求以Synch开头
     异步，请求以Asynch开头
     */
    // 5秒后算请求超时（默认60s超时）
    request.timeoutInterval = 15;
    request.HTTPMethod = @"POST";
    
    // 设置请求体
    NSString *param = @"action=Valid&Token=cdf0898eb5b9824120d013b734a8ecb2";
    // NSString --> NSData
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //获取异常返回错误
    NSError *error;//=@"Error Domain=NSURLErrorDomain Code=-1004 "Could not connect to the server." UserInfo={NSUnderlyingError=0x7feb39e275c0 {Error Domain=kCFErrorDomainCFNetwork Code=-1004 "Could not connect to the server." UserInfo={NSErrorFailingURLStringKey=http://192.168.1.125:1005/ValidToken.ashx, NSErrorFailingURLKey=http://192.168.1.125:1005/ValidToken.ashx, _kCFStreamErrorCodeKey=64, _kCFStreamErrorDomainKey=1, NSLocalizedDescription=Could not connect to the server.}}, NSErrorFailingURLStringKey=http://192.168.1.125:1005/ValidToken.ashx, NSErrorFailingURLKey=http://192.168.1.125:1005/ValidToken.ashx, _kCFStreamErrorDomainKey=1, _kCFStreamErrorCodeKey=64, NSLocalizedDescription=Could not connect to the server.}";
    
    //发出请求
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    //获取响应结果
    
    if (error == nil) {
        
        
        [self lingpai02:data];
    }
    else{
        NSLog(@"错误返回error = %@--",error);//请求步骤一的错误信息
    }

    
    
}


-(void)lingpai02:(NSData *)data{
    //data的json转换
    /*
     NSData转对象（数组，字典）
     入参数：1.返回data数据
     2.读取状态：NSJSONReadingMutableContainers
     3.错误返回：error
     */
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"解析后的数据对象 dic = %@",dic);
    NSDictionary *dict2 = dic[@"Result"];
    
    //组成一维数组
    NSArray *arrs = [NSArray arrayWithObjects:dict2[@"Token"],dict2[@"TimeStamp"],dict2[@"Nonce"], nil];
    NSArray *sortArrs = [arrs sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"sortArrs:%@",sortArrs);
    NSLog(@"1111");
    //拼接字符串
    //NSMutableString *s1 = [NSMutableString string];
    NSString *stt = [NSString string];
    for (NSString *s in sortArrs) {
        NSLog(@"222");
        stt = [stt stringByAppendingString:s];
        NSLog(@"%@",stt);
    }
    //哈希算法SHA1加密
    stt = [self sha1:stt];
    
    
    
    NSString *urlString1 = @"http://120.25.69.40:1005/ValidToken.ashx";
    //网络请求地址的格式转换
    NSURL *url1 = [NSURL URLWithString:urlString1];
    
    
    
    // 创建一个请求
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url1];
    
    /*
     同步，请求以Synch开头
     异步，请求以Asynch开头
     */
    // 5秒后算请求超时（默认60s超时）
    request1.timeoutInterval = 15;
    request1.HTTPMethod = @"POST";
    
    
    // 设置请求体
    // NSString *param = @"action=Valid&Token=cdf0898eb5b9824120d013b734a8ecb2";
    NSString *str2 = [NSString stringWithFormat:@"action=GetToken&Secret=%@&SessionId=%@",stt,dict2[@"SessionId"]];
    // NSString --> NSData
    request1.HTTPBody = [str2 dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    
    //获取异常返回错误
    NSError *error1;
    
    //发出请求
    NSData *data1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:&error1];
    
    //获取响应结果
    
    if (error1 == nil) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"解析后的数据对象-02 dic = %@",dic1);
        NSDictionary *dicc = dic1[@"Result"];
        NSLog(@"-03%@",dicc);
        NSLog(@"令牌是:%@",dicc[@"AccessToken"]);
        
        YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"lingpai.db"];
        NSString *tableName = @"lingpai_table";
        // 创建名为lingpai_table的表，如果已存在，则忽略该操作
        [store createTableWithName:tableName];
        
        //得到当前的时间
        NSDate * date = [NSDate date];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        
        //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
        NSTimeInterval time = 3600;//两个小时的秒数
        //得到两个小时后的当前时间
        NSDate * nextDate= [date dateByAddingTimeInterval:time];
        
        //转化为字符串
        NSString * nextTime = [dateFormatter stringFromDate:nextDate];
        NSLog(@"两个小时后是%@",nextTime);
        
        // 查询令牌的key
        NSString *key = @"lingpai";
        // 删除指定key的数据
        [store deleteObjectById:key fromTable:tableName];
        
        // 保存
        NSDictionary *liangpaiDict = @{@"AccessToken": dicc[@"AccessToken"], @"time": nextTime};
        [store putObject:liangpaiDict withId:key intoTable:tableName];
        _lingpaiStr =dicc[@"AccessToken"];
        NSLog(@"令牌已经赋值：%@",_lingpaiStr);
        
    }else{
        NSLog(@"错误信息%@",error1);//请求步骤二的错误信息
    }
    
    
    
}





#pragma mark - 下载数据
-(id)qingqiushujuWithUrlString:(NSString *)url withNSDictionary:(NSDictionary *)dict{
     //本地数据库提取令牌，判断有没有值，没有调用方法获取令牌
    _url = url;
    _dict = dict;
    
    
    if(!_lingpaiStr){
        NSLog(@"令牌为空,开始获取令牌");
        _lingpaiNum = 0;
        //    //创建一个线程对象
        NSInvocationOperation *invocationO = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(kaishiHuoquLingpai) object:nil];
        
        //    //启动线程（同步线程，会阻塞UI）
        //[invocationO start];
        
        [self kaishiHuoquLingpai];
    }
    
    
     NSLog(@"aaaaaaaaaaaaaaaaaaaa");
        //[dict setValue:_lingpaiStr forKey:@"AccessToken"];
    [dict setValue:@"50749002969a497fb5f80fe34d38bb5c" forKey:@"AccessToken"];
        //发送POST请求使用
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dict
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  
                  NSLog(@"请求成功---%@", responseObject);
                  _data = responseObject;
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"");
                  //请求失败的时候调用调用这个block
                  NSLog(@"请求失败");
                  
              }];

    while (_lingpaiNum) {
        if (_lingpaiNum != 1 ) {
            [ self panduanLingpaiYoumeiyouHuoquCheanggong];
        }
    }
    
    
    

    NSLog(@"返回数据");
//    if (_data){
        NSLog(@"有数据返回");
        return _data;
//    }else{
//        NSLog(@"没有数据返回");
//        return nil;
//    }
    
}



-(void)panduanLingpaiYoumeiyouHuoquCheanggong{
    NSLog(@"aaaa");
    _lingpaiNum = 0;
    
}



#pragma mark - 获取令牌步骤01
-(void)kaishiHuoquLingpai{
    NSString *url = @"http://120.25.69.40:1005/ValidToken.ashx";
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:@"Valid" forKey:@"action"];
    [dict1 setValue:@"cdf0898eb5b9824120d013b734a8ecb2" forKey:@"Token"];
    NSLog(@"dict = %@",dict1);
    //发送请求
    NSLog(@"开始获取");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //POST请求使用
    [manager POST:url parameters:dict1
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // 请求成功的时候调用这个block
             NSLog(@"请求成功---%@", responseObject);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              NSLog(@"++++++%@",dic[@"Result"]);
              //开始进入步骤02
              [self huoqulingpai:dic with:url];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"");
              
              // 请求失败的时候调用调用这个block
              NSLog(@"请求失败");
              
          }];
}


#pragma mark - 获取令牌步骤02
-(void)huoqulingpai:(NSDictionary *)dict with:(NSString *)url{
    NSLog(@"开始获取令牌步骤02");
    NSLog(@"dict---%@、、、、%@",dict,url);
    NSDictionary *dict2 = dict[@"Result"];
    //组成一维数组
    NSArray *arrs = [NSArray arrayWithObjects:dict2[@"Token"],dict2[@"TimeStamp"],dict2[@"Nonce"], nil];
    NSArray *sortArrs = [arrs sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"sortArrs:%@",sortArrs);
    NSLog(@"1111");
    //拼接字符串
    //NSMutableString *s1 = [NSMutableString string];
    NSString *stt = [NSString string];
    for (NSString *s in sortArrs) {
        NSLog(@"222");
        stt = [stt stringByAppendingString:s];
        NSLog(@"%@",stt);
    }
    //哈希算法SHA1加密
    stt = [self sha1:stt];
    //组成新的请求的字典
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setObject:@"GetToken" forKey:@"action"];
    [dict1 setObject:stt forKey:@"Secret"];
    [dict1 setObject:dict2[@"SessionId"] forKey:@"SessionId"];
    NSLog(@"333");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   //POST请求使用
    [manager POST:url parameters:dict1
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // 请求成功的时候调用这个block
                NSLog(@"获取令牌成功---%@", responseObject);
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              NSLog(@"++++++%@------%@",dic[@"IsError"],dic[@"Result"]);
              NSLog(@"%@",dic[@"Result"][@"AccessToken"]);
              //把令牌的值传给_lingpaiStr
              _lingpaiStr =dic[@"Result"][@"AccessToken"];
              //[];
              
              _lingpaiNum = 1;
              
              
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"%@",error);
              // 请求失败的时候调用调用这个block
              NSLog(@"请求失败");
              //重新获取令牌
              [self kaishiHuoquLingpai];
          }];
 
}

#pragma mark - 哈希加密
- (NSString *) sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}



@end
