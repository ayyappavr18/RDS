library(shiny)

# Define UI for data upload app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Uploading Files"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a file ----
      fileInput("file1", "Choose CSV File",
                multiple = FALSE,
                accept = c("rds",
                           "Rdata")),
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Data file ----
      tableOutput("contents"),verbatimTextOutput("print")
      
    )
    
  )
)

# Define server logic to read selected file ----
server <- function(input, output) {
  
  v <- reactiveValues()  # store values to be changed by observers
  
  
  
  # Observer for uploaded file
  observe({
    inFile = input$file1
    # if (is.null(inFile)) return(NULL)
    # values$data <- read.csv(inFile$datapath)
    if(is.null(inFile)){
      return(NULL)
    }  
    else {
      v$data <-readRDS(inFile$datapath)
    }
    
  })
  output$contents<-renderTable({
    v$data
  })
  output$print<-renderPrint({
    summary(v$data)
  })
}

# Create Shiny app ----
shinyApp(ui, server)

