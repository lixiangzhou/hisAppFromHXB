//
//  HxbBase.h
//  hoomxb
//
//  Created by HXB on 2017/4/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//


//MARK: UIViewController
#import "HXBBaseViewController.h"//控制器的基类
#import "HXBBaseNavigationController.h"




//MARK: UIView
#import "HXBBaseTableView.h"//tableView
#import "HXBBaseTableViewCell.h"//tableViewCell
#import "HXBBaseCollectionView.h"//collectionView
#import "HXBBaseCollectionViewCell.h"//collectionViewCell
#import "HXBBaseWaveView.h"//关于水波的类
#import "HXBBaseToolBarView.h"//toolBarView
#import "HXBBaseScrollToolBarView.h"//关于底部几个scrollView需要左右联动，并且顶部的View可以随着底部的偏移量上下移动，中部有一个toolBarView
#import "HXBBaseTextField.h"///里面有button 和textfield

//MARK: NSObject
#import "HXBBaseHandDate.h"//关于时间处理的类
#import "HXBServerAndClientTime.h"//与服务器时间协调
#import "HXBBaseCountDownManager_lightweight.h"//倒计时 轻量级 适用于单个视图
#import "HXBBaseContDownManager.h"//关于倒计时的类 适用于tableView中有多个cell 需要计时
#import "Animatr.h"//转场动画的工具类
#import "HXBKeyBoardManager.h"///键盘观察者
