//
//  ViewController.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/21.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "ViewController.h"
#import "ChannelTableViewCell.h"
@interface ViewController ()<ZITOPayDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) NSMutableArray * channelDataArr;
@end

@implementation ViewController
{
    NSString * billTitle;//订单标题
}
- (void)viewWillAppear:(BOOL)animated
{
    #pragma mark - 设置delegate
    [ZITOPay setZITOPayDelegate:self];
}
- (NSMutableArray *)channelDataArr
{
    if (!_channelDataArr) {
        _channelDataArr = [[NSMutableArray alloc] init];
    }
    return _channelDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"支付列表"];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    NSArray * channelArr = @[@{@"sub":@(PayChannelWxApp), @"img":@"wx", @"title":@"微信支付"},
                             @{@"sub":@(PayChannelAli), @"img":@"ali", @"title":@"支付宝"},
                             @{@"sub":@(PayChannelSumaQuick), @"img":@"suma", @"title":@"丰付快捷支付"},
                             @{@"sub":@(PayChannelSumaUnion), @"img":@"suma", @"title":@"丰付银联支付"},
                             @{@"sub":@(PayChannelChangQuick), @"img":@"chan", @"title":@"畅捷通快捷支付"},
                                               ];
    [self.channelDataArr addObjectsFromArray:channelArr];
    
    billTitle = [ZITOPay getCurrentMode] ? @"测试" : @"正式";
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [tableView setBackgroundColor:[UIColor whiteColor]];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    [tableView reloadData];
}
#pragma mark - 微信、支付宝、丰付快捷、丰付银联、畅捷通

- (void)doPay:(PayChannel)channel {
    NSString *billno = [self genBillNo];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
    ZITOPayReq *payReq = [[ZITOPayReq alloc] init];
    payReq.channel = channel; //支付渠道
    payReq.title = billTitle;//订单标题
    payReq.currency = @"cny";//币种必填
    payReq.totalFee = @"0.01";//订单价格;以分为单位的整数，即为0.1元
    payReq.billNo = billno;//商户自定义订单号
    payReq.scheme = @"paySchemes";//URL Scheme,在Info.plist中配置; 支付宝必有参数
    payReq.billTimeOut = 300;//订单超时时间
    payReq.viewController = self; //丰付快捷M＋、丰付银联必填
    payReq.goodsname = @"西装";//商品名称，选填
    payReq.goodsdetail = @"套装";//商品描述，选填
    payReq.cardType = 0; //0 表示不区分卡类型；1 表示只支持借记卡；2 表示支持信用卡；默认为0
    payReq.optional = dict;//商户业务扩展参数，会在webhook回调时返回
   
    [ZITOPay sendZITOReq:payReq];
    
}
#pragma mark - ZITOPayDelegate
- (void)onZITOPayResp:(ZITOBaseResp *)resp{
     [self showAlertView:resp.resultMsg];
}
- (void)showAlertView:(NSString *)msg {
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark - 生成订单号
- (NSString *)genBillNo {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [formatter stringFromDate:[NSDate date]];
}



#pragma mark+++++++++++UITableViewDelegate+++++++++++++
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark+++++++++++UITableViewDataSource+++++++++++++
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.channelDataArr count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    ChannelTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[ChannelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary * dic = [self.channelDataArr objectAtIndex:indexPath.row];
    [cell setCellData:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [self.channelDataArr objectAtIndex:indexPath.row];
    NSInteger channel = [[dic objectForKey:@"sub"] integerValue];
    NSLog(@"%ld",channel);
    switch (channel) {
        case PayChannelWxApp:
        case PayChannelAli:
        case PayChannelAliApp:
        case PayChannelSumaQuick:
        case PayChannelSumaUnion:
        case PayChannelChangQuick:
        {
            [self doPay:channel];
        }
            break;
       
        default:
            break;
    }
}
@end
