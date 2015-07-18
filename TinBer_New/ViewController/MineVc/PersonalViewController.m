//
//  PersonalViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalHeardTableViewCell.h"
#import "EditNameViewController.h"
#import "RevisePasswordViewController.h"
#import "AddressViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{
    NSArray * AryTitle;
    NSArray * AryMessage ;
    BOOL hasCamaraDevice;
    UIImage * imageHeard;
    UITableView * tableV;
}

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftbuttonImage:@"IconBack"];
    [self setTopTitle:@"个人信息"];
    
    tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite, ScreenHeigth - 80) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.bounces = NO;
    tableV.backgroundColor =  TTClearColor;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableV];
    
    AryTitle = [NSArray arrayWithObjects:@[@"昵称",@"手机号",@"修改密码",@"所在地"],@"收件信息", nil];
    AryMessage = [NSArray arrayWithObjects:@[@"昵称",@"12444946789",@"",@"上海"],@"未设置", nil];
    imageHeard = [UIImage imageNamed:@"avatar06.jpg"];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1){
        return 4;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"Personalcell";
    UITableViewCell * cell = nil;
    if (indexPath.section == 0) {
        PersonalHeardTableViewCell * PersonalCell = (PersonalHeardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PersonalHeard"];
        if (!PersonalCell ) {
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"PersonalHeardTableViewCell"  owner:nil options:nil];
            PersonalCell = [nib firstObject];
        }
        PersonalCell.ImagePhoto.image = imageHeard;
        [PersonalCell.btnEdit addTarget:self action:@selector(changePersonalHeard) forControlEvents:UIControlEventTouchUpInside];
        
        cell = PersonalCell;
    }else if (indexPath.section == 3) {
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Logout"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Logout"];
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(15, 0, 345, 44)];
            [btn setBackgroundImage:[UIImage imageNamed:@"RectangleYellow"] forState:UIControlStateNormal];
            [btn setTitle:@"退出登录" forState:UIControlStateNormal];
            [btn setTitleColor:TTWhiteColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:KFontHi size:17.0f];
            [btn addTarget:self action:@selector(LogOut) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
            
            cell.backgroundColor = TTClearColor;
            
        }
    }else {
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
            UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5,116 , 16)];
            labelText.tag = 24;
            labelText.font = [UIFont fontWithName:KFontHi size:16.0f];
            labelText.textColor = TTRGBColor(93, 93, 93);
            [cell.contentView addSubview:labelText];
            
            UIView * viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 53, ScreenWhite, 1)];
            viewline.backgroundColor = TTRGBColor(244, 242, 241);
            [cell.contentView addSubview:viewline];
            
            UIImageView * viewCode = [[UIImageView alloc] initWithFrame:CGRectMake(350, 20, 7, 13)];
            viewCode.image = [UIImage imageNamed:@"RectangleCode.png"];
            viewCode.tag = 27;
            [cell.contentView addSubview:viewCode];
            
            UILabel * lblM = [[UILabel alloc] initWithFrame:CGRectMake(116+ 25, 18.5, 350-116-35, 16)];
            lblM.tag = 26;
            lblM.font = [UIFont fontWithName:KFontHi size:16.0f];
            lblM.textColor = TTRGBColor(153, 153, 153);
            [cell.contentView addSubview:lblM];
            lblM.textAlignment = NSTextAlignmentRight;
            
        }
        UILabel * lbltitle = (UILabel *)[cell.contentView viewWithTag:24];
        UILabel * lblM = (UILabel *)[cell.contentView viewWithTag:26];
        UIImageView * imageCode = (UIImageView *)[cell.contentView viewWithTag:27];
        imageCode.hidden = NO;
        if (indexPath.section == 1) {
            if (indexPath.row == 1) {
                imageCode.hidden = YES;
                lblM.frame = CGRectMake(116+ 30 + 15, 18.5, 350-116-35, 16);
            }
            
            lblM.text = [[AryMessage objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row];
            lbltitle.text  = [[AryTitle objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row];
        }else {
            lbltitle.text  = [AryTitle objectAtIndex:indexPath.section - 1];
            lblM.text = [AryMessage objectAtIndex:indexPath.section - 1];
            
        }

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
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
    }else if (section == 3){
        return 25;
    }
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                EditNameViewController * editVc = [EditNameViewController new];
                [self.navigationController pushViewController:editVc  animated:YES];
            }
                
                break;
            case 2:{
                RevisePasswordViewController * reviseVc = [RevisePasswordViewController new];
                [self.navigationController pushViewController:reviseVc animated:YES];
            }
                break;
            case 3:
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 2){
        AddressViewController * addressVc = [AddressViewController new];
        addressVc.strtitle = @"收件信息";
        addressVc.strReturn = @"保存";
        [self.navigationController pushViewController:addressVc animated:YES];
    }
}


#pragma mark -- 更换头像
-(void)changePersonalHeard{
    //判断是否有摄像头
    hasCamaraDevice = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (hasCamaraDevice) {
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"请选择图片来源:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机拍摄",@"相册选择", nil];
        [actionSheet showInView:self.view];
        actionSheet.tag=60;
    }else{
        [self selImageByPhoto];
    }

}

#pragma mark -- 退出登录
-(void)LogOut{
    
}


//从相册选择图片
-(void)selImageByPhoto
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;// 设置代理
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:NULL];
}

//摄像头拍摄图片
-(void)selImageByShoot
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
    [picker setDelegate:self];
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:NULL];
    
    //设置判断属性是否要保存到图册
//    fromShootImageOrVideo = YES;
}

#pragma mark--actionsheetdelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self selImageByShoot];
            break;
        case 1:
            [self selImageByPhoto];
            break;
        default:
            break;
    }
   
}


#pragma mark-imagepickerdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"editing info");
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey: UIImagePickerControllerEditedImage];
    //当前图片数据
    NSData *data = UIImageJPEGRepresentation(imageHeard, 0.5);
    //选取图片数据
    //UIImage *select = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSData *data1 = UIImageJPEGRepresentation(image, 0.5);
    //判断图片是否改变
    if (![data isEqualToData:data1]) {
//        isheadimgchanged = YES;
        NSLog(@"换头像了");
    }
    imageHeard = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [tableV reloadData];
    
}


@end
