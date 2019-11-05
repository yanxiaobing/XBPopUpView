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

	自定义弹窗的内容，作为容器的时候提供，如XBPopUpViewController
	
- `popUpContentView（@optional）`

	自定义弹窗的容器，作为基类的时候提供，如XBBasePopViewController
	
- `- (void)present;（@required）`
	
	自定义出场效果
	
- `- (void)dismiss;（@required）`

	自定义退场效果
	
- 更多属性、方法前往查看源码


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

基于常用的场景，本库已经封装了相关功能，主要有`PopUpVC`和`PopUpView`两种方式。对于复杂的自定义需求，可参照上面“实现”方案和我对常用场景的封装方案，再根据自己的项目情况进行自定义封装。

### PopUpVC（参照PopUpVCDemo）

该方式提供了`XBBasePopViewController` `XBBaseTransition`两个基类，可子类化的方式实现弹窗具体细节。

在子类VC的`init`方法中对各种弹窗的属性进行设置，在`viewDidLoaded`方法中对弹窗进行布局。然后实例化子类，并调用`-(void)showInPopUpQueue:(XBPopUpViewDidHidenBlock)didHidenBlock;`即可。

`XBBaseTransition`实现了默认弹窗动画（背景透明度渐变，popUpContentView缩放动画）。如果需要自定义弹窗动画，子类化该类，并重写方法`- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;`即可。

### PopUpView（参照PopUpViewDemo）

改方式需要自定义`UIView<XBPopUpViewDelegate>`,并通过`XBPopUpService`提供的api进行使用，并且所有弹窗属性也是通过api参数进行传递。

```
/**
 XBPopUpService
 自定义出场、退场效果
 
 @param popUpView 自定义弹窗
 @param priority 优先级
 @param lowerPriorityHidden 已经展示时，如果有更高优先级的则暂时隐藏
 @param fromType 通过根控制器或者当前控制器做present（仅针对控制器容器）
 @param emptyAreaEnabled 是否激活点击空白区域隐藏
 @param presentTransitioning 出场效果
 @param dismissTransitioning 退场效果
 */
- (void)showCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                   priority:(XBPopUpPriority)priority
        lowerPriorityHidden:(BOOL)lowerPriorityHidden
                   fromType:(XBPopUpFromType)fromType
           emptyAreaEnabled:(BOOL)emptyAreaEnabled
       presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
       dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning;
```

### 更多XBPopUpDelegate实现（参照PopUpDemo）

## Demo

https://github.com/yanxiaobing/XBPopUpView