% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ccdrAlgorithm-main.R
\name{ccdr.run}
\alias{ccdr.run}
\title{Main CCDr Algorithm}
\usage{
ccdr.run(data, betas, lambdas = NULL, lambdas.length = NULL, gamma = 2,
  error.tol = 1e-04, max.iters = NULL, alpha = 10, verbose = FALSE)
}
\arguments{
\item{data}{Data as \code{\link[sparsebnUtils]{sparsebnData}}. Must be numeric and contain no missing values.}

\item{betas}{Initial guess for the algorithm. Represents the weighted adjacency matrix
of a DAG where the algorithm will begin searching for an optimal structure.}

\item{lambdas}{(optional) Numeric vector containing a grid of lambda values (i.e. regularization
parameters) to use in the solution path. If missing, a default grid of values will be
used based on a decreasing log-scale  (see also \link{generate.lambdas}).}

\item{lambdas.length}{Integer number of values to include in the solution path. If \code{lambdas}
has also been specified, this value will be ignored. Note also that the final
solution path may contain fewer estimates (see
\code{alpha}).}

\item{gamma}{Value of concavity parameter. If \code{gamma > 0}, then the MCP will be used
with \code{gamma} as the concavity parameter. If \code{gamma < 0}, then the L1 penalty
will be used and this value is otherwise ignored.}

\item{error.tol}{Error tolerance for the algorithm, used to test for convergence.}

\item{max.iters}{Maximum number of iterations for each internal sweep.}

\item{alpha}{Threshold parameter used to terminate the algorithm whenever the number of edges in the
current DAG estimate is \code{> alpha * ncol(data)}.}

\item{verbose}{\code{TRUE / FALSE} whether or not to print out progress and summary reports.}
}
\value{
A \code{\link[sparsebnUtils]{sparsebnPath}} object.
}
\description{
Estimate a Bayesian network (directed acyclic graph) from observational data using the
CCDr algorithm as described in \href{http://jmlr.org/papers/v16/aragam15a.html}{Aragam and Zhou (2015)}.
}
\details{
Instead of producing a single estimate, this algorithm computes a solution path of estimates based
on the values supplied to \code{lambdas} or \code{lambdas.length}. The CCDr algorithm approximates
the solution to a nonconvex optimization problem using coordinate descent. Instead of AIC or BIC,
CCDr uses continuous regularization based on concave penalties such as the minimax concave penalty
(MCP).

This implementation includes two options for the penalty: (1) MCP, and (2) L1 (or Lasso). This option
is controlled by the \code{gamma} argument.
}
\examples{

\dontrun{

### Generate some random data
dat <- matrix(rnorm(1000), nrow = 20)
dat <- sparsebnData(dat, type = "continuous")

# Run with default settings
ccdr.run(data = dat)

### Optional: Adjust settings
pp <- ncol(dat)

# Initialize algorithm with a random initial value
init.betas <- matrix(0, nrow = pp, ncol = pp)
init.betas[1,2] <- init.betas[1,3] <- init.betas[4,2] <- 1

# Run with adjusted settings
ccdr.run(data = dat, betas = init.betas, lambdas.length = 10, alpha = 10, verbose = TRUE)
}

}

