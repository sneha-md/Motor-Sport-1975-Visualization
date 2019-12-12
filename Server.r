# Server ------------------------------------------------------------------


server <- function(input, output) {
  
  #colscale <- c(semantic_palette[["red"]], semantic_palette[["green"]], semantic_palette[["blue"]])
  output$dotplot1 <- renderPlotly({
    filtered_data <- sizedata %>% filter(cartype %in% input$input_cartype,
                                         `transmissiontypetext` %in% input$input_tranmissiontype,
                                         horsepower >= input$input_hp[1],
                                         horsepower <= input$input_hp[2]
    )
    
    ggplotly(ggplot(filtered_data, aes(horsepower, mpg, fill = transmissiontypetext))
             + geom_point(aes(size = weight))+ 
               theme_minimal() +  xlab("Horsepower ft-lb") + labs(fill = "") + ylab("Miles/Gallon") + ggtitle("Miles/Gallon based on Horsepower and Weight")  + theme(plot.title = element_text(hjust = 0.5))
    )
  })
  
  output$dotplot2 <- renderPlotly({
    filtered_data <- sizedata %>% filter(cartype %in% input$input_cartype,
                                         `transmissiontypetext` %in% input$input_tranmissiontype,
                                         horsepower >= input$input_hp[1],
                                         horsepower <= input$input_hp[2]
    )
    filtered_data <- aggregate(filtered_data$mpg,list(filtered_data$`transmission speeds`, filtered_data$transmissiontypetext), mean)
    
    #print(filtered_data)
    ggplotly(ggplot(data=filtered_data, aes(x=`Group.1`, y=x, fill=`Group.2` )) +
               geom_bar(stat="identity", color="black", position=position_dodge())+
               scale_fill_brewer(palette="Paired")+
               theme_minimal() + xlab("Transmission Speed") + ylab("Miles/Gallon") + ggtitle("Miles/Gallon based on Transmission Speed and Type") + labs(fill = "Transmission") + theme(plot.title = element_text(hjust = 0.5))
    )
  })
  
  # Value box - year
  output$output_valueyear <- renderValueBox({
    shinydashboard::valueBox(
      value = sizedata  %>% filter(cartype %in% input$input_cartype,
                                   `transmissiontypetext` %in% input$input_tranmissiontype,
                                   horsepower >= input$input_hp[1],
                                   horsepower <= input$input_hp[2]) %>% count() %>% pull(),
      subtitle = "Car's in the Selected Range",
      icon = icon("car", lib = "font-awesome"),
      color = "blue",
      width = 4
    )
  })  # end of renderValueBox
  
  output$dotplot3 <- renderPlotly({
    filtered_data <- sizedata %>% filter(cartype %in% input$input_cartype,
                                         `transmissiontypetext` %in% input$input_tranmissiontype,
                                         horsepower >= input$input_hp[1],
                                         horsepower <= input$input_hp[2]
    )
    
    #filtered_data_sorted <- filtered_data[order(filtered_data$mpg),]
    ggplotly(ggplot(filtered_data, aes(x=reorder(row.names(filtered_data),-mpg), y=mpg, fill = transmissiontypetext)) +
               geom_bar(stat="identity", color="black")+
               theme_minimal()  + xlab("Car ID") + ylab("Miles/Gallon") + labs(fill = "Transmission") +ggtitle("Fuel Economy of Cars") + theme(plot.title = element_text(hjust = 0.5))
             
    )
    #ggplotly(ggplot(filtered_data, aes(horsepower, mpg))
    #         + geom_point(aes(colour=factor(`transmissiontypetext`), size = weight))
    #         + scale_colour_manual(values = colscale)
    #)
  })
  
  # Interactive table with DT
  output$output_table <- renderDataTable({
    sizedata %>% arrange(desc(mpg)) %>%
      filter(
        cartype %in% input$input_cartype,
        `transmissiontypetext` %in% input$input_tranmissiontype,
        horsepower >= input$input_hp[1],
        horsepower <= input$input_hp[2]
      ) %>%
      select(
        Displacement = displacement,
        Horsepower = horsepower,
        Torque = torque,
        `Compression Ratio` = `compression ratio`,
        `Rear Axel Ratio` = `rear axle ratio`,
        Carburetors = carburetor,
        `Transmission Speed` = `transmission speeds`,
        `Length of Car` = `overall length`,
        `Width of Car` = width,
        `Weight of Car` = weight
      ) %>%
      datatable(
        filter = "top",
        extensions = c("Scroller", "Buttons"),  # scroll instead of paginate
        rownames = FALSE,  # remove row names
        style = "bootstrap",  # style
        width = "100%",  # full width
        height = "800px",
        options = list(
          deferRender = TRUE,
          # scroll
          scrollY = 300,
          scroller = TRUE,
          # button
          autoWidth = TRUE,  # column width consistent when making selections
          dom = "Blrtip",
          buttons =
            list(
              list(
                extend = "collection",
                buttons = c("csv", "excel"),  # download extension options
                text = "Download"  # text to display
              )
            )
        )  # end of options = list()
      )  # end of datatable()
  })  # end of renderDataTable()
  
}  # end of server function