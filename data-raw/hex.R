library(showtext)
library(hexSticker)
library(jpeg)
library(magick)

m <- png::readPNG("data-raw/logo.png")
img <- matrix(rgb(m[,,1],m[,,2],m[,,3]), nrow=dim(m)[1]) #0.2 is alpha
rast <- grid::rasterGrob(img, interpolate = T)

## use the ggplot2 example
sticker(rast, package="kenpomR",
        p_size = 20, s_x = 1, s_y = .75, s_width = 1.3, s_height = .9,
        h_fill = '#9DC5D4', h_color = '#0815B2',
        p_family = "Fjalla One",filename='data-raw/kenpomR-tile.png')

## use the ggplot2 example
sticker(rast, package="kenpomR",
        p_size = 20, s_x = 1, s_y = .75, s_width = 1.3, s_height = .9,
        p_color = "#0815B2",
        h_fill = '#9DC5D4', h_color = 'black',
        p_family = "Fjalla One",filename='data-raw/kenpomR-tile1.png')

sticker(rast, package="kenpomR",
        p_size = 20, s_x = 1, s_y = .75, s_width = 1.3, s_height = .9, p_color = "#0815B2",
        h_fill = '#9DC5D4',h_color = '#0815B2',
        p_family = "Fjalla One",filename='data-raw/kenpomR-tile2.png')

sticker(rast, package="kenpomR",
        p_size =20, s_x = 1, s_y = .75, s_width = 1.3, s_height = .9, p_color = "black",
        h_fill = '#9DC5D4',h_color = 'black',
        p_family = "Fjalla One",filename='data-raw/kenpomR-tile3.png')

sticker(rast, package="kenpomR",
        p_size = 20, s_x = 1, s_y = .75, s_width = 1.3, s_height = .9, p_color = "black",
        h_fill = '#9DC5D4',h_color = '#0815B2',
        p_family = "Fjalla One",filename='data-raw/kenpomR-tile4.png')
## Automatically use showtext to render text for future devices
showtext_auto()
# font_add_google("Fjalla One")
