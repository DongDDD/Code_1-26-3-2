//
//  OrderlistSSTableViewController.m
//  Code_
//
//  Created by admin on 16/3/6.
//  Copyright © 2016年 东. All rights reserved.
//
#import "OrderlistSSTableViewCell.h"
#import "OrderlistSSTableViewController.h"

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "APAuthV2Info.h"

#import "WXApiRequestHandler.h"

@interface OrderlistSSTableViewController ()

@end

@implementation OrderlistSSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    
    UIButton *fanhu=[UIButton buttonWithType:UIButtonTypeSystem];
    fanhu.frame=CGRectMake(0, 0, 10, 17);
    [fanhu setBackgroundImage:[UIImage imageNamed:@"返回fan"] forState:UIControlStateNormal];
    [fanhu addTarget:self action:@selector(fanhu1Action) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *currentMusicBtn1=[[UIBarButtonItem alloc]initWithCustomView:fanhu];
    self.navigationItem.leftBarButtonItem=currentMusicBtn1;
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData{
    if ([[shareMethod shareManger] isNetWork]==NO)
    {
        [self shoWHint:@"当前网络异常!"];
        //        [self.tableV headerEndRefreshing];
    }else  {
        [self showHudInViewhint:@"正在加载"];//显示提示框
        NSString *url = @"http://120.25.69.40:1005/API/OrdersData.ashx";
        NSMutableDictionary *dict9 = [NSMutableDictionary dictionary];

        [dict9 setValue:@"View" forKey:@"action"];
        [dict9 setValue:self.lingpai forKey:@"AccessToken"];//令牌
        [dict9 setValue:self.MembIdsStr forKey:@"MembId"];//
        [dict9 setValue:self.OrderIdsStr forKey:@"OrderId"];
        NSLog(@"请求的参数是:%@",dict9);
        
        //发送POST请求使用
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dict9
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  // 请求成功的时候调用这个block
                  
                  //              NSLog(@"---%@", responseObject);
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                  
                  //              NSLog(@"等到的数据转成字典是---dic:%@",dic);
                  
                  NSDictionary *dicR = dic [@"Result"];
                  NSDictionary *dicOrde=dicR[@"Order"];
                  NSLog(@"88888==%@",dicR);
                  NSLog(@"88888999++++==%@",dicOrde);
                  NSLog(@"%@",dicOrde[@"OrderNo"]);
                  NSString *MsgStr = dic[@"Msg"];
                  NSInteger nu = [dic[@"IsError"] integerValue];
                  if (nu ==1) {
                      
                      NSLog(@"发送请求结果有异常,异常信息是%@",MsgStr);
                      NSLog(@"获取不成功，返回的消息是%@",MsgStr);
                                            [self chongxinHuoquLingpai];
                                            [self getData];
                      
                  }else{
                      NSLog(@"发送请求结果无异常");
                      
                      self.ordesss=[[OrderlistModeSSS alloc]init];
                      [self.ordesss setValuesForKeysWithDictionary:dicOrde];
                      
                      NSDictionary *dicProd=dicR[@"Prod"];
                      self.ProdStr=dicProd[@"ProdName"];
//                      for (NSDictionary *dic1 in array1) {
//                          OrderlistMode *Orfora=[[OrderlistMode alloc]init];
//                          [Orfora setValuesForKeysWithDictionary:dic1];
//                          [self.dataArray addObject:Orfora];
//                          int  f=Orfora.OrderState;
//                          if (f==1) {
//                              [self.ORDEArray addObject:@"待支付"];
//                              
//                          }else if (f==2)
//                          {
//                              [self.ORDEArray addObject:@"已支付"];
//                              
//                          }else if (f==-1)
//                          {
//                              [self.ORDEArray addObject:@"已取消"];
//                          }else{
//                              [self.ORDEArray addObject:@"异常"];
//                          }
//                          
//                          NSLog(@"数组个数为%ld",self.dataArray.count);
//                          NSLog(@"%@",dic1);
//                          
//                      }
                  }
                  [self showhide];
                  [self.tableView reloadData];
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [self showhide];//隐藏菊花
                  [self shoWHint:@"请求失败"];
              }];
    }

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderlistSSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
    if (cell==nil) {
        cell=[[OrderlistSSTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"one"];
    }

        cell.ProdNameLabel.text=[NSString stringWithFormat:@"房屋名称:%@",self.ProdStr];
    cell.ordessss=self.ordesss;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(270*ScreenWidth/375, 150*ScreenWidth/375, 85*ScreenWidth/375, 30*ScreenWidth/375)];
            button.backgroundColor=[UIColor redColor];
            int  f=self.ordesss.OrderState;
            if (f==1) {

               self.ordeStr=@"待支付";
              }else if (f==2)
              {

             self.ordeStr=@"已支付";
              }else if (f==-1)
              {
                  self.ordeStr=@"已取消";

              }else{
                  self.ordeStr=@"异常";
           
              }

            [button setTitle:self.ordeStr forState:UIControlStateNormal];
    
            if ([self.ordeStr isEqualToString:@"待支付"]) {
                 button.backgroundColor = [UIColor  colorWithRed:0/255.0 green:159/255.0 blue:252/255.0 alpha:1];
            }else
            {
                button.backgroundColor = [UIColor  grayColor];
            }
    
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button addTarget:self action:@selector(zorderAction) forControlEvents:UIControlEventTouchUpInside];
            button.layer.borderWidth=1;
            button.layer.borderColor=[[UIColor clearColor]CGColor];
            button.layer.cornerRadius=8;
            [cell addSubview:button];
    
    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(270*ScreenWidth/375, 200*ScreenWidth/375, 85*ScreenWidth/375, 30*ScreenWidth/375)];
    button2.backgroundColor=[UIColor blackColor];
    [button2 setTitle:@"微信支付" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:16];
    [button2 addTarget:self action:@selector(zorderAction2) forControlEvents:UIControlEventTouchUpInside];
    button2.layer.borderWidth=1;
    button2.layer.borderColor=[[UIColor clearColor]CGColor];
    button2.layer.cornerRadius=8;
    [cell addSubview:button2];
    
    return cell;
}

#pragma mark - Cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250*ScreenWidth/375;
}

- (void)zorderAction
{
    NSLog(@"点击支付");
    
    NSString *partner = @"2088221198302424";
    NSString *seller = @"xiangcunjia@sappal.cn";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALlyEbgWWcpYn0WU"
    "Dh483Lu5kmMO7mgYCd/nNEYkJPpklb9lR6hhqN16rDqUW9GKams5JTYTJjdICUY2"
    "Ru4AcFE5KM3kq2KP2SR88+S4g6OnvKtzyotOx2EyI6eBhV6fL8NtkVyKebF7hkkD"
    "Z6FN1vbCuKgN9UajqbZWdxd36mFlAgMBAAECgYARoxiuUmndxcn4GxmwpIc1z3Nt"
    "umjQO6EMy3d8SEnACrr3RhGnoQonblhdBekpp6lxYzD30KBs14wSQm1Ci4Yi+fw0"
    "3TFxK9PbRbszkBsn7iL9Z5EN0afJ4CdcX8T2E01dd2fqgc+Jc/VByQ+CRjyUGrCa"
    "y4qbayKHZUEjyqAdjQJBAOI9zmKomuR903fV5Pjgc68VT3jRqdA5MgA6JhdLv87n"
    "AIalk0vJPpMffYhEWSnoDIYQkdltsR1JNV5o6JdZQdcCQQDR1ozxQvXIJZcv+gIT"
    "uQk6iTtDsP1P1Phd2WI8dRk80ZSqKQcRrD+ryqaV54y9lq3PNmFcRUFBoAUbBsnP"
    "MocjAkBkXs04Qdrt8dCmgpNhwpowG8E1NbcjtKw1I5cQkL+YuC0ojz6IydBkDv1v"
    "PftctyEPPTynfJ2uA3OU3fAKbUPjAkEAqdjnNnXDqeC7cosD2WEB1k60GMOPFmpF"
    "KvnFKTiDWBYwJleVMDnjQ7OBiX7mDaOERmA3CE/KVUsoNssU2NCGTwJBAN3nh7U3"
    "jGMQGvyCpN/kox+OQK5PwyZnT0njd3wuwsl7RMLAbxf+w0bCVR4ZgH7FOhWB9L/M"
    "ih4hzrPHT2rLvj8=";
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    NSLog(@"订单ID------%@",self.ordesss.OrderNo);
    order.tradeNO =self.ordesss.OrderNo; //订单ID（由商家自行制定）
    order.productName =self.ProdStr; //商品标题
    order.productDescription =self.ProdStr; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",self.ordesss.OrderTotalPrice]; //商品价格 float     %.2f
    order.notifyURL =  @"http://120.25.69.40:1005/API/GetAliPayData.ashx"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec222 = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"返回的支付结果2 reslut = %@",resultDic);
            
            if ([resultDic[@"resultStatus"] integerValue]==9000) {
                [self fanhu1Action];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }else if ([resultDic[@"resultStatus"] integerValue]==6001){
                
            }else{
                NSLog(@"什么不干");
            }
            
            
        }];
    }
    
}

- (void)zorderAction2{
    NSLog(@"点击微信支付");

    NSString *res = [WXApiRequestHandler jumpToBizPay];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];

    }
        
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)fanhu1Action
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
