/*******************************************************************************
 * The MIT License (MIT)
 *
 * Copyright (c) 2022, Jean-David Gadina - www.xs-labs.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the Software), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

import Cocoa

public class ConfigValueViewController: NSViewController
{
    @objc public private( set ) dynamic var value:      ConfigValue
    @objc public private( set ) dynamic var values:     [ String ] = []
    @objc public private( set ) dynamic var comment:    String
    @objc public private( set ) dynamic var hasValues = false

    @objc public dynamic var alternate = false
    {
        didSet
        {
            guard let view = self.view as? BackgroundView
            else
            {
                return
            }

            view.backgroundColor = self.alternate ? NSColor.alternatingContentBackgroundColors.last : NSColor.alternatingContentBackgroundColors.first
        }
    }

    public init( value: ConfigValue )
    {
        self.value   = value
        let comments = value.comments.map { $0.dropFirst( 1 ).trimmingCharacters( in: .whitespaces ) }
        self.comment = String( comments.joined( separator: "\n" ) )

        if self.value.value == "true" || self.value.value == "false"
        {
            self.values    = [ "true", "false" ]
            self.hasValues = true
        }
        else if self.value.value == "ignore" || self.value.value == "add" || self.value.value == "remove" || self.value.value == "force" || self.value.value == "not_defined"
        {
            self.values    = [ "ignore", "add", "remove", "force", "not_defined" ]
            self.hasValues = true
        }
        else
        {
            self.values.append( self.value.value )
        }

        super.init( nibName: nil, bundle: nil )
    }

    required init?( coder: NSCoder )
    {
        nil
    }

    public override var nibName: NSNib.Name?
    {
        "ConfigValueViewController"
    }

    public override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    public func sizeToFit()
    {
        self.view.updateConstraints()
        self.view.layoutSubtreeIfNeeded()

        self.view.frame = NSRect( origin: NSPoint.zero, size: self.view.fittingSize )

        self.view.layoutSubtreeIfNeeded()
    }
}
