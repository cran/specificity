\name{specificityLm, specificityEta2, specificityGlm}
\alias{specificity-package}
\alias{specificityLm}
\alias{specificityEta2}
\alias{specificityGlm}
\alias{specificity}
\alias{dum}
\alias{scramble}
\alias{specEta2}
\alias{specGlm}
\alias{specLm}
\alias{print.summary.specificity}
\alias{summary.specificity}
\title{
Specificity of personality trait-outcome associations
}
\description{
These functions test the specificity of personality trait-outcome associations by comparing the observed associations to those obtained using randomly created personality scales. Running the function requires item-level data from multi-trait personality questionnaires and the scoring key for the questionnaire. 

The functions are based on \code{\link{lm}} (or on \code{\link{glm}}, if \code{specificityGlm} is used).
}
\usage{
specificityLm(Formula, Data, Key, Shuffle = "exclusive", R = 1000)

specificityEta2(Formula, Data, Key, Shuffle = "exclusive", R = 1000)

specificityGlm(Formula, Data, Key, Shuffle = "exclusive", Family="binomial", 
R = 1000)
}
\arguments{
  \item{Formula}{
A formula specifying the associations to be tested. It should be something along these lines: \code{Outcome ~ .allTraits + Covar1 + Covar2}, with \code{.allTraits} being a constant that denotes all personality traits measured by the questionnaire (this argument has to be included in all formulas!), \code{Outcome} and  \code{Covar*} denoting the variables in the \code{data.frame} that are are to be treated as the dependent variable and covariates, respectively. Alternatively, if personality traits are considered as dependent variables, the order of variables can be changed as follows: \code{.allTraits ~ Outcome + Covar1 + Covar2}. Note that in either case, covariates must be listed after both \code{.allTraits} and \code{Outcome}. If personality trait scores need to be standardized, use \code{scale(.allTraits)}; if \code{Outcome} needs to be standardized, use \code{scale(Outcome)}.
}
  \item{Data}{
The \code{data.frame} to be used.
}
  \item{Key}{
A list, which has (at least) three elements: \code{start} and \code{end} denote the positions of the first and the last personality test item in the \code{data.frame}, respectively; \code{scale} is a vector that denotes the scoring key of the questionnaire (its length equals the number of items in test and each number corresponds to one trait: for example \code{scale=c(1,2,3,4,5,1,2,3,4,5)} corresponds to a 10-item questionnaire that measures five traits, with items being ordered as shown). The list may also have a fourth element (\code{names}), which is a vector containing the personality trait names (if \code{names} is not specified, trait names will be automatically generated). See the example below.
}
  \item{Shuffle}{
This specifies the way random scales are created: \code{"none"} means that no random scales are created, \code{"inclusive"} means that items to be aggregated as random scales are randomly selected from among all items, \code{"exclusive"} means that different random scales are created for each personality trait such that the items of particular traits are not included in any random scale.
}
  \item{R}{
The number of simulations.
}
  \item{Family}{
NB! Only to be specified, when \code{speficityGlm} is used. Specifies the \code{\link{family}} of the \code{glm}. See the example below.
}
}

\details{
The Five-Factor Model personality traits tend to be associated with many outcomes (non-personality variables) in a fairly similar manner and the same outcomes often have similar associations with most personality traits. In particular, socially favourable personality trait levels correlate among themselves and with desirable outcomes; therefore, we call this the 'positive-things-go-together' pattern. There are several possible reasons for this pattern. It could reflect veridical and meaningful ways in which people differ from each other, along the lines of general factor of personality or yet more general fitness factors. Alternatively, it could result from complex multivariate causal mechanisms (e.g., the crud factor) or from methodological artifacts (e.g., rating biases, poor questionnaire design). This ambiguity may limit the informativeness of particular personality trait-outcome associations. In order to quantify the level of uniqueness in particular personality trait-outcome associations, over and above the 'positive-things-go-together' pattern, we have put forward the concept of specificity, operationally defined as the probability that an observed trait-outcome association is stronger than the association of any random combination of personality questionnaire items with the outcome. This definition provides a simple specificity metric that can be used as a post hoc tool to evaluate the substantive importance of specific trait-outcome associations.

These functions facilitate carrying out such specificity analyses.

\code{specificityLm} is suitable, when the \code{Outcome} is a normally distributed continuous variable, whereas \code{specificityEta2} is suitable, when the \code{Outcome} is the independent variable and is a \code{factor}; \code{specificityGlm} is suitable, when the \code{Outcome} is the dependent variable and has a non-normal distribution.
}

\value{
\item{...}{
The result will be an object of S3 class. Typing \code{summary(...)} will display observed associations between personality trait and the outcome (the associations are calculated for all personality traits separately including all covariates as specified in the \code{Formula}), specificity estimates and adjusted effects sizes (observed effect size minus average random effect).
  }
\item{observed}{
  The observed associations of personality traits with the outcome. For a nicer output use: \code{summary(...)$true.results}
  }
  \item{random}{
  Random associations of personality traits with the outcome. For a nicer output use: \code{summary(...)$rand.results.all.traits}
  }
    \item{time}{
  The time used for running the random-scale analyses
  }

}
\references{
Mottus, R., Johnson, W., Booth, T., Deary, I. J., Konstabel, K., Realo, A., & Allik, J. (2013). Generality and specificity of personality trait scores in their associations with other phenomena. Submitted for publication}
\author{
Kenn Konstabel \email{kenn.konstabel@tai.ee}, 
Rene Mottus \email{rene.mottus@ed.ac.uk}
}
\seealso{
\code{\link{randomCorrelations}}
}
\examples{
# Create random data.frame
data = as.data.frame(matrix(ncol=63, nrow=100, sample(1:5, size=6300, replace=TRUE)))
colnames(data) = c(paste("Per", 1:60, sep=""), c("Outcome", "Covar1", "Covar2"))

# Make the Outcome categorical
data$OutcomeCat = as.factor(data$Outcome)  

# Create Keys
keyWithNames <- list(start=1, end=60, scale=rep(1:5, each=12), names=c("N","E","O","A","C"))
keyWithoutNames <- list(start=1, end=60, scale = rep(1:5, each=12))

# Run analyses
resultLm <- specificityLm(scale(.allTraits) ~ scale(Outcome) + Covar1 + Covar2, 
            Data=data, Key = keyWithNames, R=100)
resultEta2 <- specificityEta2(.allTraits ~ OutcomeCat + Covar1 + Covar2, 
              Data=data, Key = keyWithNames, R=100)
resultGlm <- specificityGlm(Outcome ~ .allTraits + Covar1 + Covar2, 
             Data=data, Family="gaussian", Key = keyWithoutNames, R=100)

# See results
summary(resultLm)
summary(resultEta2)$true.results
summary(resultGlm)$rand.results.all.traits
}

