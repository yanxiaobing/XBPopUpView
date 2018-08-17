Pod::Spec.new do |s|
    s.name         = 'XBPopUpView'
    s.version      = '0.0.2'
    s.summary      = 'add centerOffset feature'
    s.homepage     = 'https://github.com/yanxiaobing/XBPopUpView'
    s.license      = 'MIT'
    s.authors      = {'XBingo' => 'dove025@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/yanxiaobing/XBPopUpView.git', :tag => s.version}
    s.requires_arc = true
    s.source_files     = 'XBPopUpView/*.{h,m}'
  end
    s.subspec 'PopUpProtocol' do |ss|
    ss.source_files = 'XBPopUpView/PopUpProtocol/*.{h,m}'
  end
    s.subspec 'Color' do |ss|
    ss.source_files = 'XBPopUpView/PopUpQueue/*.{h,m}'
  end
    s.subspec 'Color' do |ss|
    ss.source_files = 'XBPopUpView/DefaultPopUp/*.{h,m}'
  end