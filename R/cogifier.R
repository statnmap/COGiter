#' Consolider une table de données à la commune à tous les échelles du cog
#'
#' @param .data la table de données à convertir
#' @param code_commune le nom de la variable contenant le code commune sur 5 charactères
#' @param communes booléen TRUE si on souhaite des données à la commune
#' @param epci booléen TRUE si on souhaite des données à l'epci
#' @param departements booléen TRUE si on souhaite des données au département
#' @param regions booléen TRUE si on souhaite des données à la région
#' @param metro booléen TRUE si on souhaite des données France métropolitaine
#' @param metrodrom booléen TRUE si on souhaite des données France métropolitaine et des DROM
#' @param franceprovince booléen TRUE si on souhaite des données France de province
#' @param drom booléen TRUE si on souhaite des données Départements et régions d'outre mer
#' @param as_df booléen TRUE si on souhaite des données sous un seul dataframe, FALSE si on souhaite une liste de dataframe par type de zone
#' @param na.rm argument(s) passé(s) à la fonction d'aggrégation (sum), na.rm=F par défaut
#'
#' @return Renvoie un dataframe ou une liste de dataframe
#' @export
#' @importFrom dplyr filter mutate select group_by summarise ungroup across bind_rows vars
#' @importFrom rlang enquo !!

cogifier<-function(.data,code_commune=DEPCOM,
                   communes=T,
                   epci=T,
                   departements=T,
                   regions=T,
                   metro=T,
                   metrodrom=F,
                   franceprovince=F,
                   drom=F,
                   as_df=T,
                   na.rm = FALSE){
  quo_code_commune<-enquo(code_commune)
  au_cog<-passer_au_cog_a_jour(.data=.data,code_commune=!!quo_code_commune,
                               garder_info_supra = T, aggrege = F,na.rm = na.rm)
  c <- NULL
  e <- NULL
  d <- NULL
  r <- NULL
  m <- NULL
  md <- NULL
  fp <- NULL
  dr <- NULL
  if (communes==T) {
    c<-au_cog %>%
      select(-REG,-NOM_REG,-DEP,-NOM_DEP,-EPCI,-NOM_EPCI,-DEPARTEMENTS_DE_L_EPCI,-REGIONS_DE_L_EPCI) %>%
      group_by(across(!tidyselect::vars_select_helpers$where(is.numeric))) %>%
      summarise(across(.fns = ~ sum(.x, na.rm = na.rm))) %>%
      ungroup
  }
  if (epci==T) {
    e<-au_cog %>%
      select(-REG,-NOM_REG,-DEP,-NOM_DEP,-DEPCOM,-NOM_DEPCOM,-DEPARTEMENTS_DE_L_EPCI,-REGIONS_DE_L_EPCI) %>%
      filter(EPCI!="ZZZZZZZZZ") %>%
      group_by(across(!tidyselect::vars_select_helpers$where(is.numeric))) %>%
      summarise(across(.fns = ~ sum(.x, na.rm = na.rm))) %>%
      ungroup
  }
  if (departements==T) {
    d<-au_cog %>%
      select(-REG,-NOM_REG,-DEPCOM,-NOM_DEPCOM,-EPCI,-NOM_EPCI,-DEPARTEMENTS_DE_L_EPCI,-REGIONS_DE_L_EPCI) %>%
      group_by(across(!tidyselect::vars_select_helpers$where(is.numeric))) %>%
      summarise(across(.fns = ~ sum(.x, na.rm = na.rm))) %>%
      ungroup
  }
  if (regions==T) {
    r<-au_cog %>%
      select(-DEP,-NOM_DEP,-DEPCOM,-NOM_DEPCOM,-EPCI,-NOM_EPCI,-DEPARTEMENTS_DE_L_EPCI,-REGIONS_DE_L_EPCI) %>%
      group_by(across(!tidyselect::vars_select_helpers$where(is.numeric))) %>%
      summarise(across(.fns = ~ sum(.x, na.rm = na.rm))) %>%
      ungroup
  }
  if(metro==T) {
    m<-au_cog %>%
      dplyr::filter(!(REG %in% c("01","02","03","04","05","06"))) %>%
      select(-REG,-NOM_REG,-DEP,-NOM_DEP,-DEPCOM,-NOM_DEPCOM,-EPCI,-NOM_EPCI,-DEPARTEMENTS_DE_L_EPCI,-REGIONS_DE_L_EPCI) %>%
      group_by(across(!tidyselect::vars_select_helpers$where(is.numeric))) %>%
      summarise(across(.fns = ~ sum(.x, na.rm = na.rm))) %>%
      ungroup
  }
  if(metrodrom==T) {
    md<-au_cog %>%
      select(-REG,-NOM_REG,-DEP,-NOM_DEP,-DEPCOM,-NOM_DEPCOM,-EPCI,-NOM_EPCI,-DEPARTEMENTS_DE_L_EPCI,-REGIONS_DE_L_EPCI) %>%
      group_by(across(!tidyselect::vars_select_helpers$where(is.numeric))) %>%
      summarise(across(.fns = ~ sum(.x, na.rm = na.rm))) %>%
      ungroup
  }
  if(franceprovince==T) {
    fp <- au_cog %>%
      dplyr::filter(!(REG %in% c("01","02","03","04","05","06","11"))) %>%
      select(-REG,-NOM_REG,-DEP,-NOM_DEP,-DEPCOM,-NOM_DEPCOM,-EPCI,-NOM_EPCI,-DEPARTEMENTS_DE_L_EPCI,-REGIONS_DE_L_EPCI) %>%
      group_by(across(!tidyselect::vars_select_helpers$where(is.numeric))) %>%
      summarise(across(.fns = ~ sum(.x, na.rm = na.rm))) %>%
      ungroup
  }
  if(drom == T) {
    dr <- au_cog %>%
      dplyr::filter(REG %in% c("01","02","03","04","05","06")) %>%
      select(-REG,-NOM_REG,-DEP,-NOM_DEP,-DEPCOM,-NOM_DEPCOM,-EPCI,-NOM_EPCI,-DEPARTEMENTS_DE_L_EPCI,-REGIONS_DE_L_EPCI) %>%
      group_by(across(!tidyselect::vars_select_helpers$where(is.numeric))) %>%
      summarise(across(.fns = ~ sum(.x, na.rm = na.rm))) %>%
      ungroup
  }


  result<-list("communes"=c,"epci"=e,"departements"=d,"regions"=r,"metro"=m,"metrodrom"=md,"franceprovince"=fp,"drom"=dr)

  if (as_df==T) {
    result<-cog_list_to_df(result)
  }

  return(result)
}
