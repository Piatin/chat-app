//
//  ChatTableViewController.m
//  chatapp
//
//  Created by Kako on 2015/02/27.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import "ChatTableViewController.h"
#import "CustomCell.h"

@interface ChatTableViewController ()<UITextViewDelegate>{
    NSMutableArray *_objects;
    NSArray *_textArray;    // 追加
    CustomCell *_stubCell;  // 追加
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTextViewHeight;

- (IBAction)tapButton:(id)sender;
@property bool isObserving;



@end

@implementation ChatTableViewController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //キーボード表示/非表示のObserver登録
    if (!_isObserving) {
        NSNotificationCenter *noticication = [NSNotificationCenter defaultCenter];
        [noticication addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [noticication addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        //Observerになってるフラグをたてとく
        _isObserving = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //Observer解除
    if (_isObserving) {
        NSNotificationCenter *noticication = [NSNotificationCenter defaultCenter];
        [noticication removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [noticication removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        
        //Observerになってるフラグをおとす
        _isObserving = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    _stubCell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"]; // 追加
    
    // 追加
    // 文字列の配列の作成
    _textArray = @[
                   @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sodales diam sed turpis mattis dictum. In laoreet porta eleifend. Ut eu nibh sit amet est iaculis faucibus.",
                   @"initWithBitmapDataPlanes:pixelsWide:pixelsHigh:bitsPerSample:samplesPerPixel:hasAlpha:isPlanar:colorSpaceName:bitmapFormat:bytesPerRow:bitsPerPixel:",
                   @"祇辻飴葛蛸鯖鰯噌庖箸",
                   @"Nam in vehicula mi.",
                   @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
                   @"あのイーハトーヴォの\nすきとおった風、\n夏でも底に冷たさをもつ青いそら、\nうつくしい森で飾られたモーリオ市、\n郊外のぎらぎらひかる草の波。",
                   ];
    
     _textView.delegate = self;
}


- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    // 追加
    // データ作成
    int dataIndex = arc4random() % _textArray.count;
    NSString *string = _textArray[dataIndex];
    NSDate *date = [NSDate date];
    NSDictionary *dataDictionary = @{@"string": string, @"date":date};
    
    // データ挿入
    [_objects insertObject:dataDictionary atIndex:0];   // 修正
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *customCell = (CustomCell *)cell;
    
    // メインラベルに文字列を設定
    NSDictionary *dataDictionary = _objects[indexPath.row];
    customCell.mainLabel.text = dataDictionary[@"string"];
    
    // サブラベルに文字列を設定
    NSDate *date = dataDictionary[@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日 HH時mm分ss秒";
    customCell.nameLabel.text = [dateFormatter stringFromDate:date];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];    // 追加
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 計測用のプロパティ"_stubCell"を使って高さを計算する
    [self configureCell:_stubCell atIndexPath:indexPath];
    [_stubCell layoutSubviews];
    CGFloat height = [_stubCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height + 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//キーボード表示
-(void) keyboardWillShow:(NSNotification *) notification{
    
    // キーボードのサイズを取得
    CGRect rect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // キーボード表示アニメーションのdurationを取得
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // キーボード表示と同じdurationのアニメーションでViewを移動させる
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -rect.size.height);
        self.view.transform = transform;
    } completion:NULL];
}

//キーボード非表示
-(void) keyboardWillHide:(NSNotification *)notification{
    
    // キーボード表示アニメーションのduration
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Viewを元に戻す
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:NULL];
}



//TextViewの入力や変更が終わると呼ばれる
- (void)textViewDidChange:(UITextView *)textView {
    
    //高さを広げる上限を指定
    float maxHeight = 80.0;
    
    if(_textView.frame.size.height < maxHeight){
        
        //高さを変更
        CGSize size = [_textView sizeThatFits:_textView.frame.size];
        _constraintTextViewHeight.constant = size.height;
    }
}

//TextViewの入力が始まると呼ばれる
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //カーソルの位置へスクロールさせる
    [_textView scrollRangeToVisible:_textView.selectedRange];
    
    return YES;
}

- (IBAction)tapButton:(id)sender {
    
    //TextViewを元に戻す
    _textView.text = nil;
    CGSize size = [_textView sizeThatFits:_textView.frame.size];
    _constraintTextViewHeight.constant = size.height;
    
    //キーボードを閉じる
    [_textView resignFirstResponder];
}
@end

