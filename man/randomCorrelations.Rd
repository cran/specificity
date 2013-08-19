\name{randomCorrelations}
\alias{randomCorrelations}
\title{
Correlations between randomly generated scales
}
\description{
In social sciences, everything tends to correlate with everything, possibly due to theoretically uninteresting reasons. In questionnaire data, this general tendency of everything being correlated with everything is supplemented by the spurious intercorrelations resulting from all sorts of common method artefacts. This means that the null hypotheses (e.g., \emph{r} = 0) is almost never correct, even when there are no meaningful and substantively interpretable associations between variables and this is probably especially true for questionnaire-based research. Therefore, the correct baseline hypotheses against which researchers can compare their associations of interest is often not the null-hypotheses. One way to guesstimate the true baseline hypotheses is to calculate associations between randomly generated variables; in questionnaires such variables can be created by randomly aggregating items into scales. This function is suitable when associations between two randomly generated scales might provide a proper baseline hypothesis against which substantive hypotheses can be tested (the \code{\link{specificity}} function is suitable for guesstimating associations of random scales with external phenomena, which are not based on questionnaires).
}
\usage{
randomCorrelations(Data1, Data2 = NULL, n.items, R = 1000, 
complete.overlap = FALSE, item.overlap = FALSE, trait.overlap = TRUE, 
Key1 = NULL, Key2 = NULL)  
}

\arguments{
  \item{Data1}{
The \code{data.frame} from which random scales are drawn.
}
  \item{Data2}{
An optional \code{data.frame}. Used when the random scales are drawn from independent data (e.g., self-ratings and informant-ratings, measurements at two different time-points, or parallel forms of a questionnaire).
}
  \item{n.items}{
  The number of items in random scales.
}
  \item{R}{
  The number of random scale correlations to be calculated.
}
\item{complete.overlap}{
Logical. If \code{TRUE}, there will be complete overlap in the items included in the two random scales (overrides other "overlap" arguments).
}
  \item{item.overlap}{
  Logical. If \code{TRUE}, item overlap between random scales is allowed (but not granted). If \code{FALSE}, item overlap between random scales is precluded.
}
  \item{trait.overlap}{
    Logical. If \code{TRUE}, two random scales to be correlated may have items from the same trait. If \code{FALSE} the two random scales are formed from the items belonging to different traits (the pool of traits is randomly split into two subpools and items from the two random scales are drawn from the two independent subpools). Requires the scoring key (\code{Key1}) to be provided. 
}
\item{Key1}{
The scoring key, indicating the trait-belonging of the items provided in \code{Data1} (and also in \code{Data2} if this was provided and \code{Key2} was not provided). Its length equals the number of items in \code{Data1} (and also in \code{Data2} if this was provided and \code{Key2} was not provided) and each number corresponds to one trait: for example \code{scale=c(1,2,3,4,5,1,2,3,4,5)} corresponds to a 10-item questionnaire that measures five traits, with items being ordered as shown).
}
\item{Key2}{
Another scoring key, indicating the trait-belonging of the items provided in \code{Data2}. Only necessary when the scoring keys differ for \code{Data1} and \code{Data2} (e.g., these are different questionnaires measuring the same traits). Note that \code{Key1} and \code{Key2} should contain the same elements (i.e., the datasets should contain items of the sam traits), otherwise trait overalps should be allowed and no scoring keys should be passed to the function.
}
}

\details{
This function can be used to guesstimate random associations between variables of the same dataset. Likewise, and perhaps more interestingly, it can also be used to guesstimate random associations between different datasets. For example, the unspecific associations (that are not bound to any substantive trait) between self-reported and informant-reported variables can be estimated, or between data from two different time-points or from parallel questionnaires. Overlaps in item content can be allowed or ruled out. Likewise, overlaps in trait content can be allowed or prohibited. Note that when the two dataset reflect different traits, item and trait overlaps can be allowed and there is no point in passing \code{Key1} and \code{Key2} to the function.
}

\value{
A vector containing the requested random correlations.
}

\author{ 
Rene Mottus \email{rene.mottus@ed.ac.uk}
}
\seealso{
\code{\link{specificity}}
}
\examples{
# Create random data.frames

selfratings <- as.data.frame(matrix(ncol=60, nrow=100, 
sample(1:5, size=600, replace=TRUE)))
informantratings <- as.data.frame(matrix(ncol=60, nrow=100, 
sample(1:5, size=600, replace=TRUE)))
colnames(selfratings) <- colnames(informantratings) <- c(paste("Per", 1:60, sep=""))
other.inventory <- as.data.frame(matrix(ncol=100, nrow=100, 
sample(1:5, size=1000, replace=TRUE)))

# Create key (optional)

key1 <- rep(1:5, each=12) 
key2 <- rep(1:5, each=20) 


# Analyses

rcAcrossRaters = randomCorrelations(Data1 = selfratings, Data2 = informantratings, 
n.items = 12, R=100, item.overlap = FALSE, trait.overlap = TRUE)  

rcWithinRaters = randomCorrelations(Data1 = selfratings, Data2 = informantratings, 
n.items = 12, R=100, item.overlap = FALSE, trait.overlap = FALSE, Key1 = key1)  

rcAcrossQuestionnaire = randomCorrelations(Data1 = selfratings, Data2 = other.inventory, 
n.items = 12, R=100, item.overlap = FALSE, trait.overlap = FALSE, Key1 = key1, Key2 = key2) 

rcCompleteOverlap = randomCorrelations(Data1 = selfratings, Data2 = informantratings,
n.items = 12, R=100, complete.overlap = TRUE)  

# Look at the results

summary(rcAcrossRaters)
summary(rcWithinRaters)
summary(rcAcrossQuestionnaire)
summary(rcCompleteOverlap)

}

