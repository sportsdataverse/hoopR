---
title: "Intro to hoopR"
description: "Getting started with using hoopR and men's college basketball analytics."
author: "Saiem Gilani"
opengraph:
  image: 
    src: "https://github.com/saiemgilani/hoopR-data/blob/master/themes/hoopR_gh.png?raw=true"
  twitter:
    card: summary_large_image
    creator: "@saiemgilani"
output: html_document
---

<a href='https://twitter.com/saiemgilani' target='blank'><img src='https://img.shields.io/twitter/follow/saiemgilani?color=blue&amp;label=%40saiemgilani&amp;logo=twitter&amp;style=for-the-badge' alt='@saiemgilani'/></a> <a href='https://github.com/saiemgilani' target='blank'><img src='https://img.shields.io/github/followers/saiemgilani?color=eee&amp;logo=Github&amp;style=for-the-badge' alt='@saiemgilani'/></a>

We will be acquiring data from [kenpom.com](https://kenpom.com), using the `hoopR` package, created by [Saiem Gilani](https://twitter.com/saiemgilani). An active subscription to the website will be required for most of this tutorial.

### R & RStudio

This tutorial will require the use of R and RStudio. You can [follow the instructions at R Studio on how to get started](https://rstudio.com/products/rstudio/download/).

### **Using Your KenPom Subscription**

You can save your user email and password for consistent usage by adding `KP_USER = XX-YOUR-EMAIL-XX@YOUR-DOMAIN.COM` and `KP_PW = XX-YOUR-PASSWORD-XX` to your .Renviron file (easily accessed via [**`usethis::edit_r_environ()`**](https://usethis.r-lib.org/reference/edit.html)). Run [**`usethis::edit_r_environ()`**](https://usethis.r-lib.org/reference/edit.html), a new script will pop open named `.Renviron`, **THEN** paste the following in the new script that pops up (with**out** quotations)


```r
KP_USER = XX-YOUR-EMAIL-XX@YOUR-DOMAIN.COM
KP_PW = XX-YOUR-PASSWORD-XX
```

Save the script and restart your RStudio session, by clicking `Session` (in between `Plots` and `Build`) and click `Restart R` (n.b. there also exists the shortcut `Ctrl + Shift + F10` to restart your session). If set correctly, from then on you should be able to use any of the `kp_` functions without any other changes.

For less consistent usage, save your user email and password as the environment variables `KP_USER` and `KP_PW` (**with** quotations) at the beginning of every session, using a command like the following.


```r
Sys.setenv(KP_USER = "XX-YOUR-EMAIL-XX@YOUR-DOMAIN.COM")
Sys.setenv(KP_PW = "XX-YOUR-PASSWORD-XX")
```

#### **How the browser login is set**

This is the function that is evaluated to log you in to [kenpom.com](kenpom.com) to use the functions. In prior versions, this function needed to be set and passed as a parameter to the functions for usage, but is now applied under the hood within each KenPom (`kp_`) function.


```r
browser <- login(Sys.getenv("KP_USER"), Sys.getenv("KP_PW"))
```

### **Import libraries**


```r
# You can install using the pacman package using the following code:
if (!requireNamespace('pacman', quietly = TRUE)){
  install.packages('pacman')
}
#pacman::p_load_current_gh("saiemgilani/hoopR")
pacman::p_load(dplyr, ggplot2,animation,ggimage,png, glue)
```

Let's first just try to get our hands on the Pomeroy ratings for the last 10 years by using the `hoopR::kp_pomeroy_ratings()` function, which takes the following arguments:

-   `min_year` - First year of data to pull
-   `max_year` - Last year of data to pull


```r
rtgs <- kp_pomeroy_ratings(min_year = 2010, max_year = 2020)
```


```r
glimpse(rtgs)
```

```
## Rows: 3,845
## Columns: 23
## $ year            <int> 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020,~
## $ rk              <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16~
## $ team            <chr> "Kansas", "Gonzaga", "Baylor", "Dayton", "Duke", "San~
## $ conf            <chr> "B12", "WCC", "B12", "A10", "ACC", "MWC", "B10", "B10~
## $ w_l             <chr> "28-3", "31-2", "26-4", "29-2", "25-6", "30-2", "22-9~
## $ adj_em          <dbl> 30.23, 26.95, 25.49, 24.93, 24.62, 24.48, 24.03, 22.2~
## $ adj_o           <dbl> 115.8, 121.3, 113.5, 119.1, 115.7, 115.1, 115.2, 114.~
## $ adj_o_rk        <dbl> 8, 1, 17, 2, 9, 11, 10, 13, 12, 67, 18, 3, 7, 22, 32,~
## $ adj_d           <dbl> 85.5, 94.4, 88.1, 94.1, 91.1, 90.6, 91.2, 92.0, 93.1,~
## $ adj_d_rk        <dbl> 2, 43, 4, 38, 12, 10, 13, 19, 30, 3, 22, 78, 60, 21, ~
## $ adj_t           <dbl> 67.3, 71.9, 66.2, 67.6, 72.0, 64.6, 69.1, 66.2, 67.1,~
## $ adj_t_rk        <dbl> 233, 35, 277, 220, 34, 332, 130, 280, 242, 112, 245, ~
## $ luck            <dbl> 0.040, 0.050, 0.016, 0.002, -0.009, -0.008, -0.012, -~
## $ luck_rk         <dbl> 79, 50, 144, 180, 209, 204, 217, 280, 193, 260, 87, 2~
## $ sos_adj_em      <dbl> 12.66, 2.42, 10.20, 2.74, 7.28, 2.98, 12.04, 11.10, 7~
## $ sos_adj_em_rk   <dbl> 2, 109, 27, 105, 54, 101, 7, 16, 58, 15, 13, 21, 74, ~
## $ sos_opp_o       <dbl> 107.4, 103.5, 106.4, 104.1, 106.0, 105.3, 108.6, 108.~
## $ sos_opp_o_rk    <dbl> 26, 115, 39, 103, 53, 76, 5, 15, 75, 27, 16, 18, 49, ~
## $ sos_opp_d       <dbl> 94.7, 101.0, 96.2, 101.3, 98.7, 102.3, 96.5, 96.9, 98~
## $ sos_opp_d_rk    <dbl> 1, 99, 11, 105, 58, 136, 14, 20, 48, 8, 15, 22, 86, 3~
## $ ncsos_adj_em    <dbl> 9.58, -2.09, 1.38, -0.74, 2.60, -1.80, 1.83, -1.31, -~
## $ ncsos_adj_em_rk <dbl> 10, 245, 132, 203, 85, 239, 109, 225, 216, 32, 192, 8~
## $ ncaa_seed       <dbl> 1, 1, 1, 1, 3, 2, 3, 5, 4, 6, 3, 2, 5, 7, 2, 6, 4, 2,~
```

So in this vignette, we're going to plot something simple first to get a sense of how we would compare different metrics and groups. In this example, we are going to compare Florida State's adjusted efficiency margin (**AdjEM**) over the past ten years and the ACC conference average.

### **Pre-processing**

First, to keep things a bit simpler, we will first create a second and third `rtgs` dataset, one for the the filtered ACC data, and the other for Florida State. We will then combine these two to plot our data with. - `ACC`: filter by conference = 'ACC', group by the year and conference, then use `dplyr`'s `dplyr::summarize()` function, which we use to compute the \``mean()` of each of the `Year`-`Conf` combinations. However, in this case, since there is only one conference, it is essentially just a `Year` grouping for the ACC.


```r
team1 = "Florida St."
team2 = "ACC"
metric <- "adj_em" 
full_metric <- "Adjusted Efficiency Margin"
Color1 = '#782F40'
Color2 = 'navyblue'

rtgs$metric = rtgs[, metric]


rtgs_acc <- rtgs %>% 
  dplyr::filter(.data$conf == team2) %>% 
  dplyr::group_by(.data$year,.data$conf) %>% 
  dplyr::summarize(metric = mean(metric)) %>% 
  dplyr::ungroup() %>% 
  dplyr::rename(team = .data$conf)
```

```
## `summarise()` has grouped output by 'year'. You can override using the `.groups` argument.
```

```r
rtgs_fsu <- rtgs %>% 
  filter(team == team1) %>% 
  arrange(-.data$year, .data$rk) %>% 
  select(year, team, metric)

# combine the two datasets using rbind
plot_data <- rbind(rtgs_fsu, rtgs_acc)

plot_data <- rtgs_fsu %>% 
  mutate(metric_1 = metric) %>% 
  left_join(rtgs_acc %>% 
              select(.data$year, .data$metric),
            by=c("year"),suffix=c("","_2"))  
plot_data <- plot_data %>% 
  mutate(
    metric = round(metric,1),
    metric_1 = round(metric_1,1),
    metric_2 = round(metric_2,1)
  ) %>% 
  arrange(.data$year)

plot_data$Color_1 = Color1
plot_data$Color_2 = Color2
```


```r
logo_url <- "https://raw.githubusercontent.com/saiemgilani/hoopR/master/man/figures/logo.png"
z <- tempfile()
download.file(logo_url,z,mode="wb")
m <- png::readPNG(z)
img <- matrix(rgb(m[,,1],m[,,2],m[,,3], m[,,4] ), nrow=dim(m)[1]) #0.2 is alpha
rast <- grid::rasterGrob(img, interpolate = T)

plot_data <- plot_data %>% 
  mutate(logo_1 = "https://a.espncdn.com/i/teamlogos/ncaa/500/52.png?transparent=true&w=35&h=35",
         logo_2 = "https://a.espncdn.com/i/teamlogos/ncaa_conf/500/1.png?transparent=true&w=35&h=35") %>% arrange(year)
# points for plotting
x_max <- 2020
x_lab_min <- 2010 - 3
x_lab_max <- x_max + 2
x_score <- 2 + x_max
```

### **Plotting a simple animation**


```r
draw_frame <- function(year)
{
  yr <- year
  # frame data
  frm_data <- plot_data %>% 
    filter(.data$year <= yr)
  
  # output quarter changes
  if (nrow(frm_data %>% filter(year == max(.data$year))) == 1)
  {
    print(glue::glue("Plotting AdjEM in Year: {max(frm_data$year)}"))
  }
  
  # plot
  frm_plot <- frm_data %>% 
    ggplot(aes(x = year, y = metric, group=team))+
    theme_minimal()+
    geom_vline(xintercept = c(2010, x_max), color = "#5555AA")+
    geom_segment(x = 2010, xend = 2020, y = 0, yend = 0, size = 0.75)+
    geom_image(x = x_score-1, y = 24, image = frm_data$logo_1, size = 0.09, asp = 1.5)+
    geom_image(x = x_score-1, y = 2, image = frm_data$logo_2, size = 0.12, asp = 1.5)+
    geom_image(aes(x = year, y = metric_1, image = logo_1),  size = .03, asp = 1.5)+
    geom_image(aes(x = year, y = metric_2, image = logo_2),  size = .06, asp = 1.5)+
    annotation_custom(grob = rast, xmin=2017, xmax=2020, ymin=-2, ymax=-20)+
    geom_line(aes(x = year, y = metric_1, color = Color1), size = 1)+
    geom_line(aes(x = year, y = metric_2, color = Color2), size = 1)+
    scale_color_manual(values = c(Color1, Color2))+
    scale_x_continuous(breaks = seq(2010, 2020, 1),
                       minor_breaks = NULL,
                       limits = c(2009.5, x_max + 2)) +
    scale_y_continuous(breaks = seq(-20, 35, 5),
                       minor_breaks = NULL,
                       limits = c(-21, 36)) +
    coord_cartesian(clip = "off",expand = FALSE) +
    xlab("") +
    ylab("") +
    labs(title = glue::glue("{team1} and {team2} \n{full_metric} Chart - {min(plot_data$year)}-{max(plot_data$year)}"),
         caption = "Data from kenpom.com | Visualization by @SaiemGilani") +
    theme(legend.position = "none",
          axis.title.x = element_text(size = 18, family = "sans", face = 'bold', color = "#3D1A22"),
          axis.text.x = element_text(size = 12, family = "sans", face = 'bold', color = "#3D1A22"),
          axis.title.y = element_text(size = 18, family = "sans", face = 'bold', color = "#3D1A22"),
          axis.text.y = element_text(size = 14, family = "sans", face = 'bold', color = "#3D1A22"),
          plot.title = element_text(size = 16, family = "sans", face = 'bold', color = "#3D1A22"),
          plot.subtitle = element_text(size = 14, family = "sans", face = 'bold', color = "#3D1A22"),
          plot.caption = element_text(size = 14, family = "sans", face = 'bold', color = "#3D1A22",hjust=0.5),
          panel.background = element_rect(fill = "snow"),
          plot.background = element_rect(fill = "#00AFDC"))
  
  # score display 
  metric1 <- tail(frm_data$metric_1, n=1)
  metric2 <- tail(frm_data$metric_2, n=1)
  
  # clock display
  Year <- case_when(
    max(frm_data$year) == 2010 ~ "2010" ,
    max(frm_data$year) == 2011 ~ "2011" ,
    max(frm_data$year) == 2012 ~ "2012" ,
    max(frm_data$year) == 2013 ~ "2013" ,
    max(frm_data$year) == 2014 ~ "2014" ,
    max(frm_data$year) == 2015 ~ "2015" ,
    max(frm_data$year) == 2016 ~ "2016" ,
    max(frm_data$year) == 2017 ~ "2017" ,
    max(frm_data$year) == 2018 ~ "2018" ,
    max(frm_data$year) == 2019 ~ "2019" ,
    max(frm_data$year) == 2020 ~ "2020" ,
    TRUE ~ as.character(max(frm_data$year))
  )
  
  # add score and clock to plot
  frm_plot <- frm_plot + 
    annotate("text", x = x_score-1, y = 16, label = metric1, color = Color1, size = 8) +
    annotate("text", x = x_score-1, y = -4, label = metric2, color = Color2, size = 8) +
    annotate("text", x = x_score-1, y = 8, label = Year, color = "#000000", size = 7)
  
  # label key moments
  # frm_labels <- frm_data %>% 
  #   filter(text != "")
  # frm_plot <- frm_plot +
  #   geom_point(frm_labels, mapping = aes(x = Year, y = AdjEM),
  #              color = "#000000", size = 2, show.legend = FALSE) +
  #   geom_segment(frm_labels, mapping = aes(x = x_text, xend = s, y = y_text, yend = wp),
  #                linetype = "dashed", color = "#000000", na.rm=TRUE) +
  #   geom_label(frm_labels, mapping = aes(x = x_text, y = y_text, label = text),
  #              size = 3, color = "#000000", na.rm = TRUE, alpha = 0.8)
  
  # plot the frame
  plot(frm_plot, width = 12.5, height = 6.47, dpi = 500)
}
```


```r
draw_frame(2014)
```

```
## Plotting AdjEM in Year: 2014
```

![Figure](/intro-to-hoopR_files/figure-html/draw_test-1.png)<!-- -->


```r
draw_gif <- function()
{
  lapply(plot_data$year, function(year)
  { 
    draw_frame(year)
  })
  print("Plotting frames for pause")
  replicate(3, draw_frame(max(plot_data$year)))
  print("Assembling plots into a GIF")
}
```


```r
saveGIF(draw_gif(), interval = 1, movie.name = glue::glue("animated_{metric}.gif"),
        ani.width = 960, ani.height = 540, ani.res = 110)
```

```
## Plotting AdjEM in Year: 2010
```

```
## geom_path: Each group consists of only one observation. Do you need to
## adjust the group aesthetic?
## geom_path: Each group consists of only one observation. Do you need to
## adjust the group aesthetic?
```

```
## Plotting AdjEM in Year: 2011
```

```
## Plotting AdjEM in Year: 2012
```

```
## Plotting AdjEM in Year: 2013
```

```
## Plotting AdjEM in Year: 2014
```

```
## Plotting AdjEM in Year: 2015
```

```
## Plotting AdjEM in Year: 2016
```

```
## Plotting AdjEM in Year: 2017
```

```
## Plotting AdjEM in Year: 2018
```

```
## Plotting AdjEM in Year: 2019
```

```
## Plotting AdjEM in Year: 2020
```

```
## [1] "Plotting frames for pause"
## Plotting AdjEM in Year: 2020
```

```
## Plotting AdjEM in Year: 2020
```

```
## Plotting AdjEM in Year: 2020
```

```
## [1] "Assembling plots into a GIF"
```

```
## Output at: animated_adj_em.gif
```

```
## [1] TRUE
```

![Result](https://github.com/saiemgilani/hoopR/blob/master/man/figures/animated_adj_em.gif?raw=true)

![site\_navigation](http://raw.githubusercontent.com/saiemgilani/hoopR/master/man/figures/site_navigation.png)


```r
effs <- kp_efficiency(min_year = 2020, max_year = 2020)
glimpse(effs)
```

```
## Rows: 353
## Columns: 20
## $ team                   <chr> "Mississippi Valley St.", "Houston Baptist", "~
## $ conf                   <chr> "SWAC", "Slnd", "CUSA", "SEC", "MEAC", "OVC", ~
## $ adj_t                  <dbl> 77.1, 76.1, 74.9, 74.8, 74.7, 74.5, 74.0, 73.9~
## $ adj_t_rk               <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,~
## $ raw_t                  <dbl> 78.9, 77.9, 75.2, 76.1, 76.2, 75.6, 74.2, 74.6~
## $ raw_t_rk               <dbl> 1, 2, 7, 4, 3, 6, 14, 8, 9, 13, 11, 10, 19, 23~
## $ avg_poss_length_off    <dbl> 15.6, 14.8, 14.8, 15.2, 15.3, 15.8, 14.4, 14.9~
## $ avg_poss_length_off_rk <dbl> 21, 3, 2, 6, 10, 27, 1, 4, 37, 35, 18, 13, 53,~
## $ avg_poss_length_def    <dbl> 14.7, 16.0, 17.1, 16.4, 16.2, 15.8, 17.9, 17.3~
## $ avg_poss_length_def_rk <dbl> 1, 5, 111, 18, 10, 2, 302, 171, 4, 19, 40, 71,~
## $ adj_o                  <dbl> 89.8, 102.9, 101.2, 111.0, 94.1, 95.4, 105.8, ~
## $ adj_o_rk               <dbl> 345, 175, 199, 37, 323, 297, 109, 151, 335, 30~
## $ raw_o                  <dbl> 86.7, 102.5, 100.1, 106.0, 94.7, 95.7, 105.4, ~
## $ raw_o_rk               <dbl> 349, 140, 193, 71, 310, 287, 79, 123, 323, 317~
## $ adj_d                  <dbl> 117.6, 122.3, 99.1, 99.5, 117.2, 104.9, 110.5,~
## $ adj_d_rk               <dbl> 349, 352, 106, 114, 347, 230, 319, 175, 177, 3~
## $ raw_d                  <dbl> 112.7, 120.0, 97.8, 102.2, 109.6, 101.7, 107.9~
## $ raw_d_rk               <dbl> 343, 352, 107, 221, 329, 202, 317, 187, 83, 34~
## $ ncaa_seed              <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA~
## $ year                   <dbl> 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020~
```


```r
ff <-  kp_fourfactors(min_year = 2020, max_year = 2020)
glimpse(ff)
```

```
## Rows: 353
## Columns: 26
## $ team            <chr> "Gonzaga", "Dayton", "Creighton", "LSU", "Iowa", "Ore~
## $ conf            <chr> "WCC", "A10", "BE", "SEC", "B10", "P12", "WCC", "B12"~
## $ adj_t           <dbl> 71.9, 67.6, 68.3, 70.0, 70.2, 65.0, 69.5, 67.3, 72.0,~
## $ adj_t_rk        <dbl> 35, 220, 178, 84, 77, 319, 108, 233, 34, 130, 332, 24~
## $ adj_o           <dbl> 121.3, 119.1, 118.2, 118.1, 117.3, 117.1, 116.3, 115.~
## $ adj_o_rk        <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16~
## $ off_e_fg_pct    <dbl> 57.5, 59.7, 55.2, 52.7, 51.6, 54.3, 58.1, 53.7, 52.6,~
## $ off_e_fg_pct_rk <dbl> 3, 1, 6, 43, 82, 20, 2, 24, 50, 47, 14, 53, 59, 86, 4~
## $ off_to_pct      <dbl> 15.3, 18.0, 15.9, 17.6, 17.1, 17.5, 15.5, 18.7, 17.8,~
## $ off_to_pct_rk   <dbl> 12, 109, 25, 83, 60, 79, 16, 166, 95, 116, 32, 105, 1~
## $ off_or_pct      <dbl> 33.6, 26.4, 23.9, 35.1, 32.0, 32.7, 20.6, 32.6, 34.8,~
## $ off_or_pct_rk   <dbl> 30, 225, 295, 15, 52, 39, 344, 41, 17, 37, 166, 55, 7~
## $ off_ft_rate     <dbl> 38.8, 33.9, 28.8, 35.4, 34.4, 28.9, 23.4, 35.8, 35.6,~
## $ off_ft_rate_rk  <dbl> 43, 143, 274, 102, 128, 272, 343, 89, 99, 226, 284, 1~
## $ adj_d           <dbl> 94.4, 94.1, 97.3, 102.4, 98.6, 97.1, 95.6, 85.5, 91.1~
## $ adj_d_rk        <dbl> 43, 38, 78, 179, 97, 76, 60, 2, 12, 13, 10, 30, 19, 7~
## $ def_e_fg_pct    <dbl> 47.6, 46.6, 48.4, 49.4, 49.4, 47.3, 49.0, 43.7, 45.7,~
## $ def_e_fg_pct_rk <dbl> 88, 53, 122, 172, 171, 79, 143, 4, 26, 3, 18, 14, 35,~
## $ def_to_pct      <dbl> 18.4, 18.7, 17.6, 16.6, 17.6, 19.8, 18.2, 18.6, 20.2,~
## $ def_to_pct_rk   <dbl> 196, 167, 246, 302, 258, 109, 206, 178, 91, 331, 49, ~
## $ def_or_pct      <dbl> 22.7, 26.6, 30.2, 28.5, 29.5, 31.1, 24.1, 26.4, 28.0,~
## $ def_or_pct_rk   <dbl> 16, 115, 280, 197, 253, 307, 35, 108, 176, 91, 63, 50~
## $ def_ft_rate     <dbl> 21.8, 30.9, 23.4, 26.4, 26.8, 29.5, 27.9, 23.2, 30.9,~
## $ def_ft_rate_rk  <dbl> 7, 149, 13, 42, 49, 109, 65, 12, 145, 100, 140, 91, 1~
## $ ncaa_seed       <dbl> 1, 1, 2, 8, 6, 4, 5, 1, 3, 3, 2, 4, 5, 9, 2, 8, 1, 3,~
## $ year            <dbl> 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020,~
```


```r
hgts <-  kp_height(min_year = 2020, max_year = 2020)

glimpse(hgts)
```

```
## Rows: 353
## Columns: 24
## $ team          <chr> "Florida St.", "Eastern Michigan", "Gonzaga", "Washingt~
## $ conf          <chr> "ACC", "MAC", "WCC", "P12", "BE", "B10", "SEC", "BE", "~
## $ avg_hgt       <dbl> 79.0, 78.8, 78.8, 78.7, 78.7, 78.7, 78.7, 78.6, 78.6, 7~
## $ avg_hgt_rk    <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, ~
## $ eff_hgt       <dbl> 1.4, 2.3, 2.0, 1.4, 3.2, 1.9, 1.9, 0.8, 1.6, 0.9, 1.5, ~
## $ eff_hgt_rk    <dbl> 27, 4, 7, 33, 1, 14, 15, 67, 20, 59, 24, 9, 30, 5, 41, ~
## $ c_hgt         <dbl> 1.6, 2.4, 1.7, 0.5, 4.6, 1.0, 1.7, 0.0, 2.5, 2.0, 1.1, ~
## $ c_hgt_rk      <dbl> 36, 11, 35, 106, 1, 58, 32, 156, 10, 20, 50, 16, 7, 5, ~
## $ pf_hgt        <dbl> 1.2, 2.2, 2.4, 2.2, 1.9, 2.7, 2.0, 1.7, 0.7, -0.1, 1.9,~
## $ pf_hgt_rk     <dbl> 46, 4, 2, 5, 13, 1, 8, 20, 92, 187, 12, 17, 172, 26, 40~
## $ sf_hgt        <dbl> 2.3, 1.4, 1.6, 2.7, 0.8, 2.2, 1.8, 2.5, 2.2, 1.1, 1.3, ~
## $ sf_hgt_rk     <dbl> 3, 32, 23, 1, 68, 6, 18, 2, 6, 55, 35, 60, 100, 86, 17,~
## $ sg_hgt        <dbl> 2.4, 1.9, 1.5, 2.9, 0.8, 1.8, 1.7, 2.2, 3.2, 2.1, 2.7, ~
## $ sg_hgt_rk     <dbl> 5, 20, 39, 3, 95, 23, 30, 9, 1, 10, 4, 52, 10, 85, 27, ~
## $ pg_hgt        <dbl> 3.4, 2.2, 2.6, 1.2, 1.4, 1.7, 2.0, 2.5, 0.1, 3.1, 0.7, ~
## $ pg_hgt_rk     <dbl> 1, 26, 7, 91, 70, 48, 33, 8, 177, 4, 116, 68, 25, 67, 8~
## $ experience    <dbl> 1.43, 1.94, 1.83, 0.92, 2.08, 1.19, 1.36, 1.04, 1.50, 1~
## $ experience_rk <dbl> 264, 103, 141, 342, 64, 309, 286, 328, 248, 148, 310, 3~
## $ bench         <dbl> 38.5, 30.9, 23.6, 28.4, 33.0, 32.2, 22.6, 18.9, 30.8, 2~
## $ bench_rk      <dbl> 24, 155, 313, 222, 107, 127, 320, 345, 156, 247, 349, 1~
## $ continuity    <dbl> 41.4, 24.4, 23.4, 25.3, 68.9, 31.7, 55.3, 46.5, 48.3, 6~
## $ continuity_rk <dbl> 222, 323, 331, 315, 23, 297, 115, 183, 173, 37, 231, 31~
## $ ncaa_seed     <dbl> 2, NA, 1, NA, 3, NA, NA, 2, NA, 11, NA, 7, NA, NA, NA, ~
## $ year          <int> 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2~
```

#### **All Games Player stats**


```r
plyrstats <- kp_team_player_stats(team = 'Florida St.', year = 2020)


glimpse(plyrstats[[1]])
```

```
##  chr [1:24] "Significant Contributor" "Significant Contributor" ...
```

#### **Conference only Player stats**


```r
glimpse(plyrstats[[2]])
```

```
##  num [1:24] 3 23 4 1 24 2 0 15 5 31 ...
```
