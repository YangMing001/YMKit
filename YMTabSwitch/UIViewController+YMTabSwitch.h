//
//  UIViewController+YMTabSwitch.h
//  TestTableView
//
//  Created by TJ on 2017/6/12.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import <UIKit/UIKit.h>

/********
 #import "ViewController.h"
 #import <Masonry.h>
 #import "VC1.h"
 #import "VC2.h"
 #import "VC3.h"
 
 #import "UIViewController+ChildVCs.h"
 
 interface ViewController ()
 
 @property (nonatomic,strong) UIView *navView;
 @property (nonatomic,strong) UISegmentedControl *segCon;
 
 @property (nonatomic,strong) VC1 *tableView1;
 @property (nonatomic,strong) VC2 *tableView2;
 @property (nonatomic,strong) VC3 *tableView3;
 
 
 
 
 @end
 
 @implementation ViewController
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 [self prepareUI];
 
 }
 
 - (void)prepareUI{
 
 // nav bar
 [self.view addSubview:self.navView];
 [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.with.left.and.right.equalTo(self.view);
 make.height.mas_equalTo(@(64));
 }];
 
 //选择器
 [self.view addSubview:self.segCon ];
 [self.segCon mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.navView.mas_bottom).mas_offset(10);
 make.centerX.mas_equalTo(self.view.mas_centerX);
 make.left.equalTo(self.view).mas_offset(20);
 make.height.mas_equalTo(33);
 }];
 self.segCon.selectedSegmentIndex = 0;
 [self.segCon addTarget:self action:@selector(segSelect:) forControlEvents:(UIControlEventValueChanged)];
 
 
 [self configFirstSubVC:self.tableView1 layout:^(UIViewController *childVC) {
 
 [childVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.and.right.with.bottom.equalTo(self.view);
 make.top.mas_equalTo(self.segCon.mas_bottom).mas_offset(10);
 }];
 
 }];
 
 }
 
 - (void)segSelect:(UISegmentedControl *)segControl{
 switch (segControl.selectedSegmentIndex) {
 case 0:{
 [self replaceSubVC:self.tableView1 ];
 }
 break;
 case 1:{
 [self replaceSubVC:self.tableView2 ];
 }
 break;
 case 2:{
 [self replaceSubVC:self.tableView3 ];
 }
 break;
 
 default:
 break;
 }
 }
 
 - (void)replaceSubVC:(UIViewController*)subVC{
 
 [self replaceNewController:subVC layout:^(UIViewController *newController) {
 [self.view addSubview:newController.view ];
 [newController.view mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.and.right.with.bottom.equalTo(self.view);
 make.top.mas_equalTo(self.segCon.mas_bottom).mas_offset(10);
 }];
 }];
 }
 
 #pragma mark - Setter And Getter
 - (UIView *)navView{
 if (!_navView) {
 _navView = [[UIView alloc] initWithFrame:CGRectZero];
 _navView.backgroundColor = [UIColor redColor];
 }
 return _navView;
 }
 
 - (UISegmentedControl *)segCon{
 if (!_segCon) {
 _segCon = [[UISegmentedControl alloc] initWithItems:@[@"111",@"222",@"333"]];
 _segCon.tintColor = [UIColor purpleColor];
 _segCon.backgroundColor = [UIColor whiteColor];
 }
 return _segCon;
 }
 
 - (VC1 *)tableView1{
 if (!_tableView1) {
 _tableView1 = [[VC1 alloc] init];
 }
 return _tableView1;
 }
 
 - (VC2 *)tableView2{
 if (!_tableView2) {
 _tableView2 = [[VC2 alloc] init];
 }
 return _tableView2;
 }
 
 - (VC3 *)tableView3{
 if (!_tableView3) {
 _tableView3 = [[VC3 alloc] init];
 }
 return _tableView3;
 }
 
 
 
 @end
 
 **/



@interface UIViewController (YMTabSwitch)

@property (nonatomic,strong) UIViewController *ym_currentVC;


- (void)configFirstSubVC:(UIViewController *)subVC
                  layout:(void (^)(UIViewController *childVC))layout;



//  切换各个标签内容
- (void)replaceNewController:(UIViewController *)newController
                      layout:(void(^)(UIViewController * newController))layout;

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController
            newController:(UIViewController *)newController
                   layout:(void(^)(UIViewController * newController))layout;

@end
