Pod::Spec.new do |s|
    s.name         = 'XBPopUpView'
    s.version      = '0.0.1'
    s.summary      = 'Easy to use XBPopUpView'
    s.homepage     = 'https://github.com/yanxiaobing/XBPopUpView'
    s.license      = 'MIT'
    s.authors      = {'XBingo' => 'dove025@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/yanxiaobing/XBPopUpView.git', :tag => s.version}
    s.requires_arc = true
    s.source_files     = 'XBPopUpView/**/*.{h,m}'
end