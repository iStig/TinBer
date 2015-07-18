//
//  MineViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeardTableViewCell.h"

#import "AboutViewController.h"
#import "ServiViewController.h"
#import "PersonalViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray * AryTitle ;
    NSArray * AryImageName;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden  = YES;
    
    CGFloat heightTb = ScreenHeigth;
    
    UITableView * tableVMIne = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite, heightTb - 80) style:UITableViewStylePlain];
    tableVMIne.delegate = self;
    tableVMIne.dataSource = self;
    tableVMIne.bounces = NO;
    tableVMIne.backgroundColor =  TTClearColor;
    tableVMIne.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableVMIne];
    
    AryTitle = [NSArray arrayWithObjects:@[@"我的消息",@"我的电台",@"我的电台"],@[@"我的金币",@"我的礼品"],@[@"关于听呗",@"联系客服"], nil];
    AryImageName = [NSArray arrayWithObjects:@"mine",@"prize",@"service", nil];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden  = YES;
    [self showTabBarView];
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

#pragma mark -- tableview delegate & dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2 || section == 3 ) {
        return 2;
    }else if (section == 1){
        return 3;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"minecell";
    UITableViewCell * cell = nil;
    if (indexPath.section == 0) {
        MineHeardTableViewCell * HeardCell = (MineHeardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"mineHeard"];
        if (!HeardCell ) {
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"MineHeardTableViewCell"  owner:nil options:nil];
            HeardCell = [nib firstObject];
        }
        [HeardCell.ImageHeard setImage:[UIImage imageNamed:@"avatar06.jpg"]];
        [HeardCell.btnQiandao addTarget:self action:@selector(clickQiandaoUp:) forControlEvents:UIControlEventTouchUpInside];
        HeardCell.btnQiandao.tag = 100;
        [HeardCell.btnHeard  addTarget:self action:@selector(ClickupImageHeard:) forControlEvents:UIControlEventTouchUpInside];
        
        cell = HeardCell;
    }else {
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
            UIImageView * imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 23, 23)];
            imageIcon.tag = 23;
            [cell.contentView addSubview:imageIcon];
            
            UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(53, 18.5,116 , 16)];
            labelText.tag = 24;
            labelText.font = [UIFont fontWithName:KFontHi size:16.0f];
            labelText.textColor = TTRGBColor(93, 93, 93);
            [cell.contentView addSubview:labelText];
            
            UIView * viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 53, ScreenWhite, 1)];
            viewline.backgroundColor = TTRGBColor(244, 242, 241);
            [cell.contentView addSubview:viewline];
            
            UIImageView * viewCode = [[UIImageView alloc] initWithFrame:CGRectMake(350, 20, 7, 13)];
            viewCode.image = [UIImage imageNamed:@"RectangleCode.png"];
            [cell.contentView addSubview:viewCode];
        }
        
        UIImageView * imageV = (UIImageView *)[cell.contentView viewWithTag:23];
        NSString * str = [NSString stringWithFormat:@"%@%d.png",[AryImageName objectAtIndex:indexPath.section -1 ],(int)indexPath.row];
        imageV.image = [UIImage imageNamed:str];
        
        UILabel * lbltitle = (UILabel *)[cell.contentView viewWithTag:24];
        lbltitle.text  = [[AryTitle objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 134;
    }
    return 54;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * viewH = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite, 15)];
    viewH.backgroundColor = TTClearColor;
    return viewH;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self hiddenTabBarView];
    int indexRow = (int)indexPath.row;
    switch (indexPath.section) {
        case 1:
            
            break;
        case 2:
            break;
        case 3:{
            if (indexRow == 0) {
               
                AboutViewController * aboutVc = [AboutViewController new];
                [self.navigationController pushViewController:aboutVc animated:YES];
                
            }
            else {

                ServiViewController * serviesVc = [ServiViewController new];
                [self.navigationController pushViewController:serviesVc animated:YES];
               
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- 点击头像进行编辑
-(void)ClickupImageHeard:(id)sender{
    [self hiddenTabBarView];
    PersonalViewController * personalVc = [PersonalViewController new];
    [self.navigationController pushViewController:personalVc animated:YES];
}


#pragma mark --  签到
-(void)clickQiandaoUp:(UIButton *)btn{
    if (btn.tag == 100) {
        
        NSString * strMessage = [NSString stringWithFormat:@"获得金币%d枚",10];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"每日签到" message:strMessage delegate:nil cancelButtonTitle:Kconfirm otherButtonTitles: nil];
        [alertView show];
        
        [btn setImage:[UIImage imageNamed:@"qiandaoal"] forState:UIControlStateNormal];
        btn.tag = 110;
    }
}




@end
