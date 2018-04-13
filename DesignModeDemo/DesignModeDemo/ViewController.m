//
//  ViewController.m
//  DesignModeDemo
//
//  Created by koala on 2018/4/12.
//  Copyright © 2018年 koala. All rights reserved.
//


#define HEADER_HEIGHT                       ((AFTER_IOS7)?64:44)
#define AFTER_IOS7                          ([[[UIDevice currentDevice] systemVersion] intValue] >= 7)
#define APP_SCREEN_WIDTH                    [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT                   [UIScreen mainScreen].bounds.size.height


#import "ViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView   *tbView;
@property (nonatomic,strong) NSArray       *designModeArray;
@property (nonatomic,strong) NSDictionary  *modeVCDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tbView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - delegate & dataSource;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.designModeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [self.designModeArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *type = [self.designModeArray objectAtIndex:indexPath.row];
    NSString *vcName = [self.modeVCDic objectForKey:type];
    UIViewController *subViewController = [[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:subViewController animated:YES];
    
}

#pragma mark - getters and setters;

- (UITableView *)tbView{
    
    if (_tbView == nil) {
        CGRect tbRect = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - HEADER_HEIGHT);
        _tbView = [[UITableView alloc] initWithFrame:tbRect style:UITableViewStylePlain];;
        _tbView.delegate =  self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [[UIView alloc] init];
    }
    return _tbView;
}


- (NSArray *)designModeArray{
    
    if (_designModeArray == nil) {
        _designModeArray = @[@"构建者模式"];
    }
    return _designModeArray;
    
}

- (NSDictionary *)modeVCDic{
    
    if (_modeVCDic == nil) {
        
        _modeVCDic = @{@"构建者模式":@"BuilderViewController"};
    }
    return _modeVCDic;
    
}

@end
