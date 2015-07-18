//
//  ServiViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "ServiViewController.h"
#import "OnLineViewController.h"

@interface ServiViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@end

@implementation ServiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView * tableVMIne = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, ScreenWhite,108) style:UITableViewStylePlain];
    tableVMIne.delegate = self;
    tableVMIne.dataSource = self;
    tableVMIne.bounces = NO;
    tableVMIne.backgroundColor =  TTClearColor;
    tableVMIne.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableVMIne];
    
    [self setLeftbuttonImage:@"IconBack"];
    [self setTopTitle:@"联系客服"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"ServicesId";
    UITableViewCell * cell = nil;
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
            UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5,116 , 16)];
            labelText.tag = 24;
            labelText.font = [UIFont fontWithName:@"Heiti Sc-Ligth" size:16.0f];
            labelText.textColor = TTRGBColor(93, 93, 93);
            [cell.contentView addSubview:labelText];
            
            UIView * viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 53, ScreenWhite, 1)];
            viewline.backgroundColor = TTRGBColor(244, 242, 241);
            [cell.contentView addSubview:viewline];
            
            UIImageView * viewCode = [[UIImageView alloc] initWithFrame:CGRectMake(350, 20, 7, 13)];
            viewCode.image = [UIImage imageNamed:@"RectangleCode.png"];
            [cell.contentView addSubview:viewCode];
        }
        
        UILabel * lbltitle = (UILabel *)[cell.contentView viewWithTag:24];
    if (indexPath.row == 0) {
         lbltitle.text = @"线上客服";
    }else {
         lbltitle.text = @"400热线";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        OnLineViewController * OnlineVc = [OnLineViewController new];
        [self.navigationController pushViewController:OnlineVc animated:YES];
    }else {
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:@"确定拨打 \n 400-8554-577" delegate:self cancelButtonTitle:kCancel otherButtonTitles:Kconfirm, nil];
        [alertview show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",KServiesPhone]]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",KServiesPhone]]];
        }else{
            TTAlert(@"您的设备没有拨号功能!");
        }

    }
}

@end
