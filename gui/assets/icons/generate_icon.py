"""One-off script to generate the Splasher app icon (droplet mark on a cyan
gradient, rounded-square background) as a multi-resolution .ico file.
Not part of the app build - kept for regenerating the icon later.
"""
from PIL import Image, ImageDraw


def rounded_square_mask(size, radius_ratio=0.22):
    mask = Image.new("L", (size, size), 0)
    draw = ImageDraw.Draw(mask)
    radius = int(size * radius_ratio)
    draw.rounded_rectangle([(0, 0), (size - 1, size - 1)], radius=radius, fill=255)
    return mask


def gradient_background(size, top_color, bottom_color):
    base = Image.new("RGB", (size, size), top_color)
    top = Image.new("RGB", (size, size), top_color)
    bottom = Image.new("RGB", (size, size), bottom_color)
    mask = Image.new("L", (size, size))
    mask_data = []
    for y in range(size):
        mask_data.extend([int(255 * (y / size))] * size)
    mask.putdata(mask_data)
    return Image.composite(bottom, top, mask)


def draw_droplet(draw, size):
    cx = size / 2
    r = size * 0.20
    cy_circle = size * 0.60
    top_y = size * 0.16

    draw.polygon(
        [
            (cx - r, cy_circle),
            (cx, top_y),
            (cx + r, cy_circle),
        ],
        fill="white"
    )
    draw.ellipse(
        [cx - r, cy_circle - r, cx + r, cy_circle + r],
        fill="white"
    )


def build_icon(size):
    bg = gradient_background(size, (0, 172, 193), (0, 121, 140)).convert("RGBA")
    mask = rounded_square_mask(size)
    bg.putalpha(mask)

    droplet_layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(droplet_layer)
    draw_droplet(d, size)

    out = Image.alpha_composite(bg, droplet_layer)
    return out


sizes = [16, 24, 32, 48, 64, 128, 256]
images = [build_icon(s) for s in sizes]
images[-1].save(
    "splasher.ico",
    format="ICO",
    sizes=[(s, s) for s in sizes],
)
print("Wrote splasher.ico")
