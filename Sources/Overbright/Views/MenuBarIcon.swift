import AppKit

/// Template images let macOS handle contrast in the menu bar.
enum MenuBarIcon {
    static let on = make("""
    <path fill="black" stroke="none" fill-rule="evenodd"
          d="M12 1 15.2 4.3 19.8 4.2 19.7 8.8 23 12 19.7 15.2 19.8 19.8
             15.2 19.7 12 23 8.8 19.7 4.2 19.8 4.3 15.2 1 12 4.3 8.8
             4.2 4.2 8.8 4.3Z M19 12a7 7 0 1 0-14 0 7 7 0 1 0 14 0Z"/>
    <circle cx="12" cy="12" r="5.8" fill="black" stroke="none"/>
    """)
    static let off = symbol("moon.fill")

    // Lucide triangle-alert (ISC licence, see LICENSES/lucide.txt).
    static let problem = make("""
    <path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3"/><path d="M12 9v4"/><path d="M12 17h.01"/>
    """)

    private static func symbol(_ name: String) -> NSImage {
        let configuration = NSImage.SymbolConfiguration(pointSize: 15, weight: .medium)
        let glyph = NSImage(systemSymbolName: name, accessibilityDescription: AppInfo.name)?
            .withSymbolConfiguration(configuration) ?? NSImage()
        let image = NSImage(size: NSSize(width: 18, height: 18), flipped: false) { rect in
            let scale = min(1, rect.width / max(1, glyph.size.width), rect.height / max(1, glyph.size.height))
            let size = NSSize(width: glyph.size.width * scale, height: glyph.size.height * scale)
            glyph.draw(in: NSRect(x: rect.midX - size.width / 2, y: rect.midY - size.height / 2,
                                  width: size.width, height: size.height))
            return true
        }
        image.isTemplate = true
        image.accessibilityDescription = AppInfo.name
        return image
    }

    private static func make(_ body: String, size: CGFloat = 18) -> NSImage {
        let svg = """
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" \
        stroke="black" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round">\(body)</svg>
        """
        let image = NSImage(data: Data(svg.utf8)) ?? NSImage()
        image.size = NSSize(width: size, height: size)
        image.isTemplate = true
        image.accessibilityDescription = AppInfo.name
        return image
    }
}
