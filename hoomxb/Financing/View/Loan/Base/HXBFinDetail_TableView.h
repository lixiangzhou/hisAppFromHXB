//
//  HXBFinDetail_TableView.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HXBFinDetail_TableViewCellModel: NSObject
+ (instancetype)finDetail_TableViewCellModelWithImageName: (NSString *)imageName andOptionIitle: (NSString *)optionTitle;
- (instancetype)initWithImageName: (NSString *)imageName andOptionIitle: (NSString *)optionTitle;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *optionTitle;
@end


///理财详情页的tableView  cell里面有一个图片一个title
@interface HXBFinDetail_TableView : UITableView
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*tableViewCellModelArray;
@end



@interface HXBFinDetail_TableViewCell : UITableViewCell
@property (nonatomic,strong) HXBFinDetail_TableViewCellModel *model;
@end

