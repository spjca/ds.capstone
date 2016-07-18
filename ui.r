# user interface script 2.0

# load libraries
library(shiny)
library(markdown)
library(tm)
library(shinythemes)

#define UI for app
shinyUI(fluidPage(theme = shinytheme("cerulean"),
  headerPanel("Coursera Data Science Capstone"),
                   mainPanel(
                    tabsetPanel(
                      tabPanel("Text Prediction", verticalLayout(
                        #display user text entry box
                        textInput('text', "Enter English text in box below:"),
                        br(),
                        strong("Next word prediction: "),
                        textOutput("predicted.word"),
                        br(), br(),
                        strong("Entered text: "),
                        (textOutput("entered.words")))
                        ),
                      tabPanel("Instructions", HTML('
                      <p> Enter the text in the box on the "Text Prediction" tab. The predicted word will be returned
                      on the line below as well as a list of all entered words below the predicted word.
                      <p> The goal of the project is to predict the next word to be entered by the user
                      based on the previous up to 3 words entered. The text prediction is based on corpora
                      randomly gathered from blogs, news sites, and twitter provided by the class. These
                      corpora have been randomly sampled, scrubbed of foul language, and modified for usability.
                      <p> All relevant code for this project is available on my github page for review.')),
                      tabPanel("About The Author", HTML('
                      <p> Sean Jackson is a computer and data science hobbyist with minimal formal coding experience.
                      All projects are completed in free time after work and on weekends. I thank you for
                      keeping this in mind when reviewing the project.
                      <p> This project is sponsored by Coursera, Johns Hopkins University, and Swiftkey.
                      I thank them for their support in learning R. It has been enlightening.')),
                      tabPanel("Links", HTML('
                      <ol>
                        <li><a href="https://github.com/spjca">https://github.com/spjca</a></li>
                        <li><a href="https://cran.r-project.org/web/packages/tm/vignettes/tm.pdf">https://cran.r-project.org/web/packages/tm/vignettes/tm.pdf</a></li>
                        <li><a href="https://cran.r-project.org/web/packages/stringr/stringr.pdf">https://cran.r-project.org/web/packages/stringr/stringr.pdf</a></li>
                        <li><a href="https://cran.r-project.org/web/packages/stylo/stylo.pdf">https://cran.r-project.org/web/packages/stylo/stylo.pdf</a></li>
                        <li><a href="https://cran.r-project.org/web/packages/shiny/shiny.pdf">https://cran.r-project.org/web/packages/shiny/shiny.pdf</a></li>
                        <li><a href="https://cran.r-project.org/web/packages/shinythemes/shinythemes.pdf">https://cran.r-project.org/web/packages/shinythemes/shinythemes.pdf</a></li>
                        <li><a href="https://cran.r-project.org/web/packages/RWeka/RWeka.pdf">https://cran.r-project.org/web/packages/RWeka/RWeka.pdf</a></li>
                        <li><a href="https://cran.r-project.org/web/packages/dplyr/dplyr.pdf">https://cran.r-project.org/web/packages/dplyr/dplyr.pdf</a></li>
                        <li><a href="https://cran.r-project.org/web/packages/tidyr/tidyr.pdf">https://cran.r-project.org/web/packages/tidyr/tidyr.pdf</a></li>
                        <li><a href="https://www.coursera.org/specializations/jhu-data-science">https://www.coursera.org/specializations/jhu-data-science</a></li>
                        <li><a href="https://www.jhu.edu/">https://www.jhu.edu/</a></li>
                        <li><a href="https://swiftkey.com/en">https://swiftkey.com/en</a></li>
                      '))
                    )
                   )
                   
))