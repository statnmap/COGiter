% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/passer_au_cog_a_jour.R
\name{passer_au_cog_a_jour}
\alias{passer_au_cog_a_jour}
\title{Fonction de passage d'une table de donnée à la commune vers le millésime le plus récent du COG}
\usage{
passer_au_cog_a_jour(
  .data,
  code_commune = DEPCOM,
  aggrege = T,
  garder_info_supra = T,
  na.rm = FALSE
)
}
\arguments{
\item{.data}{la table de données à convertir}

\item{code_commune}{le nom de la variable contenant le code commune sur 5 caractères}

\item{aggrege}{booléen TRUE si on souhaite réaggréger les colonnes numériques sur la nouvelle carte communale}

\item{garder_info_supra}{booléen TRUE si on souhaite garder les informations sur les territoires supra des communes}

\item{na.rm}{argument passé à la fonction d'agrégation (sum), na.rm=FALSE par défaut}
}
\value{
Renvoie la table de données convertie pour les codes communes valide en entrée
}
\description{
Cette fonction vous permet de convertir vos dataframe ayant une variable correspondant au code commun Insee vers le COG le plus récent.
Champ : code communes de la France métropolitaine et des DROM
}
