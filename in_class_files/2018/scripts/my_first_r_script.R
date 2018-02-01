###########################################
#' my_first_r_script.R
#'
#' @description This is my first R script
#'
#' @author Jarrett Byrnes
#'
#' @changelog
#' 2018-02-01 First created this file
#'
#' @etherpad https://etherpad.wikimedia.org/p/biol355-r-intro
###########################################

#-----------------------
# Basic arithmetic ####
#-----------------------

3 + 4

3 - 4

-1

3 * 4

3 / 4

3^4

((35*8) / 12)^3 - 120 * 0

#---------------
# Functions ####
#---------------
log10(25)

sqrt(4)

abs(-10)

log(10, base = 10)

log(10, base = 57)

##Functions and help
?log
??"arcsine"


#---------------
# Weird values ####
#---------------

NA #missing value

NA + 1

NaN #not a number

NaN + 1

Inf #infinite
-Inf #negative infinity

3/0
log(0)
Inf + 1

NULL #null value present

#---------------
# Variables ####
#---------------

#examples already in here
log

pi

foo <- 3
foo

4 -> bar
bar

#overwriting
foo <- 5

#nuke foo
rm(foo)
#release memory
gc()

foo

#reinstantiate foo
foo <- 3

foo + 3

foo + bar

log(foo)

#stupid parlor trick
biz <- baz <- 5

#-----------------------
#More than a number ####
#-----------------------

class(3)
class(NULL)
class(Inf)
class(bar)
class(log)

#characters
class("hello")
"hellow"

hello <- "hello"
hello + 3
log(hello)

#Boolean
TRUE
FALSE

foo == 3
foo == bar
foo != bar
foo <= bar
foo >= bar
foo > bar
foo < bar

TRUE + 3
TRUE + TRUE + FALSE
(TRUE + TRUE + FALSE) == 3

#-------------
#Vectors ####
#---------------
