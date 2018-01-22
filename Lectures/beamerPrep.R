library(knitr)

# smaller font size for chunks
opts_chunk$set(size = 'footnotesize')
options(width = 60)
options(show.signif.stars=FALSE)

# the default output hook
hook_output = knit_hooks$get('output')
knit_hooks$set(output = function(x, options) {
  if (!is.null(n <- options$out.lines)) {
    if(length(n)==1) n<-c(n,n)
    x = unlist(stringr::str_split(x, '\n'))
    len <- length(x)
    if (length(x) > n[1]) {
      # truncate the output
      x = x[intersect(seq_along(x), n)]
      if(n[1] >1) x = c('....\n', x)
      if(range(n)[2] < len) x = c(x, '....\n')
    }
    x = paste(x, collapse = '\n') # paste first n lines together
  }
  hook_output(x, options)
})

## set options

opts_chunk$set(size = "footnotesize")
opts_chunk$set(fig.align = "center")
opts_chunk$set(out.height="0.6\\textwidth")
opts_chunk$set(out.width="0.7\\textwidth")
opts_chunk$set(fig.height=6)
opts_chunk$set(fig.width=7)
opts_chunk$set(tidy=FALSE)
opts_chunk$set(prompt=FALSE)
opts_chunk$set(warning=FALSE)
opts_chunk$set(comment="#")

par(mar=c(5,4,2,2))
