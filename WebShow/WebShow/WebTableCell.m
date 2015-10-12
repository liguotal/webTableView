//
//  WebTableCell.m
//  WebShow
//
//  Created by li on 15/10/12.
//  Copyright © 2015年 li. All rights reserved.
//

#import "WebTableCell.h"

@implementation WebTableCell

- (void)awakeFromNib {
    // Initialization code
}
//====个人保存数据 ，对于本项目没什么用=======================
-(void)showData
{
    UIWebView *_webView=[[UIWebView alloc] init];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = NO;
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0]    setBounces:NO];
    //_webView.userInteractionEnabled=NO;
    _webView.backgroundColor=[UIColor greenColor];
    NSURL *url=[NSURL URLWithString:@"http://detail.tmall.com/item.htm?id=39433450073"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0] ;   //根据自己的具体情况设置，我的html文件在document目录，链接也是在这个目录上开始
    NSURL *baseUrl = [NSURL fileURLWithPath:documentsDir];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [_webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseUrl];
    
    [_webView setUserInteractionEnabled:YES];
    _webView.delegate=self;
    _webView.scalesPageToFit =YES;
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    [self addSubview:_webView];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    int subtract=[self webHeight:webView];
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    webView.frame = CGRectMake(0,0,320,30+height-subtract);
    NSLog(@"height: %@", [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]);
    
    self.frame=CGRectMake(0, 0, 320,30+ height-subtract);
    NSLog(@"height: %f", self.frame.size.height);
    if (_webShowSuccess) {
        _webShowSuccess();
    }
}
-(int)webHeight:(UIWebView*)webView
{
    int height=0;
    NSMutableArray *oldArray=[[NSMutableArray alloc] init];
    NSMutableArray *newArray=[[NSMutableArray alloc] init];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.images.length"];
    for (int i=0; i<[title intValue]; i++) {
        NSString *imageH = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.images[%d].height",i]];
        [oldArray addObject:imageH];
    }
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=340;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (1);"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    for (int i=0; i<[title intValue]; i++) {
        NSString *imageH = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.images[%d].height",i]];
        [newArray addObject:imageH];
    }
    
    for (int i=0; i<newArray.count; i++) {
        int height1 =[[oldArray objectAtIndex:i] intValue];
        int height2=[[newArray objectAtIndex:i] intValue];
        int height3=height1-height2;
        height+=height3;
    }
    if (newArray.count>=2) {
        height+=30;
    }
    return height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
