Pod::Spec.new do |popup|
    popup.name         = 'XBPopUpView'
    popup.version      = '1.0.0'
    popup.summary      = '1：增加通过VC基类的方式将弹窗的相关属性内聚，便于使用约束布局，简化使用  2：整理文件目录，调整工程结构'
    popup.homepage     = 'https://github.com/yanxiaobing/XBPopUpView'
    popup.license      = 'MIT'
    popup.authors      = {'XBingo' => 'dove025@qq.com'}
    popup.platform     = :ios, '8.0'
    popup.source       = {:git => 'https://github.com/yanxiaobing/XBPopUpView.git', :tag => popup.version}
    popup.requires_arc = true
    
    popup.subspec 'PopUpCommon' do |common|
    common.source_files = 'XBPopUpView/PopUpCommon/*.{h,m}'
  end
    popup.subspec 'PopUpVC' do |vc|
    vc.source_files = 'XBPopUpView/PopUpVC/*.{h,m}'
    vc.dependency 'XBPopUpView/PopUpCommon'
  end
    popup.subspec 'PopUpView' do |view|
    view.source_files = 'XBPopUpView/PopUpView/*.{h,m}'
    view.dependency 'XBPopUpView/PopUpCommon'
  end
end
