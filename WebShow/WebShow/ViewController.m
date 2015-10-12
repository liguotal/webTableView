//
//  ViewController.m
//  WebShow
//
//  Created by li on 15/10/12.
//  Copyright © 2015年 li. All rights reserved.
//

#import "ViewController.h"
#import "WebTableCell.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showData];
}
-(void)showData
{
    _webView=[[UIWebView alloc] init];
    _webView.backgroundColor = [UIColor redColor];
    _webView.opaque = NO;
    CGRect frame = _webView.frame;
    frame.size.width = self.view.frame.size.width;
    frame.size.height = 2000;
    _webView.frame = frame;
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0]    setBounces:NO];
    _webView.backgroundColor=[UIColor greenColor];
    NSURL *url=[NSURL URLWithString:@"http://mp.weixin.qq.com/s?__biz=MjM5NTkxOTgzMw==&mid=207446064&idx=1&sn=c9cd355460f4a44712a7e590ee378355#rd"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];  //根据自己的具体情况设置，我的html文件在document目录，链接也是在这个目录上开始
    NSURL *baseUrl = [NSURL fileURLWithPath:documentsDir];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [_webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseUrl];
    [_webView setUserInteractionEnabled:YES];
    _webView.delegate=self;
    _webView.scalesPageToFit =YES;
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 54;
    }else {
        NSInteger height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] integerValue];
        return height;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier=@"WebTableCell";
    WebTableCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell=[[NSBundle mainBundle] loadNibNamed:@"WebTableCell" owner:self options:nil].lastObject;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
   cell.textLabel.text=@"显示cell";
    if (indexPath.section==0) {
        [[cell contentView] addSubview:_webView];
        _webView.scrollView.scrollEnabled = NO;
        _webView.scalesPageToFit = YES;
    }
    return cell;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGRect frame = webView.frame;
    frame.size = [webView sizeThatFits:CGSizeZero];
    frame.size.height += 20.0f;// additional padding to push it off the bottom edge
    webView.frame = frame;
    webView.delegate = nil;
    UITableViewCell *cell=[_tableViewShow cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.contentView addSubview: _webView];
    cell.contentView.frame = frame;
    [cell setNeedsLayout];
    webView.alpha = 1.0f;
    [self.tableViewShow beginUpdates];
    [self.tableViewShow reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableViewShow endUpdates];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
