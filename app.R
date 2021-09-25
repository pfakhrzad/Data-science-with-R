library(readr)
library(dplyr)
library(ggplot2)
library(shiny)
data_for_shiny <- read_csv("https://raw.githubusercontent.com/pfakhrzad/Data_visualization/main/SCM_shiny.csv")

ui <- fluidPage(
    
    titlePanel("Delayed_shipments"),
    
    # A select Input for product category
    selectInput(inputId="ID",
                label="Choose the Product category",
                choices= c("Fitness","Apparel","Golf","Footwear","Outdoors","Fan Shop","Technology","Book Shop","Discs Shop"
                           ,"Pet Shop","Health and Beauty"),
                selected="Apparel",width=200
    ),
    # Show a plot of the Delayed shipment
    plotOutput("bargraph")
)

# Define server logic required to draw a bargragh
server <- function(input, output) {
    
    output$bargraph <- renderPlot({
        SelectedData <- dplyr::filter(data_for_shiny,department==input$"ID")
        title <- "Delayed_Shipment"
        ggplot(SelectedData)+
            geom_bar(aes(order_date,fill = factor(delivery_status)))+
            ggtitle("The number of orders trend with delivery status")
        
    })
}  

# Run the application 
shinyApp(ui = ui, server = server)