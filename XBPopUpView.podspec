Pod::Spec.new do |s|
    s.name         = 'XBPopUpView'
    s.version      = '0.0.6'
    s.summary      = '1：添加lowerPriorityHidden字段处理展示优先还是优先级优先  2：添加fromType 字段标识是通过rootvc还是currentVC做present   3：增加相关api'
    s.homepage     = 'https://github.com/yanxiaobing/XBPopUpView'
    s.license      = 'MIT'
    s.authors      = {'XBingo' => 'dove025@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/yanxiaobing/XBPopUpView.git', :tag => s.version}
    s.requires_arc = true

    s.subspec 'PopUpProtocol' do |ss|
    ss.source_files = 'XBPopUpView/PopUpProtocol/*.{h,m}'
  end
    s.subspec 'PopUpQueue' do |ss|
    ss.source_files = 'XBPopUpView/PopUpQueue/*.{h,m}'
    ss.dependency 'XBPopUpView/PopUpProtocol'
  end
    s.subspec 'DefaultPopUp' do |ss|
    ss.source_files = 'XBPopUpView/DefaultPopUp/*.{h,m}'
    ss.dependency 'XBPopUpView/PopUpQueue'
  end
    s.source_files = 'XBPopUpView/*.{h,m}'
end
