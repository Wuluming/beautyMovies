//
//  MineViewController.m
//  QX20151125
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define TextFiledTag 10

#import "MineViewController.h"
#import "DeatailModel.h"
#import "CollectCell.h"
#import "HeadViewCell.h"
#import "XWDetailController.h"
@interface MineViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation MineViewController
{
    NSInteger _index;
    UIImageView * _headImageView;
    UIImageView * _thirdImageView;
    UILabel * _nameLabel;
    UILabel *_thirdLabel;
    UIButton * _weiboButon;
    UIButton * _enterButton;
    UIButton * _cancleButton;
    UILabel * _selfName;
    UIImagePickerController * _picker;
    NSData * _data;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView removeFromSuperview];
}

- (void)initDataSource {
    [super initDataSource];
    for (int i = 0; i < 2; i++) {
        NSMutableArray * temp = [[NSMutableArray alloc] init];
        [self.dataSource addObject:temp];
    }
}

-(void)setNavigationBar {
    
    UISegmentedControl * seg = [[UISegmentedControl alloc] initWithItems:@[@"收藏",@"账户"]];
    seg.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 44);
    seg.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    seg.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    seg.selectedSegmentIndex = 1;
    [seg addTarget:self action:@selector(segAtIndex:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    [self addtHirdEnter];
}

- (void)addtHirdEnter {
    
    
    
    
    UIImageView * bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"top_bg"];
    bgImageView.frame = CGRectMake(0, 64, SCREEN_SIZE.width, SCREEN_SIZE.height * 0.3);
    [self.view addSubview:bgImageView];
    
    UIImageView * bottomImageView = [[UIImageView alloc] init];
    bottomImageView.frame = CGRectMake(0, SCREEN_SIZE.height * 0.3 + 64, SCREEN_SIZE.width, SCREEN_SIZE.height * 0.7-64-49);
    bottomImageView.userInteractionEnabled = YES;
    bottomImageView.image = [UIImage imageNamed:@"top_bg_bottom_edge"];
    [self.view addSubview:bottomImageView];
    
    
    
    
    UIImage * image = [UIImage imageNamed:@"default_header"];
    
    //第三方登陆成功后
    _thirdImageView = [[UIImageView alloc] init];
    _thirdImageView.frame = CGRectMake(20, SCREEN_SIZE.height * 0.3, image.size.width, image.size.height);
    _thirdImageView.layer.cornerRadius = image.size.width/2;
    _thirdImageView.layer.borderWidth = 1;
    _thirdImageView.layer.masksToBounds = YES;
    _thirdImageView.hidden = YES;
    _thirdImageView.layer.borderColor = [UIColor yellowColor].CGColor;
    [self.view addSubview:_thirdImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(image.size.width + 20, SCREEN_SIZE.height * 0.3, 150, 30);
    [self.view addSubview:_nameLabel];
    
    _cancleButton = [[UIButton alloc] init];
    _cancleButton.frame = CGRectMake(SCREEN_SIZE.width - 100, 64, 80, 40);
    [_cancleButton setTitle:@"注销登录" forState:UIControlStateNormal];
    _cancleButton.hidden = YES;
    _cancleButton.layer.borderWidth = 1;
    _cancleButton.layer.borderColor = [UIColor blackColor].CGColor;
    [_cancleButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [_cancleButton addTarget:self action:@selector(cancleClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancleButton];
    
    _headImageView = [[UIImageView alloc] init];
    _headImageView.frame = CGRectMake((SCREEN_SIZE.width - image.size.width)/2, SCREEN_SIZE.height * 0.3, image.size.width, image.size.height);
    _headImageView.userInteractionEnabled = YES;
    _headImageView.layer.cornerRadius = image.size.width/2;
    _headImageView.layer.masksToBounds = YES;
    [self.view addSubview:_headImageView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [_headImageView addGestureRecognizer:tap];
    
    
    
    
    _selfName = [[UILabel alloc] init];
    _selfName.frame = CGRectMake(CGRectGetMidX(_headImageView.frame)-75, SCREEN_SIZE.height * 0.3-30, 150, 30);
    _selfName.textAlignment = NSTextAlignmentCenter;
    _selfName.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_selfName];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]) {
        
        NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        _selfName.text = dict[@"username"];
        if (dict[@"image"]) {
            _headImageView.image = [UIImage imageWithData:dict[@"image"]];
        }else {
            _headImageView.image = image;
        }
        
        
    }else if ([[NSUserDefaults standardUserDefaults] objectForKey:@"info"] == NULL) {
        
        _headImageView.image = image;
        
        
        for (int i = 0; i < 2; i++) {
            UITextField * textField = [[UITextField alloc] init];
            textField.frame = CGRectMake(20, 40 + (30 +10)*i, SCREEN_SIZE.width * 0.5, 30);
            textField.backgroundColor = [UIColor yellowColor];
            textField.tag = TextFiledTag + i;
            [bottomImageView addSubview:textField];
        }
        
        _enterButton = [[UIButton alloc] init];
        [_enterButton setTitle:@"注册" forState:UIControlStateNormal];
        _enterButton.bounds = CGRectMake(0, 0, 80, 80);
        [_enterButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        _enterButton.layer.cornerRadius = _enterButton.bounds.size.width/2;
        _enterButton.layer.borderWidth = 3;
        _enterButton.layer.borderColor = [UIColor yellowColor].CGColor;
        _enterButton.layer.masksToBounds = YES;
        _enterButton.center = CGPointMake(SCREEN_SIZE.width - 80,75);
        [_enterButton addTarget:self action:@selector(enterClicked) forControlEvents:UIControlEventTouchUpInside];
        [bottomImageView addSubview:_enterButton];
        
        UIImage * weiboImage = [UIImage imageNamed:@"third_Binding1"];
        
        _thirdLabel = [[UILabel alloc] init];
        _thirdLabel.font = [UIFont systemFontOfSize:20];
        _thirdLabel.frame = CGRectMake(20, bottomImageView.frame.size.height - 100, 150, weiboImage.size.height);
        _thirdLabel.text = @"微博登陆:";
        [bottomImageView addSubview:_thirdLabel];
        
        _weiboButon = [UIButton new];
        _weiboButon.frame = CGRectMake(SCREEN_SIZE.width/2, bottomImageView.frame.size.height - 100, weiboImage.size.width, weiboImage.size.height);
        [_weiboButon setImage:weiboImage forState:UIControlStateNormal];
        [_weiboButon addTarget:self action:@selector(weiboClicked) forControlEvents:UIControlEventTouchUpInside];
        [bottomImageView addSubview:_weiboButon];
        
    }else {
        NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"info"];
        
        //第三方头像
        
        [_thirdImageView sd_setImageWithURL:[NSURL URLWithString:info[@"iconURL"]]];
        _thirdImageView.hidden = NO;
        _cancleButton.hidden = NO;
        _nameLabel.text = info[@"username"];
        
    }
    
    
    
}

- (void)tapGesture:(UITapGestureRecognizer *)tapGesture {
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
    [self presentViewController:_picker animated:YES completion:nil];
}

#pragma mark - 点击相册的时候会触发此方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    _data = UIImagePNGRepresentation(image);
    _headImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancleClicked {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"info"];
    _thirdImageView.hidden = YES;
    _nameLabel.hidden = YES;
    _cancleButton.hidden = YES;
    _headImageView.hidden = NO;
    _enterButton.hidden = NO;
    _thirdLabel.hidden = NO;
    _weiboButon.hidden = NO;
    for (int i = 0; i < 2; i++) {
        UITextField * tf = (id)[self.view viewWithTag:TextFiledTag + i];
        tf.hidden = NO;
    }
}

#pragma  mark - 注册按钮被点击

- (void)enterClicked {
    
    UITextField * userName = (id)[self.view viewWithTag:TextFiledTag];
    UITextField * password = (id)[self.view viewWithTag:TextFiledTag + 1];
    
    if (userName.text.length > 0  && password.text.length > 0) {
        if (_data) {
            NSDictionary * userInfo = @{@"username":userName.text,@"password":password.text,@"image":_data};
            [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"userInfo"];
        }else {
            NSDictionary * userInfo = @{@"username":userName.text,@"password":password.text,};
            [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"userInfo"];
        }
        
    }
    
    userName.hidden = YES;
    password.hidden = YES;
    _thirdLabel.hidden = YES;
    _weiboButon.hidden = YES;
    _enterButton.hidden = YES;
    _selfName.text = userName.text;
}

- (void)weiboClicked {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            NSDictionary * info = @{@"username":snsAccount.userName,@"usid":snsAccount.usid,@"accessToken":snsAccount.accessToken,@"iconURL":snsAccount.iconURL};
            
            [[NSUserDefaults standardUserDefaults] setObject:info forKey:@"info"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            
            
            _headImageView.hidden = YES;
            _thirdImageView.hidden = NO;
            _nameLabel.hidden = NO;
            _cancleButton.hidden = NO;
            [_thirdImageView sd_setImageWithURL:[NSURL URLWithString:snsAccount.iconURL]];
            for (int i = 0; i < 2; i++) {
                UITextField * tf = (id)[self.view viewWithTag:TextFiledTag + i];
                tf.hidden = YES;
            }
            _nameLabel.text = snsAccount.userName;
            _thirdLabel.hidden = YES;
            _weiboButon.hidden = YES;
            _enterButton.hidden = YES;
        }});
    
    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
        
       
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITextField * tf1 = (id)[self.view viewWithTag:TextFiledTag];
    [tf1 resignFirstResponder];
    UITextField * tf2 = (id)[self.view viewWithTag:TextFiledTag + 1];
    [tf2 resignFirstResponder];
}

- (void)segAtIndex:(UISegmentedControl *)seg {
    _index = seg.selectedSegmentIndex;
    [self.dataSource[_index] removeAllObjects];
    
    if (_index == 1) {
        [self.tableView removeFromSuperview];
        
    }else {
        self.tableView.frame = CGRectMake(0, 64, SCREEN_SIZE.width, SCREEN_SIZE.height - 49);
        [self.view addSubview:self.tableView];
    }
    if (_index == 0) {
        [self.dataSource[_index] addObjectsFromArray:[self.dbManager allModel]];
    }
    
    

    [self.tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource[_index] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index == 0) {
        CollectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
        if (cell == nil) {
            cell = [[CollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aCell"];
        }
        DeatailModel * model = self.dataSource[_index][indexPath.row];
        cell.model = model;
        return cell;
    }
    
    return nil;
}

#pragma mark - 头像，登陆

- (UITableViewCell *)tableView:(UITableView *)tableView HeadCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
    if (cell == nil) {
        cell = [[HeadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headCell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index == 0) {
        return MainItemCell_Height;
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index == 0) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index == 0) {
        DeatailModel * model = self.dataSource[_index][indexPath.row];
        [self.dbManager deleteModel:model];
        [self.dataSource[_index] removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index ==0) {
        XWDetailController * detail = [[XWDetailController alloc] init];
        DeatailModel * model = self.dataSource[_index][indexPath.row];
        detail.play_id = model.play_id;
        detail.name = model.title;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
