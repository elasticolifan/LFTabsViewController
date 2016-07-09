# LFTabsViewController
仿网易新闻框架


使用方法:把demo里的LFTabs文件夹拖到工程里,在需要使用的地方 #import "LFTabsViewController.h",然后初始化即可.本框架里使用了SDAutoLayout这个第三方约束布局框架,若你工程里已存在,则不要把SDAutoLayout文件夹重复导入

一个初始化方法即可创建这种多控制器滑动的框架,参数比较多,下面有说明.具体参考demo

- (instancetype)initWithSubVCArray:(NSMutableArray *)subVCArray tabsTitleArray:(NSMutableArray *)tabsTitleArray tabsTitleFontSize:(CGFloat)titleFontSize spaceBetweenTabs:(CGFloat)spaceBetweenTabs tabsHeight:(CGFloat)tabsHeight tabsSelectedScale:(CGFloat)scale pointHeight:(CGFloat)pointHeight pointViewColor:(UIColor *)pointViewColor  pointViewType:(LFPointViewType)type leftSpaceBetweenPointViewAndTitleLabel:(CGFloat)leftSpace
    topSpaceBetweenPointViewAndTitleLabel:(CGFloat)topSpace loadNextSubVCWhenScrollDidEnd:(BOOL)loadNextSubVCWhenScrollDidEnd
    tabsOrValue:(CGFloat)orValue tabsOgValue:(CGFloat)ogValue tabsObValue:(CGFloat)obValue tabsSrValue:(CGFloat)srValue tabsSgValue:(CGFloat)sgValue tabsSbValue:(CGFloat)sbValue


初始化方法参数说明:

subVCArray:子控制器数组

tabsTitleArray:滑动标签按钮标题

titleFontSize;滑动标签按钮标题字体大小

spaceBetweenTabs:标签标题之间的距离

tabsHeight:滑动标签按钮高度

scale:滑动标签按钮标题选中后放大倍数

pointHeight:按钮指示条高度(当type为一条线的样式时起作用.如果type是圆角矩形,pointView的高度由topSpace决定,pointHeight是无效的)
pointViewColor:按钮指示条颜色

type:pointView的样式,(LFPointViewTypeLine是一条线的样式,LFPointViewTypeRoundedRectangle是圆角矩形样式)

leftSpace:pointview的左边距离tab标题的距离(和pointview右边距离tab标题的距离相等)

topSpace:pointview的上边距离tab标题的距离(和pointview下边距离tab标题的距离相等,这个参数只有type是圆角矩形样式的时候起作用.如果type是一条线的时候是pointHeight决定pointView的高度)
loadNextSubVCWhenScrollDidEnd: 布尔值,为YES时,当滑动子控制器停止的时候,才加载下一个页面.为NO时,一开始滑动,就加载下一个页面.设为YES滑动时候会流畅一些
orValue:滑动标签按钮标题未选择状态颜色的R值(取值范围0~1.0)
ogValue:滑动标签按钮标题未选择状态颜色的G值(取值范围0~1.0)
obValue:滑动标签按钮标题未选择状态颜色的B值(取值范围0~1.0)

srValue:滑动标签按钮标题选择状态颜色的R值(取值范围0~1.0)
sgValue:滑动标签按钮标题选择状态颜色的G值(取值范围0~1.0)
sbValue:滑动标签按钮标题选择状态颜色的B值(取值范围0~1.0)

子控制器需要获取到主控制器(LFTabsViewController),用主控制器push到其他页面,具体看demo

如果导入到你的工程后发现上面的按钮条位置不对,请把LFTabsViewController.m文件里的124行的naviheight改成0,129行的64改为0.LFTabsScrollView.m的72行的64改为0,77行的64改为0.





