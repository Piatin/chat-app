//
//  TestViewController.m
//  chatapp
//
//  Created by Kako on 2015/02/28.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// viewが表示される時に呼び出されますー
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // キーボードの表示・非表示はNotificationCenterから通知されますよっと
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// viewが非表示になる時に呼び出されますー
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // ちゃんとremoveしてあげましょーねー
    // 今回はviewWillAppearで通知登録なので、viewWillDisappearでやりますよっと
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// キーボードが表示される時に呼び出されますー
- (void)keyboardWillShow:(NSNotification *)notification {
    // キーボードのサイズ
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // キーボード表示アニメーションのduration
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // viewのアニメーション
    [UIView animateWithDuration:duration animations:^{
        // ここをframeわざわざ計算してる人おおいですねー
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -keyboardRect.size.height);
        self.view.transform = transform;
    } completion:NULL];
}

// キーボードが非表示になる時に呼び出されますー
- (void)keyboardWillHide:(NSNotification *)notification {
    // キーボード表示アニメーションのduration
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self) _self = self;
    [UIView animateWithDuration:duration animations:^{
        // tranformで動かしておけば、戻すときはこれだけ！
        _self.view.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

// キーボードで確定がタップされた時に呼び出されますー
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // キーボードを非表示にするにはこう！
    [textField resignFirstResponder];
    return YES;
}

@end

