// Copyright (c) RxSwiftCommunity

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import RxCocoa
import RxSwift
import UIKit

public typealias ScreenEdgePanConfiguration = Configuration<UIScreenEdgePanGestureRecognizer>
public typealias ScreenEdgePanControlEvent = ControlEvent<UIScreenEdgePanGestureRecognizer>
public typealias ScreenEdgePanObservable = Observable<UIScreenEdgePanGestureRecognizer>

extension Factory where Gesture == GestureRecognizer {
    /**
     Returns an `AnyFactory` for `UIScreenEdgePanGestureRecognizer`
     - parameter configuration: A closure that allows to fully configure the gesture recognizer
     */
    public static func screenEdgePan(configuration: ScreenEdgePanConfiguration? = nil) -> AnyFactory {
        return make(configuration: configuration).abstracted()
    }
}

extension Reactive where Base: View {
    /**
     Returns an observable `UIScreenEdgePanGestureRecognizer` events sequence
     - parameter configuration: A closure that allows to fully configure the gesture recognizer
     */
    public func screenEdgePanGesture(configuration: ScreenEdgePanConfiguration? = nil) -> ScreenEdgePanControlEvent {
        return gesture(make(configuration: configuration))
    }
}
