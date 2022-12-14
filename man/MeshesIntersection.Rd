% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/operations.R
\name{MeshesIntersection}
\alias{MeshesIntersection}
\title{Meshes intersection}
\usage{
MeshesIntersection(meshes, clean = TRUE, normals = FALSE)
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
Computes the intersection of the given meshes.
}
\examples{
library(Boov)
library(rgl)

# mesh one: truncated icosahedron; we triangulate it for plotting
library(PolygonSoup)
mesh1 <- Mesh(
  mesh = truncatedIcosahedron,
  triangulate = TRUE, normals = FALSE
)

# mesh two: a cube
mesh2 <- translate3d( # (from the rgl package)
  cube3d(), 2, 0, 0
)

# compute the intersection
inter <- MeshesIntersection(list(mesh1, mesh2))

# plot
rglmesh1 <- toRGL(mesh1)
rglinter <- toRGL(inter)
open3d(windowRect = c(50, 50, 562, 562))
shade3d(rglmesh1, color = "yellow", alpha = 0.2)
shade3d(mesh2, color = "cyan", alpha = 0.2)
shade3d(rglinter, color = "red")
plotEdges(
  vertices = inter[["vertices"]], edges = inter[["exteriorEdges"]],
  edgesAsTubes = FALSE, lwd = 3, verticesAsSpheres = FALSE
)

# other example, with 'gmp' rational numbers ####
library(Boov)
library(gmp)
library(rgl)

cube <- cube3d()

rglmesh1 <- cube
mesh1 <-
  list(vertices = t(cube[["vb"]][-4L, ]), faces = t(cube[["ib"]]))
mesh1[["vertices"]] <- as.bigq(mesh1[["vertices"]])

rotMatrix <- t(cbind( # pi/3 around a great diagonal
  as.bigq(c(2, -1, 2), c(3, 3, 3)),
  as.bigq(c(2, 2, -1), c(3, 3, 3)),
  as.bigq(c(-1, 2, 2), c(3, 3, 3))
))
mesh2 <-
  list(vertices = t(cube[["vb"]][-4L, ]), faces = t(cube[["ib"]]))
mesh2[["vertices"]] <- as.bigq(mesh2[["vertices"]]) \%*\% rotMatrix
rglmesh2 <- rotate3d(cube, pi/3, 1, 1, 1)

inter <- MeshesIntersection(list(mesh1, mesh2))
# perfect vertices:
inter[["gmpVertices"]]
rglinter <- toRGL(inter)

open3d(windowRect = c(50, 50, 562, 562), zoom = 0.9)
bg3d("#363940")
shade3d(rglmesh1, color = "yellow", alpha = 0.2)
shade3d(rglmesh2, color = "orange", alpha = 0.2)
shade3d(rglinter, color = "hotpink")
plotEdges(
  inter[["vertices"]], inter[["exteriorEdges"]],
  only = inter[["exteriorVertices"]],
  color = "firebrick",
  tubesRadius = 0.05, spheresRadius = 0.07
)
}
