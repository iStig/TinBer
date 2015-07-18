
//
//  AboutViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray * _aryText;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftbuttonImage:@"IconBack"];
    [self setTopTitle:@"关于听呗"];
    
    UITableView * tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite,261) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.bounces = NO;
    tableV.backgroundColor =  TTClearColor;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableV];
    
    _aryText = [NSArray arrayWithObjects:@[@"产品说明",@"用户协议"],@"使用帮助",@"分享听呗", nil];
    
    UILabel *lblVer = [[UILabel alloc] initWithFrame:CGRectMake(131, ScreenHeigth - 97, 112, 17)];
    lblVer.font = [UIFont fontWithName:KFontHi size:14.0f];
    lblVer.textColor = TTRGBColor(136, 136, 136);
    lblVer.text = [NSString stringWithFormat:@"当前版本号 v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    [self.view addSubview:lblVer];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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
    if (indexPath.section == 0) {
        lbltitle.text = [_aryText[0] objectAtIndex:indexPath.row];
    }else {
        lbltitle.text = _aryText[indexPath.section];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * viewH = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite, 15)];
    viewH.backgroundColor = TTClearColor;
    return viewH;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
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
