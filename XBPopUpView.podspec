Pod::Spec.new do |popup|
    popup.name         = 'XBPopUpView'
    popup.version      = '1.1.1'
    popup.summary      = '1：添加依赖VC弹出机制'
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
