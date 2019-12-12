# UI ----------------------------------------------------------------------


ui <- dashboardPage(
  
  skin = "black",
  
  dashboardHeader(
    
    title = "Motor Sport 1975",
    titleWidth = 200
  ),  # end dashboardHeader()
  
  dashboardSidebar(
    
    HTML("<br>"),
    box(
      title = "Resources",
      #icon("laptop", lib = "font-awesome"), HTML("<a href='https://www.rostrum.blog/2019/01/18/deer-collisions/'>Shiny URL</a>"), HTML("<br>"),
      icon("info-circle", lib = "font-awesome"), HTML("<a href='https://www.rdocumentation.org/packages/MPV/versions/1.55/topics/table.b3'>Meta Data</a>"), HTML("<br>"),
      icon("github"), HTML("<a href='https://github.com/sneha-md/MotorSport1975_RShiny'>GitHub</a>"),
      width = 12,
      background = "blue",
      collapsible = TRUE, collapsed = TRUE
    ),
    box(
      title = "How to",
      width = 12,
      background = "blue",
      collapsible = TRUE, collapsed = TRUE,
      HTML("<ul>
           <li>Select from the filters menu to update the car type, transmission type and horsepower</li>
           <li>The starting selections include entire data range</li>
           <li>The analysis and car specification are in separate tabs</li>
           <li>You can zoom and drag the every plot around</li>
           <li>Hover over the plots for details</li>
           <li>Filter and sort the table by column</li>
           <li>You can download your selection with the 'Download' button</li></ul>")
      ),
    
    
    
    box(
      title = "Filters",
      width = 12,
      background = "blue",
      collapsible = TRUE, collapsed = FALSE,
      selectInput(
        inputId = "input_cartype",
        label = "Car Type",
        choices = sort(unique(sizedata$cartype)),
        multiple = TRUE,
        selected = sample(unique(sizedata$cartype), 3)
      ),
      selectInput(
        inputId = "input_tranmissiontype",
        label = "Transmission Type",
        choices = sort(unique(sizedata$transmissiontypetext)),
        multiple = TRUE,
        selected = sample(unique(sizedata$transmissiontypetext), 2)
      ),
      sliderInput(
        inputId = "input_hp",
        label = "Horsepower",
        min = 70.0, max = 225.0,
        value = c(70.0,225.0), step = 5, dragRange = TRUE
      )
    )  # end box()
      ),  # end dashboardSidebar()
  
  dashboardBody(
    
    fluidRow(
      valueBoxOutput("output_valueyear"),
      
      
      tabBox(
        
        id = "tabset1",
        width = 12,
        height = 60,
        #tabPanel(h4("Overview"), background = "black" , center(h1("Motor Sport 1975")),
        #         br(),
        #        br(),
        #       h1("Role") , h1("Car Vendor"),
        #      br(),
        #     br(),
        #    h1("Audience"), h1("Car Buyer"),
        #   br(),
        #  br(), br(), br(),
        # h4("This dashboard was created by"), h2("Sneha Mikkilineni Durga")),
        tabPanel(h4("Analysis"), tabBox(plotlyOutput("dotplot1", height = "500px", width = "550px", inline = TRUE)), tabBox(plotlyOutput("dotplot2", height = "500px", width = "550px", inline = TRUE))),
        tabPanel(h4("Car Specification"), plotlyOutput("dotplot3", height = "400px"), dataTableOutput("output_table",height = "500px"))
        
      )
    )  # end fluidRow()
  )  # end dashboardBody()
  
    )  # end of ui dashboardPage()
