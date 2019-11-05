# XBDevelopTools
## Color
#### Define
- `XBRandomColor`
- `XBHexAlphaColor(hex,a)`
- `XBHexColor(hex)`
- `XBRGBAColor(r,g,b,a)`
- `XBRGBColor(r,g,b)`

#### Class method

- `+ (UIColor *)xb_randomColor;`

- `+ (UIColor *)xb_colorWithHexString:(NSString *)color;`

- `+ (UIColor *)xb_colorWithHexString:(NSString *)color
                             alpha:(float)alpha;`

- `+ (UIColor *)xb_colorWithRed:(float)red
                       green:(float)green
                        blue:(float)blue;`

- `+ (UIColor *)xb_colorWithRed:(float)red
                       green:(float)green
                        blue:(float)blue
                       alpha:(float)alpha;`
                       
##Path
#### Define

- `XBDocumentPath`
- `XBLibraryPath`
- `XBCachesPath`
- `XBTempPath`
- `XBDocumentSubPath(string)`
- `XBLibrarySubPath(string)`
- `XBCachesSubPath(string)`

#### Class method

- `+  (NSString *)documentPath;`
- `+  (NSString *)libraryPath;`
- `+ (NSString *)libraryCachesPath;`
- `+  (NSString *)tempPath;`

##UIView Category
#### property
- `@property (nonatomic, assign) CGFloat xb_width;`
- `@property (nonatomic, assign) CGFloat xb_height;`
- `@property (nonatomic, assign) CGFloat xb_top;`
- `@property (nonatomic, assign) CGFloat xb_left;`
- `@property (nonatomic, assign) CGFloat xb_bottom;`
- `@property (nonatomic, assign) CGFloat xb_right;`
- `@property (nonatomic, assign) CGFloat xb_centerX;`
- `@property (nonatomic, assign) CGFloat xb_centerY;`

##Singleton
#### Define
- `XBSingletonH(methodName)`
- `XBSingletonM(methodName)`