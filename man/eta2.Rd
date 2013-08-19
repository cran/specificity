\name{eta2}
\alias{eta2}
\title{
Partial eta-squares
}
\description{
Obtain partial eta-squares from an \code{lm} object.

}
\usage{
eta2(x)
}

\arguments{
  \item{x}{
An object of class \code{lm}.
}
}
\details{
Based on type III sums of squares.
}
\value{
A \code{data.frame} containing partial eta-squares and p-values.
}

\author{ 
Rene Mottus \email{rene.mottus@ed.ac.uk}
}
\seealso{
\code{\link{specificity}}
}
\examples{
x = rnorm(1:100)
y = as.factor(rep(1:2, each=50))
a = lm(x ~ y)
eta2(a)
}

