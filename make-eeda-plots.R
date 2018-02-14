
#### make-eeda-plots.R --------------------------------



#### Required packages --------------------------------

require(dplyr)
require(tidyr)
require(rlang)
require(forcats)
require(janitor)
# Need to have the development version of ggplot2 installed
# devtools::install_github("tidyverse/ggplot2", force = TRUE)
require(ggplot2)
require(ggpubr)
require(scales)


#### Continuous variables plot --------------------------------

plot_cont <-
  function(data,
           var,
           binw_select = "FD",
           facet = NULL,
           subtitle = "Histogram (left), summary statistics (right)") {
    
    var_enq <- rlang::enquo(var)
    var_name <- rlang::quo_name(var_enq)
    
    
    #### histogram --------------------------------
    
    ## Make the base plot ----------------
    
    p <- ggplot(data = data, ggplot2::aes_(x = var_enq))
    
    
    ## Different ways to calc bin width ----------------
    
    if (binw_select == "FD") {
      p <- p + geom_histogram(
        stat = "bin",
        binwidth = function(x) {
          pretty(range(x), n = nclass.FD(x), min.n = 1, right = TRUE)[2] -
            pretty(range(x), n = nclass.FD(x), min.n = 1, right = TRUE)[1]
        },
        alpha = 0.8,
        fill = "steelblue",
        colour = "black"
      )
    } else if (binw_select == "Sturges") {
      p <- p + geom_histogram(
        stat = "bin",
        binwidth = function(x) {
          pretty(range(x), n = nclass.Sturges(x), min.n = 1, right = TRUE)[2] -
            pretty(range(x), n = nclass.Sturges(x), min.n = 1, right = TRUE)[1]
        },
        alpha = 0.8,
        fill = "steelblue",
        colour = "black"
      )
    } else if (binw_select == "Scott") {
      p <- p + geom_histogram(
        stat = "bin",
        binwidth = function(x) {
          pretty(range(x), n = nclass.scott(x), min.n = 1, right = TRUE)[2] -
            pretty(range(x), n = nclass.scott(x), min.n = 1, right = TRUE)[1]
        },
        alpha = 0.8,
        fill = "steelblue",
        colour = "black"
      )
    } else if (binw_select == "Hadley") {
      p <- p + geom_histogram(
        stat = "bin",
        # This is the same as Sturges... Maybe Scott...
        binwidth = function(x) {
          2 * IQR(x) / (length(x) ^ (1 / 3))
        },
        alpha = 0.8,
        fill = "steelblue",
        colour = "black"
      )
    }
    
    
    ## Add a theme and title ----------------
    
    p <- p +
      theme_minimal() +
      labs(
        title = var_name,
        x = "",
        subtitle = subtitle
      )
    
    
    ## facet_wrap if applicable ----------------
    
    if (!is.null(facet)) {
      p <- p + facet_wrap(as.formula(paste("~ ", facet)), scales = "free_x")
    }
    
    
    ## Plot it ----------------
    
    # print(p)
    # return(p)
    
    # plot it later ...
    
    
    #### Table of stats --------------------------------
    
    tbl <- data %>%
      dplyr::select(!! var_enq) %>%
      tidyr::gather(key = variable, value = value) %>%
      group_by(variable) %>%
      summarise(
        missing = sum(is.na(value)),
        observed = sum(!is.na(value)),
        n = n(),
        mean = round(mean(value, na.rm = TRUE), digits = 3),
        sd = round(sd(value, na.rm = TRUE), digits = 3),
        range = max(value, na.rm = TRUE) - min(value, na.rm = TRUE),
        min = min(value, na.rm = TRUE),
        p25 = quantile(value, probs = 0.25, na.rm = TRUE),
        median = quantile(value, probs = 0.5, na.rm = TRUE),
        p75 = quantile(value, probs = 0.75, na.rm = TRUE),
        max = max(value, na.rm = TRUE)
      ) %>%
      mutate_all(.tbl = ., .funs = funs(as.character)) %>%
      dplyr::select(-variable) %>%
      tidyr::gather(key = stat, value = value) %>%
      ggpubr::ggtexttable(rows = NULL, theme = ttheme(base_size = 9))
    
    
    #### Finish plot --------------------------------
    
    ## Arrange the plots on the same page ----------------
    
    ggpubr::ggarrange(
      p, tbl,
      # ncol = 1, nrow = 2,
      # heights = c(1, 0.5))
      ncol = 2, nrow = 1
    )
  }

#### Example of plot_cont() --------------------------------

# plot_cont(data = mtcars, var = disp)
# plot_cont(data = mtcars, var = disp, binw_select = "Sturges")
# plot_cont(data = mtcars, var = disp, binw_select = "Scott")
# plot_cont(data = mtcars, var = disp, binw_select = "Hadley")
# 
# ggplot(data = mtcars, aes(x = disp)) + 
#   geom_histogram()
# 
# ggplot(data = mtcars, aes(x = disp)) + 
#   geom_histogram(aes(y = ..density..), binwidth = 40) + 
#   geom_density()


#### Categorical variables plot --------------------------------

plot_categ <-
  function(data,
           var,
           subtitle = paste0("Bar graph (left), ", 
                             "frequency table of top 5 levels (right)")) {
    
    
    var_enq <- rlang::enquo(var)
    var_name <- rlang::quo_name(var_enq)
    
    
    #### Bar graph --------------------------------
    
    p2 <- data %>%
      # ggplot(data = data,
      #   ggplot2::aes_(x = forcats::fct_rev(forcats::fct_infreq(var_quo)))) +
      mutate(
        !! var_name := as.character(!! var_enq), 
        !! var_name := factor(!! var_enq), 
        !! var_name := forcats::fct_explicit_na(!! var_enq, na_level = "NA"),
        !! var_name := forcats::fct_infreq(!! var_enq),
        !! var_name := forcats::fct_rev(!! var_enq)
      ) %>%
      ggplot(
        data = .,
        ggplot2::aes_(x = var_enq)
      ) +
      geom_bar(
        stat = "count",
        width = 0.75,
        alpha = 0.8,
        fill = "gray33",
        color = "black"
      ) +
      theme_minimal() +
      # theme(axis.text.x = element_text(angle = 90,
      #                                  hjust = 1,
      #                                  vjust = 0.5
      #                                  )) +
      # scale_x_discrete(label = function(x) abbreviate(x, minlength=7)) +
      scale_x_discrete(label = function(x) strtrim(x, width = 10)) +
      scale_y_continuous(
        breaks = scales::pretty_breaks(),
        # expand = c(0, 0),
        expand = c(0, 0, 0.05, 0),
        limits = c(0, NA)
      ) +
      labs(
        title = var_name,
        subtitle = subtitle,
        x = ""
      ) +
      coord_flip()
    
    
    #### Frequency table --------------------------------
    
    tbl2 <- data %>%
      mutate(
        !! var_name := as.character(!! var_enq), 
        !! var_name := factor(!! var_enq), 
        !! var_name := forcats::fct_lump(!! var_enq, n = 5),
        !! var_name := forcats::fct_infreq(!! var_enq)
      ) %>%
      janitor::tabyl(!! var_enq) %>%
      janitor::adorn_totals("row") %>%
      janitor::adorn_pct_formatting() %>% 
      dplyr::rename("levels" = !! names(.[1])) %>% 
      mutate(levels = strtrim(levels, width = 36)) %>% 
      ggpubr::ggtexttable(rows = NULL, theme = ttheme(base_size = 9))
    
    
    #### Finish plot --------------------------------
    
    ## Arrange the plots on the same page ----------------
    
    ggpubr::ggarrange(
      p2, tbl2,
      # ncol = 1, nrow = 2,
      # heights = c(1, 0.5))
      ncol = 2, nrow = 1
    )
  }

#### Example of plot_categ() --------------------------------

# mt2 <- mtcars %>% 
#   mutate(cyl = factor(cyl))
# 
# plot_categ(data = mt2, var = cyl)

# dplyr::glimpse(mtcars)


#### make_plots() --------------------------------

# prints a plot depending on the class of variables

make_plots <- function(data){
  
  for (i in names(data)) {
    if (class(data[[i]])[1] %in% c("ordered", "factor", "character"))
      print(plot_categ(data = data, var = !! sym(i)))
    else if (class(data[[i]])[1] %in% c("numeric", "integer"))
      print(plot_cont(data = data, var = !! sym(i)))
    else
      print(paste0("Variable is of class `", class(data[[i]]), "`, 
                   not a `factor` or `numeric`."))
  }
}


#### Example of make_plots() --------------------------------

# make_plots(diamonds)


