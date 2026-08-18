"""One-off script to build the Splasher app icon (fish mascot) as a
multi-resolution .ico file from the source artwork in Downloads.
Not part of the app build - kept for regenerating the icon later.
"""
from PIL import Image

SOURCE = r"C:\Users\noege\Downloads\splasher.png"
sizes = [16, 24, 32, 48, 64, 128, 256]

source = Image.open(SOURCE).convert("RGBA")

images = []
for size in sizes:
    canvas = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    resized = source.copy()
    resized.thumbnail((size, size), Image.LANCZOS)
    x = (size - resized.width) // 2
    y = (size - resized.height) // 2
    canvas.paste(resized, (x, y), resized)
    images.append(canvas)

images[-1].save(
    "splasher.ico",
    format="ICO",
    sizes=[(s, s) for s in sizes],
)
print("Wrote splasher.ico")
