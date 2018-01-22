foo <- c("33 points", "hello kitty", "drove up 95")


grepl("\\d\\s", foo)


grepl("[\\d\\s,\\s\\d]", foo)


grepl("[a-z,A-Z]", foo)


biz <- c("hello", "h", "yo", "i")

#one character
grepl("^.$", biz)


baz <- c("$$", "^", "word")

grepl("\\$", baz)



hello <- c("hello", "goodbye", "salutations")


bur <- c("1 Card", "12 cards", "cards")

#elements with only 1 digit, and one
#digit only
!(
  !grepl("\\d", bur) |
  grepl("\\d{2,}", bur) 
  )


#A progression of removing cards
gsub("card", "", bur)

gsub("card.*$", "", bur)

gsub("[C,c]ard.*$", "", bur)

gsub("[ ,][C,c]ard.*$", "", bur)



