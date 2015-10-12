//
//  WebTableCell.h
//  WebShow
//
//  Created by li on 15/10/12.
//  Copyright © 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebTableCell : UITableViewCell<UIWebViewDelegate>
@property (nonatomic, copy) void (^webShowSuccess)();
@end
