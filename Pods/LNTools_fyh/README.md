# LNTools_fyh

库的结构：
LNTools_fyh为主库，下属有N个子库

1. LNImageBrowser：图片浏览器，类似QQ空间的图片点击浏览，基于KSPhotoBrowser的二次封装
2. LNRefresh：上拉加载下拉刷新，基于MJRefresh的二次封装
3. LNViewExtension：常用的UI类的一些扩展。
4. LNProgressHUD：加载框，基于MBProgressHUD的封装


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 安装

如果只需要用到其中一个:
```
pod 'LNTools_fyh/LNImageBrowser'
pod 'LNTools_fyh/LNProgressHUD'
pod 'LNTools_fyh/LNRefresh'
pod 'LNTools_fyh/LNViewExtension'
```

如果用到了所有功能，就直接：
	
```
pod 'LNTools_fyh'
```

## 调用

### 1.LNImageBrowser：
调用图片浏览器时，首先需要遵守一个协议：LNImageBrowserProtocol，遵守协议后还需要实现一个变量ln_imageViewsContainer，在他的get方法里面返回你想要展示的图片的imageview的父视图，记住，一定要是imageView的父视图。比如，你在一个变量名为showView的view上添加了五个imageView，这个时候你想点击其中一个图片进行浏览所有图片。可以这样做

```
class TestVc: UIViewController, LNImageBrowserProtocol {
    
    var ln_imageViewsContainer: UIView {
        return  showView
    }
}
```

完成之后，只要你点击其中一个图片，就会进入浏览模式

还有两个可选方法，用于长按图片之后的可选操作。

1. 这个方法返回值两个, defult就是默认模式，只有一个保存图片，coustom就是自定义了

```
 @objc public enum LNLongpressMode : Int {
    case defult = 0
    case coustom
}
func ln_browserLongpressStyle() -> LNLongpressMode
```

2.基于第一个方法选择coustom，可在第二个方法里面做操作

```
    func ln_browser(browser:UIViewController, didLongpressedAt index:NSInteger, with image:UIImage)

```


### 2.LNProgressHUD
这是一个对UIViewcontroller的扩展， 引入之后在控制器直接使用：

```
self.ly_showTextHub(text: "ok")

func ly_showTextHub(text: String?, autoHideDelay: TimeInterval = 0) -> Void {
        DispatchQueue.ly_mbph_runInMain {
            self.lyHud.textHud(text: text)
            self.view.addSubview(self.lyHud)
            self.lyHud.progress = 0.5
            self.lyHud.show(animated: true, autoHideDelay: autoHideDelay)
        }
    }
    
    func ly_showSuccessHud(text: String?, autoHideDelay: TimeInterval = 0) -> Void {
        DispatchQueue.ly_mbph_runInMain {
            
            self.lyHud.successHud(text: text)
            self.view.addSubview(self.lyHud)
            self.lyHud.isUserInteractionEnabled = false
            self.lyHud.show(animated: true, autoHideDelay: autoHideDelay)
        }
    }
    
    func ly_showFailureHud(text: String?, autoHideDelay: TimeInterval = 0) -> Void {
        DispatchQueue.ly_mbph_runInMain {
            self.lyHud.failureHud(text: text)
            self.view.addSubview(self.lyHud)
            self.lyHud.show(animated: true, autoHideDelay: autoHideDelay)
        }
    }
    
    func ly_hideHud(afterDelay delay: TimeInterval = 0) -> Void {
        DispatchQueue.ly_mbph_runInMain {
            self.lyHud.hide(animated: true, afterDelay: delay)
        }
    }
    
    func ly_showProgressHud(progress:CGFloat, text:String?, style:Int = 1, autoHideDelay: TimeInterval = 0)  {
        
        DispatchQueue.ly_mbph_runInMain {
            self.lyHud.progressHud(proress: progress, text: text, style: style)
            self.view.addSubview(self.lyHud)
            self.lyHud.show(animated: true, autoHideDelay: autoHideDelay)
        }
    }
```


### 3.LNViewExtension
一些常用的UI类的扩展



## Author

diligencefu@sina.com, 付耀辉

## License

LNTools_fyh is available under the MIT license. See the LICENSE file for more info.
