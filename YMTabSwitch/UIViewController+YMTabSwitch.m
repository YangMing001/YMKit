//
//  UIViewController+YMTabSwitch.m
//  TestTableView
//
//  Created by TJ on 2017/6/12.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "UIViewController+YMTabSwitch.h"
#import <objc/runtime.h>

char static  *ymCurrentTabKey = "ym_currentTabVC";
@implementation UIViewController (YMTabSwitch)



- (void)setYm_currentVC:(UIViewController *)ym_currentVC{
    objc_setAssociatedObject(self, ymCurrentTabKey, ym_currentVC, OBJC_ASSOCIATION_RETAIN);
}

- (UIViewController *)ym_currentVC{
    return objc_getAssociatedObject(self, ymCurrentTabKey);
}

- (void)configFirstSubVC:(UIViewController *)subVC layout:(void (^)(UIViewController *childVC))layout{
    [self.view addSubview:subVC.view ];
    
    layout(subVC);
    
    self.ym_currentVC = subVC;
    //  默认,第一个视图(你会发现,全程就这一个用了addSubview)
    [self addChildViewController:subVC];
}

- (void)replaceNewController:(UIViewController *)newController
                      layout:(void(^)(UIViewController * newController))layout{
    
    [self replaceController:self.ym_currentVC
              newController:newController
                     layout:layout];
    
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController
            newController:(UIViewController *)newController
                   layout:(void(^)(UIViewController * newController))layout{
    
    if (oldController == newController) {
        return;
    }
    
    [self addChildViewController:newController];
    
    [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:(UIViewAnimationOptionTransitionNone) animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.ym_currentVC = newController;
        }else{
            self.ym_currentVC = oldController;
        }
    }];
    layout(newController);
}


@end
