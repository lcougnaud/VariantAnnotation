\name{VcfFile}
\Rdversion{1.1}
\docType{class}
\alias{VcfFile-class}
\alias{VcfFileList-class}
% con/destructors
\alias{VcfFile}
\alias{VcfFileList}
\alias{vcfFields,missing-method}
\alias{vcfFields,character-method}
\alias{vcfFields,VcfFile-method}
\alias{vcfFields,VcfFileList-method}

\title{Manipulate Variant Call Format (Vcf) files.}

\description{

  Use \code{VcfFile()} to create a reference to a Vcf file (and its
  index). Once opened, the reference remains open across calls to
  methods, avoiding costly index re-loading.

  \code{VcfFileList()} provides a convenient way of managing a list of
  \code{VcfFile} instances.

}

\section{usage}{
  
  ## Constructors
  \describe{
    \item{}{
      VcfFile(file, index = paste(file, "tbi", sep="."), ...,
      yieldSize=NA_integer_)
    }
    \item{}{
      VcfFileList(..., yieldSize=NA_integer_)
    }
  }
  
  ## Accessors
  \describe{
    \item{}{
      index(object)}
    \item{}{
      path(object, ...)}
    \item{}{
      isOpen(con, rw="")}
    \item{}{
      yieldSize(object, ...)}
    \item{}{
      yieldSize(object, ...) <- value}
    \item{}{
      show(object)
    }
  }
  
  ## Opening / closing
  \describe{
    \item{}{
      open(con, ...)}
    \item{}{
      close(con, ...)}
  }
  
  ## method
  \describe{
    \item{}{
      vcfFields(object)
    }
  }
}

\section{arguments}{
  \itemize{
    \item{con}{An instance of \code{VcfFile}.}

    \item{file}{A character(1) vector to the Vcf file
      path; can be remote (http://, ftp://).}

    \item{index}{A character(1) vector of the Vcf file index (.tbi file).}

    \item{yieldSize}{Number of records to yield each time the file is read
      from using \code{scanVcf} or \code{readVcf}.}

    \item{...}{Additional arguments. For \code{VcfFileList}, this can
      either be a single character vector of paths to Vcf files, or
      several instances of \code{VcfFile} objects.}

    \item{rw}{character() indicating mode of file.}
  }
}

\section{Objects from the Class}{

  Objects are created by calls of the form \code{VcfFile()}.

}

\section{Fields}{

  \code{VcfFile} and \code{VcfFileList} classes inherit fields from the
  \code{\linkS4class{TabixFile}} and \code{\linkS4class{TabixFileList}} 
  classes.
}

\section{Functions and methods}{

  \code{VcfFile} and \code{VcfFileList} classes inherit methods from the
  \code{\linkS4class{TabixFile}} and \code{\linkS4class{TabixFileList}} 
  classes.

  ## Opening / closing:
  \describe{
    \item{open}{Opens the (local or remote) \code{path} and
      \code{index}. Returns a \code{VcfFile} instance. 
      \code{yieldSize} determines the number of records parsed during
      each call to \code{scanVcf} or \code{readVcf}; \code{NA} indicates 
      that all records are to be parsed.}

    \item{close}{Closes the \code{VcfFile} \code{con}; returning
      (invisibly) the updated \code{VcfFile}. The instance may be
      re-opened with \code{open.VcfFile}.}
  }

  ## Accessors: 
  \describe{
    \item{path}{Returns a character(1) vector of the Vcf path name.}

    \item{index}{Returns a character(1) vector of Vcf index (tabix file) name.}

    \item{yieldSize, yieldSize<-}{Return or set an integer(1) vector
      indicating yield size.}
  }

  ## Methods:
  \describe{
    \item{vcfFields}{
      Returns a \code{\link[IRanges]{CharacterList}} of all available VCF
      fields, with names of \code{fixed}, \code{info}, \code{geno} and
      \code{samples} indicating the four categories. Each element is a
      character() vector of available VCF field names within each
      category. It works for both local and remote vcf file. 
    }
  }
}

\author{Valerie Obenchain}

\examples{
fl <- system.file("extdata", "chr7-sub.vcf.gz", package="VariantAnnotation",
                  mustWork=TRUE)
vcffile <- VcfFile(fl)
vcffile
vcfFields(fl)
vcfFields(vcffile)

param <- GRanges("7", IRanges(c(55000000,  55900000), width=10000))
vcf <- readVcf(vcffile, "hg19", param=param)
dim(vcf)

## `vcfFields` also works for remote vcf filepath.  
\dontrun{
chr22url <- "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"
vcfFields(chr22url)
}
}

\keyword{classes}
