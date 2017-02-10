//
//  SQLoginBoard.m
//  SQAirbnbLogin
//
//  Created by 小六 on 09/02/2017.
//  Copyright © 2017 小六. All rights reserved.
//

#import "SQLoginBoard.h"
#import "SQLoginBoxView.h"
#import "SQLoginView.h"
#import "Masonry.h"

#define WeakSelf __weak typeof(self) weakSelf = self;

@interface SQLoginBoard ()

@property (nonatomic, strong) SQLoginBoxView *platformView;
@property (nonatomic, strong) SQLoginView *loginView;

@property (nonatomic, strong) UIButton *preStepButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSMutableArray *steps;

@end

@implementation SQLoginBoard

#pragma mark - Overwrite -
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:180/255.0 blue:140/255.0 alpha:1];
    self.steps = [NSMutableArray arrayWithObject:self.platformView];
}

#pragma mark -  Build UI -

#pragma mark -  NSNofifaction -

#pragma mark -  Event -
- (void)preStep {
    UIView<SQLoginProtocol> *lastView = [self.steps lastObject];
    UIView<SQLoginProtocol> *preView = self.steps[self.steps.count - 2];
    [lastView disappear];
    [preView appear];
    [self.steps removeLastObject];
    if (self.steps.count == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.preStepButton.alpha = 0;
        }];
    }
}

#pragma mark - Get/Set -
- (SQLoginBoxView *)platformView {
    if (!_platformView) {
        _platformView = [[SQLoginBoxView alloc] init];
        __weak typeof(self) weakSelf = self;
        _platformView.showLoginView = ^{
            [weakSelf.steps addObject:weakSelf.loginView];
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.preStepButton.alpha = 1;
            }];
            [weakSelf.loginView appear];
        };
        [self.view addSubview:_platformView];
        [_platformView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(60);
            make.left.bottom.right.offset(0);
        }];
    }
    return _platformView;
}

- (SQLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[SQLoginView alloc] init];
        __weak typeof(self) weakSelf = self;

        _loginView.dismiss = ^{
            [weakSelf preStepButton];
        };
        [self.view addSubview:_loginView];
        [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(60);
            make.left.bottom.right.offset(0);
        }];
    }
    return _loginView;
}

- (UIButton *)preStepButton {
    if ( !_preStepButton ) {
        _preStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_preStepButton setTitle:@"上一步" forState:UIControlStateNormal];
        [_preStepButton addTarget:self action:@selector(preStep) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_preStepButton];
        [_preStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(30);
            make.size.mas_equalTo(CGSizeMake(60, 40));
        }];
    }
    return _preStepButton;
}

@end
