% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ajouter_zonage.R
\name{ajouter_zonage}
\alias{ajouter_zonage}
\title{Ajouter un zonage supra communal spécifique à une table cogifiée
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}}
\usage{
ajouter_zonage(
  .data,
  zonage_df,
  var_depcom = DEPCOM,
  var_code_zone = CodeZone,
  var_type_zone = TypeZone,
  var_zone = Zone
)
}
\arguments{
\item{.data}{la table de données a filtrer}

\item{zonage_df}{le dataframe contenant le rattachement entre le code commune et le nouveau zonage}

\item{var_depcom}{le nom de la variable code commune dans zonage_df}

\item{var_code_zone}{le nom de la variable code zone dans zonage_df}

\item{var_type_zone}{le nom de la variable type zone dans zonage_df}

\item{var_zone}{le nom de la variable zone dans zonage_df}
}
\value{
Renvoie une table de données cogifiée augmentée des calculs pour ce nouveau zonage
}
\description{
Ajouter un zonage supra communal spécifique à une table cogifiée
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}
}
