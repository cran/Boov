% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/operations.R
\name{MeshesUnion}
\alias{MeshesUnion}
\title{Meshes union}
\usage{
MeshesUnion(meshes, clean = TRUE, normals = FALSE)
}
\arguments{
\item{meshes}{a list of meshes, each being either a
\strong{rgl} mesh, or as a list with (at least) two fields:
\code{vertices} and \code{faces}; the \code{vertices} matrix can
be a numeric matrix or a matrix of \code{bigq} rational numbers
(from the \strong{gmp} package)}

\item{clean}{Boolean, whether to clean the meshes (merging
duplicated vertices, duplicated faces, removing isolated vertices);
set to \code{FALSE} if you are sure your meshes are clean, to
gain some speed}

\item{normals}{Boolean, whether to return the per-vertex normals of the
output mesh}
}
\value{
A triangle mesh given as a list with fields \code{vertices},
  \code{faces}, \code{edges}, \code{exteriorEdges}, \code{gmpvertices}
  if using \strong{gmp} meshes, and \code{normals} if \code{normals=TRUE}.
}
\description{
Computes the union of the given meshes.
}
\examples{
library(Boov)
library(rgl)

# mesh one: a cube
mesh1 <- cube3d() # (from the rgl package)

# mesh two: another cube
mesh2 <- translate3d( # (from the rgl package)
  cube3d(), 1, 1, 1
)

# compute the union
umesh <- MeshesUnion(list(mesh1, mesh2))

# plot
rglumesh <- toRGL(umesh)
open3d(windowRect = c(50, 50, 562, 562))
shade3d(rglumesh, color = "red")
plotEdges(
  vertices = umesh[["vertices"]], edges = umesh[["exteriorEdges"]],
  edgesAsTubes = TRUE, verticesAsSpheres = TRUE
)
}
