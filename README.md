# XBPopUpView

## 背景
 移动端开发中不可避免会遇到很多弹窗的需求，虽然iOS系统提供了多种警告、提示等弹窗样式，但是很难满足天马星空的自定义弹窗需求。
 
 抛开开发者实现自定义弹窗的成本不说，随着项目中自定义弹窗样式的增多，对于弹窗的管理也很麻烦，特别对于多人合作开发，大家的实现思路，代码风格什么的难免有所不同，就更加加剧了这种管理难的现象。
 
 为了体验更好，通常不应该让两个弹窗同时展示，但是可能各个业务模块是不同的人负责的，对于多个弹窗的展示时机不好把握，沟通成本也很高，而且效果不一定好。
 
 因此，在开发项目的过程中很有必要做一套弹窗的规范。
 
## 分析
#### 问题：

- 1：多人开发实现思路、代码风格不同不利于管理；
- 2：多人开发不好把控弹窗时机；
- 3：自定义场景多，样式多；

#### 方案
- 1：定义好弹窗实现的协议，所有的自定义弹窗必须满足该协议
- 2：建立一个弹窗管理队列，所有的弹窗都添加到这个队列中，并根据优先级展示
- 3：弹窗框架要支持强大的自定义需求

## 实现

### 代理协议

#### XBPopUpDelegate

- `priority（@required）`

	用于控制弹窗优先级
	
- `popUpView（@optional）`

	`popUpView`为自定义弹窗的内容，通常在使用`UIViewController`做弹窗容器的时候需要传入该值；
	
- `- (void)present;（@required）`
	
	自定义出场效果
	
- `- (void)dismiss;（@required）`

	自定义退场效果



#### XBPopUpViewDelegate

- `willHideBlock`

	通过该block将自定义视图的关闭事件传给容器 
	
- `didHidenBlock`

	回调隐藏事件，外部业务根据这个做相应处理


#### 所有弹窗都必须遵守`XBPopUpDelegate`，所有的`popUpView`都必须遵守`XBPopUpViewDelegate`。

### 弹窗队列`XBPopUpQueue`

- `popUpQueue`

	自己维护`NSMutableArray`类型的队列，需要展示的弹窗添加到该队列中
	
- `- (void)addView:(id<XBPopUpDelegate>)popUpView;`

	将遵守了XBPopUpDelegate协议的弹窗添加到队列中
- `- (void)removeView:(id<XBPopUpDelegate>)popUpView;`

	移除队列中已展示的弹窗
	
## 使用

#### XBPopUpViewController

相关类：`XBPopUpViewController`、`XBTestPopView`、`XBDefaultTransition`
 
`+ (void)showDefaultCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                  emptyAreaEnabled:(BOOL)emptyAreaEnabled
                          priority:(XBPopUpPriority)priority;`

 
`+ (void)showDefaultPresentPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
            emptyAreaEnabled:(BOOL)emptyAreaEnabled
                    priority:(XBPopUpPriority)priority;`

`+ (void)showCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
     emptyAreaEnabled:(BOOL)emptyAreaEnabled
             priority:(XBPopUpPriority)priority
 presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
 dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning;`

#### XBTestPopUpView

参照`XBTestPopUpView`
	

## Demo

https://github.com/yanxiaobing/XBPopUpView