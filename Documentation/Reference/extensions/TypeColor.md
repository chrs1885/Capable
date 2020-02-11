**EXTENSION**

# `TypeColor`

## Methods
### `getContrastRatio(forTextColor:onBackgroundColor:)`

```swift
public class func getContrastRatio(forTextColor textColor: TypeColor, onBackgroundColor backgroundColor: TypeColor) -> CGFloat?
```

> Calculates the color ratio for a text color on a background color.
>
> - Parameters:
>     - textColor: The text color.
>     - backgroundColor: The background color.
>
> - Returns: The contrast ratio for a given pair of colors.
>
> - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.
>
> - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.

#### Parameters

| Name | Description |
| ---- | ----------- |
| textColor | The text color. |
| backgroundColor | The background color. |

### `getTextColor(onBackgroundColor:)`

```swift
public class func getTextColor(onBackgroundColor backgroundColor: TypeColor) -> TypeColor?
```

> Returns the text color with the highest contrast (black or white) for a given background color.
>
> - Parameters:
>    - backgroundColor: The background color.
>
> - Returns: A color that has the highest contrast with the given background color.
>
> - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.
>
> - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.

#### Parameters

| Name | Description |
| ---- | ----------- |
| backgroundColor | The background color. |

### `getTextColor(fromColors:withFont:onBackgroundColor:conformanceLevel:)`

```swift
public class func getTextColor(fromColors colors: [TypeColor], withFont font: TypeFont, onBackgroundColor backgroundColor: TypeColor, conformanceLevel: ConformanceLevel = .AA) -> TypeColor?
```

> Calculates the contrast ratio of a given list of text colors and a background color. The first color that conforms to the conformance level defined gets returned. The default conformance level is .AA.
>
> - Parameters:
>     - colors: A list of possible text colors.
>     - font: The font used for the text.
>     - backgroundColor: The background color that the text should be displayed on.
>     - conformanceLevel: The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA.
>
> - Returns: The first color that conforms to the conformance level defined or `nil` if non of the colors provided passed.
>
> - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.
>
> - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.

#### Parameters

| Name | Description |
| ---- | ----------- |
| colors | A list of possible text colors. |
| font | The font used for the text. |
| backgroundColor | The background color that the text should be displayed on. |
| conformanceLevel | The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA. |

### `getTextColor(onBackgroundImage:imageArea:)`

```swift
public class func getTextColor(onBackgroundImage image: TypeImage, imageArea: ImageArea = .full) -> TypeColor?
```

> Returns the text color with the highest contrast (black or white) for a specific area of given background image.
>
> - Parameters:
> - backgroundImage: The background image.
> - imageArea: The area of the image that is used as the text background. Defaults to .full.
>
> - Returns: A color that has the highest contrast with the given background image.
>
> - Note: For the background image, the alpha component is ignored.
>
> - Warning: This function will also return `nil` if the image is corrupted.

### `getTextColor(fromColors:withFont:onBackgroundImage:imageArea:conformanceLevel:)`

```swift
public class func getTextColor(fromColors colors: [TypeColor], withFont font: TypeFont, onBackgroundImage image: TypeImage, imageArea: ImageArea = .full, conformanceLevel: ConformanceLevel = .AA) -> TypeColor?
```

> Calculates the contrast ratio of a given list of text colors and a specific area of given background image. The first color that conforms to the conformance level defined gets returned. The default conformance level is .AA.
>
> - Parameters:
> - colors: A list of possible text colors.
> - font: The font used for the text.
> - backgroundImage: The background image that the text should be displayed on.
> - imageArea: The area of the image that is used as the text background. Defaults to .full.
> - conformanceLevel: The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA.
>
> - Returns: The first color that conforms to the conformance level defined or `nil` if non of the colors provided passed.
>
> - Note: Semi-transparent text colors will be blended with the background color. However, for the background image, the alpha component is ignored.
>
> - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.

### `getBackgroundColor(forTextColor:)`

```swift
public class func getBackgroundColor(forTextColor textColor: TypeColor) -> TypeColor?
```

> Returns the background color with the highest contrast (black or white) for a given text color.
>
> - Parameters:
>    - textColor: The textColor color.
>
> - Returns: A color that has the highest contrast with the given text color.
>
> - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.
>
> - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.

#### Parameters

| Name | Description |
| ---- | ----------- |
| textColor | The textColor color. |

### `getBackgroundColor(fromColors:forTextColor:withFont:conformanceLevel:)`

```swift
public class func getBackgroundColor(fromColors colors: [TypeColor], forTextColor textColor: TypeColor, withFont font: TypeFont, conformanceLevel: ConformanceLevel = .AA) -> TypeColor?
```

> Calculates the contrast ratio of a given list of background colors and a text color. The first color that conforms to the conformance level defined gets returned. The default conformance level is .AA.
>
> - Parameters:
>     - colors: A list of possible background colors.
>     - textColor: The text color that should be used.
>     - font: The font used for the text.
>     - conformanceLevel: The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA.
>
> - Returns: The first color that conforms to the conformance level defined or `nil` if non of the colors provided passed.
>
> - Note: Semi-transparent text colors will be blended with the background color. However, for background colors, the alpha component is ignored.
>
> - Warning: This function will also return `nil` if any input color is not convertable to the sRGB color space.

#### Parameters

| Name | Description |
| ---- | ----------- |
| colors | A list of possible background colors. |
| textColor | The text color that should be used. |
| font | The font used for the text. |
| conformanceLevel | The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA. |