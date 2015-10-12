//
//  ViewController.h
//  WebShow
//
//  Created by li on 15/10/12.
//  Copyright © 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView *tableViewShow;
@property (nonatomic,strong) UIWebView *webView;
@end

