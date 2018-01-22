####Some data for the tidyr lecture

mammals_bad <- data.frame(site = c(1,2,3,1,2,3,1,2,3), 
                          taxon = c('Suncus etruscus', NA, NA, 
                                    'Sorex cinereus', NA, NA,
                                    'Myotis nigricans', NA, NA),
                          density = c(6.2, 3.2, 6.2, 5.2, 11.0, 1.2, 9.4, 9.6, 9.3)
)




mammals <- data.frame(site = c(1,1,2,3,3,3), 
                      taxon = c('Suncus etruscus', 'Sorex cinereus', 
                                'Myotis nigricans', 'Notiosorex crawfordi', 
                                'Scuncus etruscus', 'Myotis nigricans'),
                      density = c(6.2, 5.2, 11.0, 1.2, 9.4, 9.6)
)