//
//  ViewController.m
//  Event-Responder
//
//  Created by itang on 2020/8/15.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)buttonTapped:(id)sender {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

   /** 拦截了UIButton 所有的
    - (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
   方法*/
   - (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{

    //block循环引用
    __weak typeof(target) weakTarget = target;

   //利用 关联对象 给UIButton 增加了一个 block
    [self  setCurrentActionBlock:^{
       //运行时 发送 消息 执行方法
        ((void (*)(void *, SEL, UIView *))objc_msgSend)((__bridge void *)(weakTarget), action , nil);
    }];
       //拦截了本身要执行的action 先执行，写下来的 xw_clicked:方法
       [super addTarget:self action:@selector(xw_clicked:) forControlEvents:controlEvents];
   }

   //拦截了按钮点击后要执行的代码
   - (void)xw_clicked:(UIButton *)sender{
     //统计
     self.btnClickedCount++;
     NSLog(@"%@ 点击 %ld次 ",[sender titleForState:UIControlStateNormal], self.btnClickedCount);
     //执行原来要执行的方法
     sender.currentActionBlock();
   }
     //在分类中增加了 btnClickedCount的 (setter 和 getter）方法，使用关联对象增加了相关的成员空间
   - (NSInteger)btnClickedCount{
       id tmp = objc_getAssociatedObject(self, &xw_btnClickedCount);
       NSNumber *number = tmp;
       return number.integerValue;
   }

   - (void)setBtnClickedCount:(NSInteger)btnClickedCount{
       objc_setAssociatedObject(self, &xw_btnClickedCount, @(btnClickedCount), OBJC_ASSOCIATION_ASSIGN);
   }

@end
