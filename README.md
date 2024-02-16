# Cryptocurrency Portfolio Optimization App

## Overview
This Shiny app leverages the `crypto2` R package to fetch historical cryptocurrency data and applies portfolio optimization techniques to help users construct an optimal cryptocurrency portfolio based on historical returns.
This is a work in progress, but you can already see historical data while you wait. [check it out](https://ianmuliterno.shinyapps.io/Crypto-Market-Analysis/)

## Features (in progress)
- Fetch historical data for major cryptocurrencies.
- User-friendly interface to select cryptocurrencies and optimization parameters.
- Visualize the optimal portfolio allocation.

## Getting Started

### Prerequisites
Ensure you have R and the following R packages installed:
- `shiny`
- `crypto2`
- `dplyr`
- `PortfolioAnalytics`

### Installation
Clone this repository to your local machine:
Navigate to the app directory and open the project in RStudio. Install the required R packages by running:

```r
install.packages(c("shiny", "crypto2", "dplyr", "PortfolioAnalytics"))
```

### Running the App
In RStudio, open app.R and click on the "Run App" button, or run the following command in the R console:

```r
shiny::runApp('path/to/app')
```

### Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue.

### License
This project is licensed under the MIT License - see the LICENSE file for details.
