#!/bin/bash
echo "Bonjour $USER"
echo "Pouvez vous nous donner la liste des etudiants s'il vous plait" 
while ["$n" != "0"]
do
    read -p "Nom: " Nom 
    read -p "Mot de passe: " passe 
    read -p "Departement: " Departement 
    if ["$Departement" == "info"]
    then 
        infoarray=('Nom:'$Nom  '/Mot de passe:'$passe  '/Departement: '$Departement) 

    elif ["$Departement" == "Electique"]
    then    
        elecarray=('Nom:'$Nom  '/Mot de passe:'$passe  '/Departement: '$Departement)
    else   
        civiloarray=('Nom:'$Nom  '/Mot de passe:'$passe  '/Departement: '$Departement)
    fi
    read -p "Voulez vous continuez: 1 oui / 0 non: " n
done

if ["$n" == "0"]
then
    echo -e ${infoarray[@]}
    echo -e ${elecarray[@]}
    echo -e ${civilarray[@]}
fi
 
